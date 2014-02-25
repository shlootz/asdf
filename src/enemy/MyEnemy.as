package enemy 
{
	import citrus.datastructures.PoolObject;
	import citrus.objects.platformer.nape.Enemy;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import starling.display.Image;
	import starling.display.MovieClip;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class MyEnemy extends Enemy
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
		
		private var currentState:String = STATE_IDLE;
		private var prevState:String = currentState;
		
		private var walkAnimation:MovieClip;
		private var jumpImage:Image;
		private var idleImage:Image;
		private var bufferedData:Vector.<Object> = new Vector.<Object>;
		private var bufferDelay:uint = 0;
		private var updateEnabled:Boolean = false;
		
		private var interPercent:Number;
		
		private var currPos:Point = new Point();
		private var pos1:Point = new Point();
		private var posGhost:Point = new Point();
		private var pos2:Point = new Point();
		
		private var currVelo:Point = new Point();
		private var velo1:Point = new Point();
		private var veloGhost:Point = new Point();
		private var velo2:Point = new Point();
		
		private var intermVelo:Array = new Array(3);
		
		public function MyEnemy(name:String, params:Object) 
		{
			super(name, params);
			
			walkAnimation = new MovieClip(Main.assetManager.getTextures("character_walk"), 30);
			jumpImage = new Image(Main.assetManager.getTexture("character_jump"));
			idleImage = new Image(Main.assetManager.getTexture("character_walk0001"));
			
			this._body = new Body(BodyType.DYNAMIC, new Vec2(150, 0));
			this.view = idleImage;
			
			//bufferDelay = setInterval(enableUpdate, Main.server.pingDelay);
		}
		
		/**
		 * 
		 * @param	timeDelta
		 */
		override public function update(timeDelta:Number): void
		{
			interPercent = (Main.server.pingDelay) / 100;
			var bData:Object;
			
			//if(updateEnabled)
			//{
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
					
					updateEnabled = false;
				}
				
				if (bufferedData.length >= 60)
				{
					bData =  bufferedData[bufferedData.length - 2];
					
					pos1.x = this.x;
					pos1.y = this.y;
					
					pos2.x = bData["data"]["pos"]["x"] as Number;
					pos2.y = bData["data"]["pos"]["y"] as Number;
					
					velo1.x = velocity[0];
					velo1.y = velocity[1];
					
					velo2.x = (bData["data"]["velo"] as Array)[0];
					velo2.y = (bData["data"]["velo"] as Array)[1];
					
					veloGhost.x = Point.interpolate(velo1, velo2, interPercent).x;
					veloGhost.y = Point.interpolate(velo1, velo2, interPercent).y;
					//
					posGhost.x= Point.interpolate(pos1, pos2, interPercent).x;
					posGhost.y = Point.interpolate(pos1, pos2, interPercent).y;
					//
					currPos.x = this.x;
					currPos.y = this.y;
					//
					currVelo.x = velocity[0];
					currVelo.y = velocity[1];
					//
					intermVelo[0] = Point.interpolate(currVelo, veloGhost, timeDelta).x;
					intermVelo[1] = Point.interpolate(currVelo, veloGhost, timeDelta).y;
						
					this.velocity = intermVelo;
						
					this.x = Point.interpolate(currPos, posGhost, timeDelta).x;
					this.y = Point.interpolate(currPos, posGhost, timeDelta).y;
				}
		}
		
		/**
		 * 
		 */
		override public function destroy():void 
		{
			super.destroy();
		}
		
		/**
		 * 
		 * @param	data
		 */
		public function updateProperties(data:Object):void
		{
			bufferedData.push(data);
			
			if (bufferedData.length >= 100)
				{
					bufferedData.splice(0, 1);
				}
				
			trace(bufferedData.length);
		}
		
		/**
		 * 
		 */
		private function enableUpdate():void
		{
			updateEnabled = true;
		}
	}

}