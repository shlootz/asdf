package bridge 
{
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class GraphicsEngineBridge 
	{
		
		private static var instance:GraphicsEngineBridge;
		
		/**
		 * 
		 */
		public function GraphicsEngineBridge() 
		{
			
		}
		
		/**
		 * 
		 * @return
		 */
		public static function getInstance():GraphicsEngineBridge
		{
			if (instance == null)
			{
				instance = new GraphicsEngineBridge();
			}
			
			return instance;
		}
		
		/**
		 * 
		 * @return
		 */
		public function requestStaticImage():GenericStaticImage
		{
			return new GenericStaticImage();
		}
		
		/**
		 * 
		 * @return
		 */
		public function requestMovieClip():GenericAnimation
		{
			return new GenericAnimation();
		}
		
		/**
		 * 
		 * @return
		 */
		public function requestQuad():GenericQuad
		{
			return new GenericQuad();
		}
		
		/**
		 * 
		 * @return
		 */
		public function requestStaticImageClass():Class
		{
			return GenericStaticImage
		}
		
		/**
		 * 
		 * @return
		 */
		public function requestMovieClipClass():Class
		{
			return GenericAnimation;
		}
		
		/**
		 * 
		 * @return
		 */
		public function requestQuadClass():Class
		{
			return GenericQuad;
		}
		
	}

}