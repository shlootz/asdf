package states.lobby 
{
	import abstract.AbstractPool;
	import citrus.core.starling.StarlingState;
	import feathers.controls.Alert;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.osflash.signals.Signal;
	import server.serverBridge.ServerMessageTemplate;
	import signals.Signals;
	import signals.SignalsHub;
	import states.AllStates;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class LobbyState extends StarlingState
	{
		
		private var _pendingTime:uint;
		
		public function LobbyState() 
		{
			super();
		}
		
		/**
		 * 
		 */
		override public function initialize():void
		{
			super.initialize();
			
			var alert:Alert = new Alert();
			alert.x = 150;
			alert.y = 150;
			alert.message = "Looking for players";
			addChild(alert);
			
			var lobbyListeners:Vector.<Function> = new Vector.<Function>;
			lobbyListeners.push(foundPlayer);
			SignalsHub.getInstance().addSignal(Signals.PLAYER_FOUND, new Signal(), lobbyListeners);
			
			Main.server.sendToServer(ServerMessageTemplate.getServerMessageTemplate('onLookingForPlayers', {timeout:0} ));
		}
		
		/**
		 * 
		 * @param	msg
		 * @param	data
		 */
		private function foundPlayer(msg:String, data:Object):void
		{
			SignalsHub.getInstance().dispatchSignal(Signals.CHANGE_GAME_STATE, Signals.CHANGE_GAME_STATE, AllStates.ARENA_STATE);
		}
		 
	}

}