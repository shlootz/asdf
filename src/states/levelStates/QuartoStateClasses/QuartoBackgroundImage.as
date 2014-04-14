package states.levelStates.QuartoStateClasses 
{
	import bridge.GenericSprite;
	import feathers.display.TiledImage;
	import starling.display.BlendMode;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class QuartoBackgroundImage extends GenericSprite 
	{
		
		public function QuartoBackgroundImage() 
		{
			var groundTexture:Texture = Texture.fromTexture(Main.assetManager.getTexture("road"));
			var groundTiledImage:TiledImage = new TiledImage(groundTexture, 1);
			groundTiledImage.width = 600;
			groundTiledImage.height = 43;
			
			var groundTexture2:Texture = Texture.fromTexture(Main.assetManager.getTexture("water"));
			var groundTiledImage2:TiledImage = new TiledImage(groundTexture2, 1);
			groundTiledImage2.width = 600;
			groundTiledImage2.height = 40;
			
			groundTiledImage2.x = 33;
			groundTiledImage2.y = 21;
			
			addChild(groundTiledImage);
			addChild(groundTiledImage2);
			
			this.flatten();
			//this.blendMode = BlendMode.NONE;
		}
		
	}

}