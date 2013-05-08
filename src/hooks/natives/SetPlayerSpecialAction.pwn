// SetPlayerSpecialAction hook.
#if defined AC_MASTER
	AC_PUBLIC AC_SetPlayerSpecialAction(playerid, actionid) {
		if (IsPlayerConnected(playerid)) {
			AC_players[playerid][AC_pSpecialAction] = actionid;
		}
		return SetPlayerSpecialAction(playerid, actionid);
	}
#else
	AC_STOCK AC_SetPlayerSpecialAction(playerid, actionid) {
		return CallRemoteFunction(#AC_SetPlayerSpecialAction, "ii", playerid, actionid);
	}
#endif
#if defined _ALS_SetPlayerSpecialAction
	#undef SetPlayerSpecialAction
#else
	#define _ALS_SetPlayerSpecialAction
#endif
#define SetPlayerSpecialAction AC_SetPlayerSpecialAction