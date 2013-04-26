// We check if no parameter was passed to the anticheat.
#if (!defined ANTICHEAT_CORE) && (!defined ANTICHEAT_API)
	#if defined FILTERSCRIPT
		#define ANTICHEAT_API
	#else
		#define ANTICHEAT_CORE
	#endif
#endif

#if defined ANTICHEAT_API

	/**
	 * <summary>API used by remote scripts (other than the core).</summary>
	 */
	// TODO.
	
	#if defined ANTICHEAT_NEW_FUNCTIONS
		/*
		REMOTE:IsPlayerAFK<i>(playerid);
		REMOTE:IsPlayerSpawned<i>(playerid);
		*/
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
forward Anticheat_OnCheatDetected(playerid, cheatid, extraid = 0, info[] = "");

// Defines new functions. Not the real purpose of this anticheat.
#if defined ANTICHEAT_NEW_FUNCTIONS
	/*
	#define IsPlayerAFK				AC::IsPlayerAFK
	#define IsPlayerSpawned			AC::IsPlayerSpawned
	*/
#endif