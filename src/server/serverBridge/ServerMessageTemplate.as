package server.serverBridge 
{
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class ServerMessageTemplate 
	{
		
		/**
		 * 
		 * @param	type
		 * @param	data
		 * @return
		 */
		public static function getServerMessageTemplate(type:String, data:Object):Object
		{
			return {
				type:type,
				data:data
			}
		}
		
	}

}