// GetPlayerSpecialAction hook.
#if defined AC_MASTER
	AC_PUBLIC AC_GetPlayerSpecialAction(playerid) {
		if (IsPlayerConnected(playerid)) {
			return AC_players[playerid][AC_pSpecialAction];
		}
		return SPECIAL_ACTION_NONE;
	}
#else
	AC_STOCK AC_GetPlayerSpecialAction(playerid) {
		return CallRemoteFunction(#AC_GetPlayerSpecialAction, "i", playerid);
	}
#endif
#if defined _ALS_GetPlayerSpecialAction
	#undef GetPlayerSpecialAction
#else
	#define _ALS_GetPlayerSpecialAction
#endif
#define GetPlayerSpecialAction AC_GetPlayerSpecialAction