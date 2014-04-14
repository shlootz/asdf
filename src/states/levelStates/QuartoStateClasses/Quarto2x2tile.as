package states.levelStates.QuartoStateClasses 
{
	import bridge.GenericSprite;
	import com.greensock.easing.Elastic;
	import com.greensock.TweenLite;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Quarto2x2tile extends GenericSprite
	{
		
		public function Quarto2x2tile(texture:Texture) 
		{
			var offsetX:uint = 0;
			var offsetY:uint = 0;
			
			for (var i:uint = 0; i < 4; i++ )
			{
					var image:Image = new Image(texture);
					if (i == 0)
					{
						image.x = 0;
						image.y = 0;
					}
					if (i == 1)
					{
						image.x = -33;
						image.y = 17;
					}
					if (i == 2)
					{
						image.x = 33;
						image.y = 17;
					}
					if (i == 3)
					{
						image.x = 0;
						image.y = 34;
					}
					addChild(image);
				}
				//this.flatten();
			}
		
	}

}