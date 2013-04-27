// OnPlayerText hook.
public OnPlayerText(playerid, text[]) {
	AC_players[playerid][AC_pLastUpdate] = GetTickCount();
	#if defined AC_OnPlayerText
		return AC_OnPlayerText(playerid, text);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif
#define OnPlayerText AC_OnPlayerText

#if defined AC_OnPlayerText
	forward AC_OnPlayerText(playerid, text[]);
#endif