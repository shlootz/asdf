package states.levelStates.QuartoStateClasses 
{
	import abstract.AbstractPool;
	import bridge.GenericSprite;
	import managers.AssetsManager;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Piece extends GenericSprite
	{
		
		public function Piece(textureName:String) 
		{
				var texture:Texture = Texture.fromTexture(Main.assetManager.getTexture(textureName));
				var image:Image = new Image(texture);
				
				addChild(image);
		}
		
	}

}