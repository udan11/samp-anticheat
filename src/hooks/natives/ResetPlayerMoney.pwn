// ResetPlayerMoney hook.
AC_PUBLIC AC_ResetPlayerMoney(playerid) {
	#if defined AC_MASTER
		if (IsPlayerConnected(playerid)) {
			AC_players[playerid][AC_pMoney] = 0;
		}
		return ResetPlayerMoney(playerid);
	#else
		return CallRemoteFunction(#AC_ResetPlayerMoney, "i", playerid);
	#endif
}
#if defined _ALS_ResetPlayerMoney
	#undef ResetPlayerMoney
#else
	#define _ALS_ResetPlayerMoney
#endif
#define ResetPlayerMoney AC_ResetPlayerMoney