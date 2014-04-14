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
			_currentTurn = _turnOne;
		}
		
		public function changeTurn():void
		{
			if (_currentTurn == _turnOne)
			{
				_currentTurn = _turnTwo;
			}
			else
			{
				_currentTurn = _turnOne;
			}
		}
		
		public function get currentTurn():Turn
		{
			return _currentTurn;
		}
		
	}

}