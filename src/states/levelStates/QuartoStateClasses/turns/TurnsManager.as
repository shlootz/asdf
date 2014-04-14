package states.levelStates.QuartoStateClasses.turns 
{
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class TurnsManager 
	{
		
		private var _turnOne:TurnPlayerOne = new TurnPlayerOne();
		private var _turnTwo:TurnPlayerTwo = new TurnPlayerTwo();
		private var _currentTurn:Turn;
		
		public function TurnsManager() 
		{
			_currentTurn = _turnOne as Turn;
		}
		
		public function changeTurn():void
		{
			if (_currentTurn == _turnOne as Turn)
			{
				_currentTurn = _turnTwo as Turn;
			}
			else
			{
				_currentTurn = _turnOne as Turn;
			}
		}
		
		public function get currentTurn():Turn
		{
			return _currentTurn;
		}
		
	}

}