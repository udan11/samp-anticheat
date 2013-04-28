// GetPlayerMoney hook.
AC_PUBLIC AC_GetPlayerMoney(playerid) {
	if (IsPlayerConnected(playerid)) {
		return AC_players[playerid][AC_pMoney];
	}
	return 0;
}
#if defined _ALS_GetPlayerMoney
	#undef GetPlayerMoney
#else
	#define _ALS_GetPlayerMoney
#endif
#define GetPlayerMoney AC_GetPlayerMoney