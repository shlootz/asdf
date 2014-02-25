package hero 
{
	import citrus.core.IState;
	import citrus.objects.platformer.nape.Hero;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import input.MobileInput;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import starling.display.Image;
	import starling.display.MovieClip;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class MyHero extends Hero
	{
		public static const STATE_WALKING_LEFT:String = "moving_left";
		public static const STATE_WALKING_RIGHT:String = "moving_right";
		public static const STATE_JUMPING_LEFT:String = "jumping_left";
		public static const STATE_JUMPING_RIGHT:String = "jumping_right";
		public static const STATE_JUMPING_UP:String = "jumping_up";
		public static const STATE_FALLING_DOWNN:String = "falling";
		public static const STATE_FALLING_LEFT:String = "falling_left";
		public static const STATE_FALLING_RIGHT:String = "falling_right";
		public static const STATE_IDLE:String = "idle";
		
		public var inventory:Dictionary = new Dictionary();
		
		private var _mobileInput:MobileInput;
		private var currentState:String = STATE_IDLE;
		private var prevState:String = currentState;
		private var walkAnimation:MovieClip;
		private var jumpImage:Image;
		private var idleImage:Image;
		private var pos:Object = new Object();
		private var sendingStep:int = 0;
		
		private var prevVelocity:Array = new Array();
		private var intermVelocity:Array = new Array(3);
		
		private var prevVeloPoint:Point = new Point();
		private var currVeloPoint:Point = new Point();
		
		private var interPercent:Number;
		
		public function MyHero(name:String,  params:Object=null) 
		{
			super(name, params);
			
			_mobileInput = new MobileInput();
			_mobileInput.initialize();
			
			walkAnimation = new MovieClip(Main.assetManager.getTextures("character_walk"), 30);
			jumpImage = new Image(Main.assetManager.getTexture("character_jump"));
			idleImage = new Image(Main.assetManager.getTexture("character_walk0001"));
			
			this._body = new Body(BodyType.DYNAMIC, new Vec2(150, 0));
			this.view = idleImage;
			this.acceleration = 100;
			this.jumpHeight = 300;
			this.jumpAcceleration = 10;
			this.maxVelocity = 100;
			this.canDuck = false;
		}
		
		/**
		 * 
		 * @param	timeDelta
		 */
		override public function update(timeDelta:Number): void
		{
			super.update(timeDelta);
			
			interPercent = (Main.server.pingDelay) / 100;
			
			if (velocity[0] == 0 && velocity[1] == 0 && velocity[2] == 0)
			{
				currentState = STATE_IDLE;
			}
			
			if (velocity[0] > 0 && velocity[1] == 0)
			{
				currentState = STATE_WALKING_RIGHT;
			}
			
			if (velocity[0] < 0 && velocity[1] == 0)
			{
				currentState = STATE_WALKING_LEFT;
			}
			
			if (velocity[0] > 0 && velocity[1] < 0)
			{
				currentState = STATE_JUMPING_RIGHT;
			}
			
			if (velocity[0] < 0 && velocity[1] < 0)
			{
				currentState = STATE_JUMPING_LEFT;
			}
			
			if (velocity[0] == 0 && velocity[1] < 0)
			{
				currentState = STATE_JUMPING_UP;
			}
			
			if (velocity[0] > 0 && velocity[1] > 0)
			{
				currentState = STATE_FALLING_RIGHT;
			}
			
			if (velocity[0] < 0 && velocity[1] > 0)
			{
				currentState = STATE_FALLING_LEFT;
			}
			
			if (velocity[0] == 0 && velocity[1] > 0)
			{
				currentState = STATE_FALLING_DOWNN;
			}
			
			if (prevState != currentState)
			{
				switch(currentState)
				{
					case STATE_IDLE:
						this.view = idleImage;
						break;
						
					case STATE_WALKING_RIGHT:
						_inverted = false;
						this.view = walkAnimation;
						break;
						
					case STATE_WALKING_LEFT:
						_inverted = true;
						this.view = walkAnimation;	
						break;
						
					case STATE_JUMPING_RIGHT:
						this.view = jumpImage;
						break;
						
					case STATE_JUMPING_LEFT:
						this.view = jumpImage;	
						break;
						
					case STATE_JUMPING_UP:
						this.view = jumpImage;		
						break;
						
					case STATE_FALLING_RIGHT:
						this.view = jumpImage;	
						break;
					
					case STATE_FALLING_LEFT:
						this.view = jumpImage;	
						break;
						
					case STATE_FALLING_DOWNN:
						this.view = jumpImage;	
						break;
				}
				
				prevState = currentState;
				
			}
			
			pos = {
				x:this.x,
				y:this.y
			}
			
			Main.server.sendToServer( { type:"battle", room:Main.server.room, playerIndex:Main.server.player, velocity: { velo:this.velocity, pos:pos }, ping:Main.server.pingDelay} );
			
			prevVelocity = velocity;
		}
		
		/**
		 * 
		 */
		override public function destroy():void 
		{
			_mobileInput.destroy();
			//super.destroy();
		}
		
		/**
		 * 
		 */
		override public function hurt () : void
		{
			
		}
	}

}