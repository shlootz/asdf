package states.levelStates 
{
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	import controller.MyButton;
	import controller.MyJoystick;
	import enemy.MyEnemy;
	import feathers.display.TiledImage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import hero.MyHero;
	import org.osflash.signals.Signal;
	import signals.Signals;
	import signals.SignalsHub;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class BattleState extends StarlingState
	{
		
		private var myenemy:MyEnemy;
		private var battleReadyToBegin:Boolean = false;
		
		/**
		 * 
		 */
		public function BattleState() 
		{
			super();
		}
		
		/**
		 * 
		 */
		override public function initialize():void
		{
			super.initialize();
			trace("IN BATTLE");
		}	
		
		/**
		 * 
		 * @param	type
		 */
		public function addEnemy(type:String):void
		{
			if (battleReadyToBegin)
			{
				myenemy = new MyEnemy("enemy", { x:300, y:200, width:50, height:50 } );
				add(myenemy);
			}
		}
		
		/**
		 * 
		 * @param	type
		 * @param	data
		 */
		public function updateEnemy(type:String, data:Object):void
		{
			if (battleReadyToBegin)
			{
				myenemy.updateProperties(data);
			}
		}
		
	}

}