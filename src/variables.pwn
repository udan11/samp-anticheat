/**
 * The ID of the watchguard timer.
 */
stock AC::watchguardTimer = 0;

/**
 * <summary>Stores a player's game data.</summary>
 */
enum AC::ePlayer {

	/**
	 * <summary>Player's last known state.</summary>
	 */
	AC::pState,
	
	/**
	 * <summary>Player's sync status.</summary>
	 */
	AC::pSync,
	
	/**
	 * <summary>Keeps track of player's sync failures.</summary>
	 */
	AC::pSyncFails[AC::eSync],

	/**
	 * <summary>Stores latest FPS measurements.</summary>
	 */
	AC::pFPS[AC_MAX_FPS_INDEX],

	/**
	 * <summary>The time (in ms) when the player was last updated.</summary>
	 */
	AC::pLastUpdate,

	/**
	 * <summary>Player's health.</summary>
	 */
	Float:AC::pHealth,

	/**
	 * <summary>Player's armour.</summary>
	 */
	Float:AC::pArmour,

	/**
	 * <summary>Player's money.</summary>
	 */
	AC::pMoney,

	/**
	 * <summary>The latest time (in ms) when the player died.</summary>
	 */
	AC::pLastDeath,
	
	/**
	 * <summary>Player's latest known position.</summary>
	 */
	Float:AC::pPos[3],
	
	/**
	 * <summary>Player's latest known velocity.</summary>
	 */
	Float:AC::pVelocity[3],
	
	/**
	 * <summary>Player's weapons (ID and ammo).</summary>
	 * <remarks>Two fields are used instead of a bidimensional array because Pawn doesn't support 4D arrays.</remarks>
	 */
	AC::pWeaponsID[AC_MAX_WEAPON_SLOTS],
	AC::pWeaponsAmmo[AC_MAX_WEAPON_SLOTS],
	
	/**
	 * <summary>Player's special action.</summary>
	 */
	AC::pSpecialAction,
	
};

/**
 * <summary>Stores players' game data.</summary>
 */
new AC::players[MAX_PLAYERS][AC::ePlayer];