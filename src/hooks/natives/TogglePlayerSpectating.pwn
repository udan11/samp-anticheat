// TogglePlayerSpectating hook.
#if defined AC_MASTER
	AC_PUBLIC AC_TogglePlayerSpectating(playerid, toggle) {
		if (IsPlayerConnected(playerid)) {
			if (toggle) {
				AC_players[playerid][AC_pState] &= ~AC_psIsSpawned;
			}
		}
		return TogglePlayerSpectating(playerid, toggle);
	}
#else
	AC_STOCK AC_TogglePlayerSpectating(playerid, toggle) {
		return CallRemoteFunction(#AC_TogglePlayerSpectating, "ii", playerid, toggle);
	}
#endif
#if defined _ALS_TogglePlayerSpectating
	#undef TogglePlayerSpectating
#else
	#define _ALS_TogglePlayerSpectating
#endif
#define TogglePlayerSpectating AC_TogglePlayerSpectating