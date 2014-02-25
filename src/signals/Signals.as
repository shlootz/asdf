package signals 
{
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Signals 
	{
		//General signals
		public static const CHANGE_GAME_STATE:String = "changeGameState";
		
		//Lobby signals
		public static const LOBBY_RESPONSE:String = "lobbyResponded";
		public static const PLAYER_FOUND:String = "playerFound";
		
		//Arena signals
		public static const ARENA_INIT:String = "arena_init";
		
		//Battle signals
		public static const ENEMY_MOVING:String = "enemyMoving";
	}

}