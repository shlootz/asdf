package states.menuStates 
{
	import citrus.core.CitrusEngine;
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.displaylist.VirtualJoystick;
	import citrus.input.controllers.gamepad.controls.ButtonController;
	import citrus.input.controllers.gamepad.Gamepad;
	import citrus.input.controllers.starling.VirtualButton;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.Platform;
	import citrus.objects.platformer.simple.DynamicObject;
	import citrus.physics.nape.Nape;
	import controller.MyButton;
	import controller.MyJoystick;
	import enemy.MyEnemy;
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.GroupedList;
	import feathers.controls.Label;
	import feathers.display.TiledImage;
	import feathers.themes.MetalWorksMobileTheme;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.GameInputDevice;
	import hero.MyHero;
	import nape.geom.GeomPoly;
	import nape.geom.Vec2;
	import nape.geom.Vec3;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	import signals.Signals;
	import signals.SignalsHub;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import states.AllStates;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class MainMenuState extends StarlingState
	{
		private var button:Button; 
		
		/**
		 * 
		 */
		public function MainMenuState() 
		{
			super();
		}
		
		/**
		 * 
		 */
		override public function initialize():void
		{
			super.initialize();
			
			button = new Button();
			button.label = "Enter Lobby";
			button.setSize(100, 100);
			button.x = 200;
			button.y = 150;
			this.addChild( button );
			
			button.addEventListener(Event.TRIGGERED, buttonPressed);
		}
		
		/**
		 * 
		 * @param	timeDelta
		 */
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function buttonPressed(e:Event):void
		{
			SignalsHub.getInstance().dispatchSignal(Signals.CHANGE_GAME_STATE, Signals.CHANGE_GAME_STATE, AllStates.LOBBY_STATE)
		}
	
	}

}