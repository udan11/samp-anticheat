// SetPlayerHealth hook.
#if defined AC_MASTER
	AC_PUBLIC AC_SetPlayerHealth(playerid, Float:health) {
		if (IsPlayerConnected(playerid)) {
			AC_players[playerid][AC_pHealth] = health;
			AC_SetPlayerSync(playerid, AC_sHealth, false);
		}
		return SetPlayerHealth(playerid, health);
	}
#else
	AC_STOCK AC_SetPlayerHealth(playerid, Float:health) {
		return CallRemoteFunction(#AC_SetPlayerHealth, "if", playerid, health);
	}
#endif
#if defined _ALS_SetPlayerHealth
	#undef SetPlayerHealth
#else
	#define _ALS_SetPlayerHealth
#endif
#define SetPlayerHealth AC_SetPlayerHealth