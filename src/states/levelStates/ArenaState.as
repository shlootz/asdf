package states.levelStates 
{
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	import controller.MyButton;
	import controller.MyJoystick;
	import enemy.MyEnemy;
	import feathers.controls.Label;
	import feathers.display.TiledImage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import hero.MyHero;
	import org.osflash.signals.Signal;
	import server.serverBridge.ServerBridge;
	import server.serverBridge.ServerMessageTemplate;
	import signals.Signals;
	import signals.SignalsHub;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class ArenaState extends StarlingState
	{
		private var _heroOnStage:Boolean = false;
		private var _myEnemy:MyEnemy;
		private var _latencyLabel:Label = new Label();
		
		/**
		 * 
		 */
		public function ArenaState() 
		{
			super();
		}
		
		/**
		 * 
		 */
		override public function initialize():void
		{
			super.initialize();
			
			//Let the server know that the player with id XXX is ready to begin game
			
			var arenaListeners:Vector.<Function> = new Vector.<Function>;
			arenaListeners.push(arenaInit);
			
			SignalsHub.getInstance().addSignal(Signals.ARENA_INIT, new Signal(), arenaListeners);
			
			Main.server.sendToServer(ServerMessageTemplate.getServerMessageTemplate('onArenaInitRequest', { room:Main.server.room, id:Main.server.id, nickname:Main.server.player } ));
		}	
		
		/**
		 * 
		 * @param	msg
		 * @param	data
		 */
		private function arenaInit(msg:String, data:Object):void
		{
			if (!_heroOnStage)
			{
				createHero(data);
				createEnemy(data)
				_heroOnStage = true;
			}
		}
		
		/**
		 * 
		 */
		private function createHero(data:Object):void
		{
			var myX:uint = 0;
			var myY:uint = 0;
			
			myX = uint(data["data"]["player" + Main.server.player]["posX"]);
			myY = uint(data["data"]["player" + Main.server.player]["posY"]);
			
			var nape:Nape = new Nape("asd");
			//nape.visible = true;
			this.add(nape);
			
			var vj:MyJoystick = new MyJoystick("joy", { radius:120, defaultChannel:1, container:this, viewknob:Main.assetManager.getTexture("ground"), viewback:Main.assetManager.getTexture("ground"), radius:5 } );
			var vb:MyButton = new MyButton("jump", { radius:120, defaultChannel:1, x:stage.stageWidth, y:stage.stageHeight, buttonradius:100, buttonAction:"jump" } ); 
			
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
			
			var mhero:MyHero = new MyHero("hero", { x:myX, y:myY, width:50, height:50 } );
			add(mhero);
			
			view.camera.setUp(mhero, new Rectangle(0, 0, 1000000, 1000), new Point(.5, .5));
			
			_latencyLabel.x = 0;
			_latencyLabel.y = 300;
			
			this.addChild(_latencyLabel);
		}
		
		/**
		 * 
		 */
		private function createEnemy(data:Object):void
		{
			var characterIndex:String = "";
			if (Main.server.player == "1")
			{
				characterIndex = "2";
			}
			else
			{
				characterIndex = "1";
			}
			var myX:uint = 0;
			var myY:uint = 0;
			
			myX = uint(data["data"]["player" + characterIndex]["posX"]);
			myY = uint(data["data"]["player" + characterIndex]["posY"]);
			
			var enemyCallBacks:Vector.<Function> = new Vector.<Function>;
			enemyCallBacks.push(updateEnemy);
			SignalsHub.getInstance().addSignal(Signals.ENEMY_MOVING, new Signal(), enemyCallBacks);
			
			_myEnemy = new MyEnemy("enemy", { x:myX, y:myY, width:50, height:50 } );
			add(_myEnemy);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	data
		 */
		private function updateEnemy(type:String, data:Object):void
		{
			_myEnemy.updateProperties(data);
		}
		
		/**
		 * 
		 * @param	timeDelta
		 */
		override public function update (timeDelta:Number) : void
		{
			super.update(timeDelta);
			
			_latencyLabel.text = String(Main.server.pingDelay);
		}
		
	}

}