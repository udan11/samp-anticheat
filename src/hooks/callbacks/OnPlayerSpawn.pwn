// OnPlayerSpawn hook.
public OnPlayerSpawn(playerid) {
	AC_players[playerid][AC_pState] = 0;
	AC_players[playerid][AC_pState] |= AC_psSpawn;
	AC_players[playerid][AC_pState] &= ~AC_psFreeze;
	AC_players[playerid][AC_pSync] = 0;
	AC_players[playerid][AC_pLastUpdate] = GetTickCount();
	AC_players[playerid][AC_pHealth] = 100.0;
	AC_players[playerid][AC_pArmour] = 0.0;
	// TODO: Update position.
	// TODO: Update weapons.
	AC_players[playerid][AC_pSpecialAction] = SPECIAL_ACTION_NONE;
	#if defined AC_OnPlayerSpawn
		return AC_OnPlayerSpawn(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn AC_OnPlayerSpawn

#if defined AC_OnPlayerSpawn
	forward AC_OnPlayerSpawn(playerid);
#endif