// GetPlayerMoney hook.
#if defined AC_MASTER
	AC_PUBLIC AC_GetPlayerMoney(playerid) {
		if (IsPlayerConnected(playerid)) {
			new bad_money = U_GetPlayerMoney(playerid);
			return bad_money < AC_players[playerid][AC_pMoney] ? bad_money : AC_players[playerid][AC_pMoney];
		}
		return 0;
	}
#else
	AC_STOCK AC_GetPlayerMoney(playerid) {
		return CallRemoteFunction(#AC_GetPlayerMoney, "i", playerid);
	}
#endif
#if defined _ALS_GetPlayerMoney
	#undef GetPlayerMoney
#else
	#define _ALS_GetPlayerMoney
#endif
#define GetPlayerMoney AC_GetPlayerMoney