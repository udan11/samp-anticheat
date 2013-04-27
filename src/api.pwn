// We check if no parameter was passed to the anticheat.
#if (!defined AC_CORE) && (!defined AC_API)
	#if defined FILTERSCRIPT
		#define AC_API
	#else
		#define AC_CORE
	#endif
#endif

#if defined AC_API

	/**
	 * <summary>API used by remote scripts (other than the core).</summary>
	 */
	
	AC_REMOTE SetPlayerArmour<if>(playerid, Float:armour);
	AC_REMOTE SetPlayerHealth<if>(playerid, Float:health);
	
	#if defined AC_NEW_FUNCTIONS
		AC_REMOTE IsPlayerAFK<i>(playerid);
		AC_REMOTE IsPlayerSpawned<i>(playerid);
	#endif
	
	#endinput // We stop here, we don't need the core.
#endif

/**
 * Callback triggered when a cheat is detected.
 * <param name="playerid">Player's ID.</param>
 * <param name="cheatid">Cheat ID.</param>
 * <param name="extraid">Additional cheat ID (depends on hack tool, detection method, etc.).</param>
 * <param name="info">Additional information.</param>
 */
forward AC_OnCheatDetected(playerid, cheatid, extraid = 0, info[] = "");

// Defines new functions. Not the real purpose of this anticheat.
#if defined AC_NEW_FUNCTIONS
	#define IsPlayerAFK				AC_IsPlayerAFK
	#define IsPlayerSpawned			AC_IsPlayerSpawned
#endif