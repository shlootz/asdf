package states 
{
	import states.levelStates.ArenaState;
	import states.lobby.LobbyState;
	import states.menuStates.LoadingState;
	import states.menuStates.MainMenuState;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class AllStates 
	{
		public static const LOADING_STATE:Class = LoadingState;
		public static const MAIN_MENU_STATE:Class = MainMenuState;
		public static const LOBBY_STATE:Class = LobbyState;
		public static const ARENA_STATE:Class = ArenaState;
		public static const BATTLE_STATE:Class = ArenaState;
	}

}