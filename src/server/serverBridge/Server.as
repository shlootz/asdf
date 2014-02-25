package server.serverBridge 
{
	import com.pnwrain.flashsocket.events.FlashSocketEvent;
	import flash.utils.setInterval;
	import flash.utils.SetIntervalTimer;
	import flash.utils.Timer;
	import signals.Signals;
	import signals.SignalsHub;
	import states.AllStates;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Server extends ServerBridge
	{
		
		public var id:String;
		public var player:String;
		public var room:Object;
		public var pingDelay:Number = 0;
		public var enemyDelay:Number = 0;
		
		private var _sendPingInterval:uint;
		
		private var _sendDate:Date;
		private var _receivedDate:Date;
		
		//public function 
		/**
		 * 
		 */
		public function Server() 
		{
			
		}
		
		override public function connect(address:String):void
		{
			super.connect(address);
		}
		
		/**
		 * 
		 */
		override protected function onConnect(event:FlashSocketEvent):void
		{
			super.sendToServer(ServerMessageTemplate.getServerMessageTemplate("onConnect", { nickname:"nick" + Math.round(Math.random() * 99999) } ));
			_sendPingInterval = setInterval(sendPing, 1000);
		}
		
		override protected function onMessage(event:FlashSocketEvent):void
		{
			var type:String = event.data[0]["type"];
			
			switch(type)
			{
				case "onConnect":
					id = event.data[0]["data"]["data"];
					break;
					
				case "ping":
					pingReceived();
					break;
					
				case "onLookingForPlayers":
					room = event.data[0]["data"]["data"];
					
					if (room == id)
					{
						player = "1";
					}
					else
					{
						player = "2";
					}
					SignalsHub.getInstance().dispatchSignal(Signals.PLAYER_FOUND, Signals.PLAYER_FOUND, event.data[0]);
					break;
					
				case "onArenaInitRequest":
					SignalsHub.getInstance().dispatchSignal(Signals.ARENA_INIT, Signals.ARENA_INIT, event.data[0]);
					break;	
					
				case "onEnemyMoving":
					enemyDelay = event.data[0]["ping"];
					
					SignalsHub.getInstance().dispatchSignal(Signals.ENEMY_MOVING, Signals.ENEMY_MOVING, event.data[0]);
					trace("enemyDelay "+enemyDelay);
					break;	
					
				case "disconnectingRoom":
					trace("ENEMY DISCONNECT CAUGHT");
					break;
			}
		}
		
		/**
		 * 
		 */
		private function sendPing():void
		{
			sendToServer(ServerMessageTemplate.getServerMessageTemplate("ping", null));
			_sendDate = new Date();
		}
		
		/**
		 * 
		 */
		private function pingReceived():void
		{
			_receivedDate = new Date();
			pingDelay = (_receivedDate.getSeconds() * 1000 + _receivedDate.getMilliseconds()) - 
						(_sendDate.getSeconds() * 1000 + _sendDate.getMilliseconds());
		}
		
	}

}