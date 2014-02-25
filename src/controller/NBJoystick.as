package controller
{
	import flash.geom.Point;
 
	import citrus.input.InputController;
 
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
 
	public class NBJoystick extends InputController
	{
		protected var container:Sprite;
		protected var viewknob:Image;
		protected var viewback:Image;
		protected var view:Sprite;
		protected var pointA:Point = new Point();
		protected var pointB:Point = new Point();
		protected var touch_id:int = -1;
		protected var radius:Number;
 
		public function NBJoystick(name:String, params:Object=null)
		{
			super(name, params);
			this.container 	= params.container || null;
			this.viewknob	= new Image(params.viewknob) || null;
			this.viewback	= new Image(params.viewback) || null;
			this.radius		= params.radius || 50;
			this.init();
		}
		protected function init():void
		{
			this.draw();
			this.container.stage.addEventListener(TouchEvent.TOUCH, touch_handler);
		}
		private function touch_handler(event:TouchEvent):void
		{
			var began:Touch = event.getTouch( event.currentTarget as DisplayObject, TouchPhase.BEGAN);
			var moved:Touch = event.getTouch( event.currentTarget as DisplayObject, TouchPhase.MOVED, this.touch_id);
			var ended:Touch = event.getTouch( event.currentTarget as DisplayObject, TouchPhase.ENDED, this.touch_id);
			var difX:Number, difY:Number;
			if (began)
			{
				if (began.globalX< this.container.stage.stageWidth>>1 )
				{
					this.pointA.x = began.globalX;
					this.pointA.y = began.globalY;
					this.touch_id = began.id;
					this.view.visible = true;
					this.view.x 	= began.globalX;
					this.view.y		= began.globalY;
					this.viewknob.x = 0;
					this.viewknob.y = 0;
				}
			}
			if (moved && moved.id == this.touch_id )
			{
				this.pointB.x 	= moved.globalX;
				this.pointB.y 	= moved.globalY;
				difX = this.pointB.x - this.pointA.x;
				difY = this.pointB.y - this.pointA.y;
				if (difX> this.radius) difX= this.radius;
				if (difX<-this.radius) difX=-this.radius;
				if (difY> this.radius) difY= this.radius;
				if (difY<-this.radius) difY=-this.radius;
				this.viewknob.x= difX;
				this.viewknob.y= difY;
				this.eval_axis(difX, difY);
			}
			if (ended && ended.id == this.touch_id )
			{
				this.view.visible = false;
				this.touch_id = -1;
				this.triggerOFF('right');
				this.triggerOFF('left');
			}
		}
 
		protected function eval_axis(x:Number,y:Number):void
		{
			if ( x < -this.radius/50 )
			{
				this.triggerOFF('right');
				this.triggerON('left');
			}
			else if ( x > this.radius/50 )
			{
				this.triggerOFF('left');
				this.triggerON('right');
			}
			else
			{
				this.triggerOFF('right');
				this.triggerOFF('left');
			}
		}
		private function draw():void
		{
			this.view	= new Sprite();
			if (this.viewback)
			{
				this.viewback.pivotX = this.viewback.width>>1;
				this.viewback.pivotY = this.viewback.height>>1;
				this.view.addChild(this.viewback);
			}
			if (this.viewknob)
			{
				this.viewknob.pivotX = this.viewknob.width>>1;
				this.viewknob.pivotY = this.viewknob.height>>1;
				this.view.addChild(this.viewknob);
			}
			this.container.addChild( this.view );
			this.view.visible = false;
		}
	}
}