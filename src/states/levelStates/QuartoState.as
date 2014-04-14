package states.levelStates 
{
	import citrus.core.starling.StarlingState;
	import feathers.display.TiledImage;
	import flash.geom.Rectangle;
	import org.osflash.signals.Signal;
	import signals.SignalsHub;
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.QuadtreeSprite;
	import starling.textures.Texture;
	import states.levelStates.QuartoStateClasses.Piece;
	import states.levelStates.QuartoStateClasses.QuartoBackgroundImage;
	import states.levelStates.QuartoStateClasses.QuartoGrid;
	import states.levelStates.QuartoStateClasses.turns.TurnsManager;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class QuartoState extends StarlingState
	{
		
		private var _juggler:Juggler = Main.juggler;
		private var _signals:SignalsHub = SignalsHub.getInstance();
		private var _step:Number = 0;
		private var _gridImage:QuartoGrid = new QuartoGrid();
		private var _backgroundImage:QuartoBackgroundImage = new QuartoBackgroundImage();
		private var _pieces:Vector.<Piece> = new Vector.<Piece>;
		private var _turnsManager:TurnsManager = new TurnsManager();
		private var _spriteTree:QuadtreeSprite = new QuadtreeSprite(new Rectangle(0, 0, 480, 320));
		
		public function QuartoState() 
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			addChild(_spriteTree);
			_spriteTree.addChild(_backgroundImage);
			_spriteTree.addChild(_gridImage);
			
			addEventListener(Event.ENTER_FRAME, step);
		}
		
		private function entitySort(a:DisplayObject, b:DisplayObject):int 
		{
			if (a.y > b.y)
				return 1;
			else (a.y < b.y)
				return -1;
		}
				
		private function step():void
		{
			this.sortChildren(entitySort);
		}
		
		private function makePieces():void
		{
			for (var i:uint = 0; i < 16; i++ )
			{
				_pieces.push(new Piece("treeTall"));
			}
		}
		
	}
	
}