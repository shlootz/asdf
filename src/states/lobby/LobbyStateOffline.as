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
	public class LobbyStateOffline extends StarlingState
	{
		
		private var _pendingTime:uint;
		
		public function LobbyStateOffline() 
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
			alert.message = "CONNECTION ERROR";
			addChild(alert);
		}
		 
	}

}