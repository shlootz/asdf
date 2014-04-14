package states.menuStates 
{
	import citrus.core.starling.StarlingState;
	import feathers.controls.Alert;
	import feathers.themes.MetalWorksMobileTheme;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class LoadingState extends StarlingState
	{
		
		public function LoadingState() 
		{
			
		}
		
		override public function initialize():void
		{
			super.initialize();
			//
			//var alert:Alert = new Alert();
			//alert.x = 150;
			//alert.y = 150;
			//alert.message = "Loading";
			//addChild(alert);
		}
		
	}

}