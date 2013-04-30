// We check if no parameter was passed to the anticheat.
#if (!defined AC_MASTER) && (!defined AC_SLAVE)
	#if defined FILTERSCRIPT
		#define AC_SLAVE
	#else
		#define AC_MASTER
	#endif
#endif

// Rename old natives (unprotected).
native U_GetPlayerMoney(playerid) = GetPlayerMoney;
native U_GetPlayerSpecialAction(playerid) = GetPlayerSpecialAction;

#if defined AC_SLAVE

	/**
	 * <summary>API used by remote scripts (other than the core).</summary>
	 */
	 
	AC_STOCK AC_GetPlayerMoney(playerid) {
		return CallRemoteFunction(#AC_GetPlayerMoney, "i", playerid);
	}
	#if defined _ALS_GetPlayerMoney
		#undef GetPlayerMoney
	#else
		#define _ALS_GetPlayerMoney
	#endif
	#define GetPlayerMoney AC_GetPlayerMoney
	
	AC_STOCK AC_GivePlayerMoney(playerid, money) {
		return CallRemoteFunction(#AC_GivePlayerMoney, "ii", playerid, money);
	}
	#if defined _ALS_GivePlayerMoney
		#undef GivePlayerMoney
	#else
		#define _ALS_GivePlayerMoney
	#endif
	#define GivePlayerMoney AC_GivePlayerMoney
	
	AC_STOCK AC_ResetPlayerMoney(playerid) {
		return CallRemoteFunction(#AC_ResetPlayerMoney, "i", playerid);
	}
	#if defined _ALS_ResetPlayerMoney
		#undef ResetPlayerMoney
	#else
		#define _ALS_ResetPlayerMoney
	#endif
	#define ResetPlayerMoney AC_ResetPlayerMoney
	
	AC_STOCK AC_SetPlayerArmour(playerid, Float:health) {
		return CallRemoteFunction(#AC_SetPlayerArmour, "if", playerid, health);
	}
	#if defined _ALS_SetPlayerArmour
		#undef SetPlayerArmour
	#else
		#define _ALS_SetPlayerArmour
	#endif
	#define SetPlayerArmour AC_SetPlayerArmour
	
	AC_STOCK AC_SetPlayerHealth(playerid, Float:health) {
		return CallRemoteFunction(#AC_SetPlayerHealth, "if", playerid, health);
	}
	#if defined _ALS_SetPlayerHealth
		#undef SetPlayerHealth
	#else
		#define _ALS_SetPlayerHealth
	#endif
	#define SetPlayerHealth AC_SetPlayerHealth
	
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
forward AC_OnCheatDetected(playerid, cheatid, extraid, info[]);

// Defines new functions. Not the real purpose of this anticheat.
#if defined AC_NEW_FUNCTIONS
	#define IsPlayerAFK				AC_IsPlayerAFK
	#define IsPlayerSpawned			AC_IsPlayerSpawned
#endif