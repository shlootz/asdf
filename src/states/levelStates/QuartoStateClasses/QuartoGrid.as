package states.levelStates.QuartoStateClasses 
{
	import bridge.GenericSprite;
	import com.greensock.easing.Elastic;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class QuartoGrid extends GenericSprite
	{
		
		public function QuartoGrid() 
		{
			this.touchable = true;
			
			var stepUp:uint = 0;
			var stepDown:uint = 4;
			var tile:Quarto2x2tile;
			var texture1:Texture = Texture.fromTexture(Main.assetManager.getTexture("grass"));
			var texture2:Texture = Texture.fromTexture(Main.assetManager.getTexture("water"));
			var offsetX:uint = 0;
			var offsetY:uint = 0;
			
			for (var i:uint = 0; i < 4; i++ )
			{
				stepUp ++ 
				for (var j:uint = 0; j < stepUp; j++ )
				{
					tile = new Quarto2x2tile(texture1);
					tile.touchable = true;
					tile.addEventListener(TouchEvent.TOUCH, onTouchTile);
					addChild(tile);
					tile.x = 265 + tile.width * j - 66*stepUp;
					tile.y = tile.height * stepUp - stepUp * 44;
				}
			}
			
			for (var m:uint = 4; m > 0; m-- )
			{
				stepUp ++
				stepDown--
				for (var n:uint = 0; n < stepDown; n++ )
				{
					tile = new Quarto2x2tile(texture1);
					tile.touchable = true;
					tile.addEventListener(TouchEvent.TOUCH, onTouchTile);
					addChild(tile);
					tile.x = 265 + tile.width * n - 66*stepDown;
					tile.y = tile.height * stepUp - stepUp * 44;
				}
			}
		}
		
		private function onTouchTile(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				var prevY:int = touch.target.y;
				touch.target.y = touch.target.y + 20
				TweenLite.to(touch.target, 1, {y:prevY, ease:Elastic.easeOut})
			}
		}
		
	}

}