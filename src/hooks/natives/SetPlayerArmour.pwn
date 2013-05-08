// SetPlayerArmour hook.
#if defined AC_MASTER
	AC_PUBLIC AC_SetPlayerArmour(playerid, Float:armour) {
		if (IsPlayerConnected(playerid)) {
			AC_players[playerid][AC_pArmour] = armour;
			AC_SetPlayerSync(playerid, AC_sArmour, false);
		}
		return SetPlayerArmour(playerid, armour);
	}
#else
	AC_STOCK AC_SetPlayerArmour(playerid, Float:armour) {
		return CallRemoteFunction(#AC_SetPlayerArmour, "if", playerid, armour);
	}
#endif
#if defined _ALS_SetPlayerArmour
	#undef SetPlayerArmour
#else
	#define _ALS_SetPlayerArmour
#endif
#define SetPlayerArmour AC_SetPlayerArmour