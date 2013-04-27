// OnPlayerConnect hook.
public OnPlayerConnect(playerid) {
	memset(AC_players[playerid], 0, AC_ePlayer);
	#if defined AC_OnPlayerConnect
		return AC_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect AC_OnPlayerConnect

#if defined AC_OnPlayerConnect
	forward AC_OnPlayerConnect(playerid);
#endif