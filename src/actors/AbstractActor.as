package actors 
{
	import bridge.GenericAnimation;
	import bridge.GenericDrawable;
	import bridge.GenericStaticImage;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class AbstractActor extends GenericDrawable
	{
		
		public var graphics:Dictionary = new Dictionary(true)
		
		public function AbstractActor() 
		{
			
		}
		
		public function addAnimation(animationID:String, animation:GenericAnimation):void
		{
			graphics[animationID] = animation;
		}
		
		public function addStaticImage(imageID:String, image:GenericStaticImage):void
		{
			graphics[imageID] = image;
		}
		
	}

}