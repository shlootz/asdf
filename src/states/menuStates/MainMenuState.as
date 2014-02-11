package states.menuStates 
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.GroupedList;
	import feathers.controls.Label;
	import feathers.themes.MetalWorksMobileTheme;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class MainMenuState extends StarlingState
	{
		private var button:Button; 
		public function MainMenuState() 
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			new MetalWorksMobileTheme();
			
			button = new Button();
			button.label = "START";
			button.setSize(100, 100);
			button.x = 200;
			button.y = 150;
			this.addChild( button );
			
			var characterMc:MovieClip = new MovieClip(Main.assetManager.getTextures("character_walk"), 30);
			characterMc.x = 200;
			characterMc.y = 100;
			this.addChild(characterMc);
			Main.juggler.add(characterMc);
			characterMc.play();
		}
	
	}

}