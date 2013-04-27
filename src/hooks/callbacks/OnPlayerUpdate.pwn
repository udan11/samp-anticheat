// OnPlayerUpdate hook.
public OnPlayerUpdate(playerid) {
	AC_players[playerid][AC_pLastUpdate] = GetTickCount();
	#if defined AC_OnPlayerUpdate
		return AC_OnPlayerUpdate(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate AC_OnPlayerUpdate

#if defined AC_OnPlayerUpdate
	forward AC_OnPlayerUpdate(playerid);
#endif