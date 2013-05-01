// TogglePlayerSpectating hook.
AC_PUBLIC AC_TogglePlayerSpectating(playerid, toggle) {
	#if defined AC_MASTER
		if (IsPlayerConnected(playerid)) {
			if (toggle) {
				AC_players[playerid][AC_pState] &= ~AC_psSpawn;
			}
		}
		return TogglePlayerSpectating(playerid, toggle);
	#else
		return CallRemoteFunction(#AC_TogglePlayerSpectating, "ii", playerid, toggle);
	#endif
}
#if defined _ALS_TogglePlayerSpectating
	#undef TogglePlayerSpectating
#else
	#define _ALS_TogglePlayerSpectating
#endif
#define TogglePlayerSpectating AC_TogglePlayerSpectating