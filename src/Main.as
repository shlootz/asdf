package 
{
	import abstract.AbstractPool;
	import bridge.GenericDrawable;
	import bridge.GraphicsEngineBridge;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.starling.ViewportMode;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filesystem.File;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.getQualifiedClassName;
	import managers.AssetsManager;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.utils.AssetManager;
	import states.AllStates;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Main extends StarlingCitrusEngine 
	{
		public static var assetManager:AssetManager;
		public static var assetsManagerUtil:AssetsManager;
		public static var juggler:Juggler;
		
		private var _imagesPool:AbstractPool;
		private var _animationsPool:AbstractPool;
		private var _quadsPool:AbstractPool;
		
		/**
		 * 
		 */
		public function Main():void 
		{
			_baseWidth = 480;
			_baseHeight = 320;
			_viewportMode = ViewportMode.FULLSCREEN;
			_assetSizes = [1, 1.5, 2, 4, 5];
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			// new to AIR? please read *carefully* the readme.txt files!
		}
		
		/**
		 * 
		 * @param	e
		 */
		override protected function handleAddedToStage(e:Event):void
		{
			super.handleAddedToStage(e);
			createPools();
			initStarling();
		}		
		
		/**
		 * 
		 * @param	e
		 */
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			NativeApplication.nativeApplication.exit();
		}
		
		/**
		 * 
		 */
		private function createPools():void
		{
			_imagesPool = new AbstractPool("staticImagesPool",GraphicsEngineBridge.getInstance().requestStaticImageClass(), 5);
			_animationsPool = new AbstractPool("animationsPool",GraphicsEngineBridge.getInstance().requestMovieClipClass(), 5);
			_quadsPool = new AbstractPool("quadPool", GraphicsEngineBridge.getInstance().requestQuadClass(), 5);
		}
		
		/**
		 * 
		 */
		private function initStarling():void
		{
			setUpStarling(true);
		}
		
		/**
		 * 
		 */
		override public function handleStarlingReady():void
		{
			state = new AllStates.LOADING_STATE;
			
			var appDir:File = File.applicationDirectory;
			assetManager = new AssetManager(scaleFactor);
			assetManager.verbose = true;
			assetManager.enqueue(appDir.resolvePath("assets" + scaleFactor + "x"));
			assetManager.loadQueue(function(ratio:Number):void
				{
					trace("Loading assets, progress:", ratio);
					if (ratio == 1)
					{
						juggler = _starling.juggler;
						state = new AllStates.MAIN_MENU_STATE;
					}
				});
			 
			//HOW TO EXTRACT FROM ASSET MANAGER	
			//new Image( assetManager.getTexture('theimage') );
			//new MovieClip( assetManager.getTextures('prefixName', frameRate));	
		}
		
	}
	
}