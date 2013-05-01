// GetPlayerSpecialAction hook.
AC_PUBLIC AC_GetPlayerSpecialAction(playerid) {
	#if defined AC_MASTER
		if (IsPlayerConnected(playerid)) {
			return AC_players[playerid][AC_pSpecialAction];
		}
		return SPECIAL_ACTION_NONE;
	#else
		return CallRemoteFunction(#AC_GetPlayerSpecialAction, "i", playerid);
	#endif
}
#if defined _ALS_GetPlayerSpecialAction
	#undef GetPlayerSpecialAction
#else
	#define _ALS_GetPlayerSpecialAction
#endif
#define GetPlayerSpecialAction AC_GetPlayerSpecialAction