package hero 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Hero extends AbstractHero
	{
		
		public var health:Number;
		public var inventory:Dictionary = new Dictionary();
		
		public function Hero() 
		{
			restoreInventoryFromLocal();
		}
		
		private function restoreInventoryFromLocal():void
		{
			//inventory["head"]
			//inventory["shoulders"]
			//inventory["chest"]
			//inventory["bracers"]
			//inventory["boots"]
			//inventory["weapon_hand_1"]
			//inventory["weapon_hand_2"]
			//inventory["weapon_2_hands"]
			//inventory["shield"]
			//inventory["minions"]
		}
		
	}

}