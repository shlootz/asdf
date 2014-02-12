package states.menuStates 
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.displaylist.VirtualJoystick;
	import citrus.input.controllers.gamepad.controls.ButtonController;
	import citrus.input.controllers.gamepad.Gamepad;
	import citrus.input.controllers.starling.VirtualButton;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	import controller.MyButton;
	import controller.MyJoystick;
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
	import nape.geom.Vec2;
	import nape.geom.Vec3;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class MainMenuState extends StarlingState
	{
		private var button:Button; 
		private var characterPhysics:Body;
		
		public function MainMenuState() 
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			new MetalWorksMobileTheme();
			
			var nape:Nape = new Nape("asd");
			//nape.visible = true;
			add(nape);
			
			var vj:MyJoystick = new MyJoystick("joy", { radius:120, defaultChannel:1 } );
			var vb:MyButton = new MyButton("jump", { radius:120, defaultChannel:1, x:stage.stageWidth, y:stage.stageHeight, buttonradius:100, buttonAction:"jump"} ); 
			
			//button = new Button();
			//button.label = "START";
			//button.setSize(100, 100);
			//button.x = 200;
			//button.y = 150;
			//this.addChild( button );
			
			var groundTexture:Texture = Texture.fromTexture(Main.assetManager.getTexture("ground"));
			var groundTiledImage:TiledImage = new TiledImage(groundTexture, 1);
			groundTiledImage.width = 490;
			groundTiledImage.height = 35;
			
			var wallTexture:Texture = Texture.fromTexture(Main.assetManager.getTexture("ground_cave"));
			var wallTiledImage:TiledImage = new TiledImage(wallTexture, 1);
			wallTiledImage.width = 35;
			wallTiledImage.height = 490;
			
			var wallTexture2:Texture = Texture.fromTexture(Main.assetManager.getTexture("ground_dirt"));
			var wallTiledImage2:TiledImage = new TiledImage(wallTexture2, 1);
			wallTiledImage2.width = 35;
			wallTiledImage2.height = 490;
			
			add(new Platform("bottom", {x:stage.stageWidth / 2, y:stage.stageHeight, width:stage.stageWidth, view:groundTiledImage}));
			add(new Platform("left", {x:0, y:stage.stageHeight / 2, width:30, height:stage.stageHeight, view:wallTiledImage}));
			add(new Platform("right", {x:stage.stageWidth, y:stage.stageHeight / 2, width:30, height:stage.stageHeight, view:wallTiledImage2}));
			
			var hero:MyHero = new MyHero("hero", { x:100, y:200, width:50, height:50 } );
			add(hero);
			
			view.camera.setUp(hero, new Rectangle(0, 0, 1000000, 1000), new Point(.5, .5));
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
	
	}

}