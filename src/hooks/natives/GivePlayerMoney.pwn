// GivePlayerMoney hook.
AC_PUBLIC AC_GivePlayerMoney(playerid, money) {
	#if defined AC_MASTER
		if (IsPlayerConnected(playerid)) {
			AC_players[playerid][AC_pMoney] += money;
		}
		return GivePlayerMoney(playerid, money);
	#else
		return CallRemoteFunction(#AC_GivePlayerMoney, "ii", playerid, money);
	#endif
}
#if defined _ALS_GivePlayerMoney
	#undef GivePlayerMoney
#else
	#define _ALS_GivePlayerMoney
#endif
#define GivePlayerMoney AC_GivePlayerMoney