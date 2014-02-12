package controller 
{
	import citrus.input.controllers.displaylist.VirtualJoystick;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class MyJoystick extends VirtualJoystick
	{
		
		public function MyJoystick(name:String, params:Object = null) 
		{
			super(name, params);
			removeAxisAction("Y", "jump");
			
			addAxisAction("x", "left", -1, -0.3);
			addAxisAction("x", "right", 0.3, 1);
		}
	}

}