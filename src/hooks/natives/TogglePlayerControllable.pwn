// TogglePlayerControllable hook.
#if defined AC_MASTER
	AC_PUBLIC AC_TogglePlayerControllable(playerid, toggle) {
		if (IsPlayerConnected(playerid)) {
			if (toggle) {
				AC_players[playerid][AC_pState] &= ~AC_psIsFrozen;
			} else {
				AC_players[playerid][AC_pState] |= AC_psIsFrozen;
			}
		}
		return TogglePlayerControllable(playerid, toggle);
}
#else
	AC_STOCK AC_TogglePlayerControllable(playerid, toggle) {
		return CallRemoteFunction(#AC_TogglePlayerControllable, "ii", playerid, toggle);
	}
#endif
#if defined _ALS_TogglePlayerControllable
	#undef TogglePlayerControllable
#else
	#define _ALS_TogglePlayerControllable
#endif
#define TogglePlayerControllable AC_TogglePlayerControllable