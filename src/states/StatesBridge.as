package states 
{
	import citrus.core.IState;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class StatesBridge 
	{
		
		public var state:IState;
		
		public function StatesBridge(target:IState) 
		{
			state = target;
		}
		
		public function changeState(newState:Class):void
		{
			state = new newState;
		}
		
	}

}