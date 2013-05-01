#if defined AC_MASTER

	// OnPlayerCommandText hook.
	public OnPlayerCommandText(playerid, cmdtext[]) {
		AC_players[playerid][AC_pLastUpdate] = GetTickCount();
		#if defined AC_OnPlayerCommandText
			return AC_OnPlayerCommandText(playerid, cmdtext);
		#else
			return 1;
		#endif
	}

	#if defined _ALS_OnPlayerCommandText
		#undef OnPlayerCommandText
	#else
		#define _ALS_OnPlayerCommandText
	#endif
	#define OnPlayerCommandText AC_OnPlayerCommandText

	#if defined AC_OnPlayerCommandText
		forward AC_OnPlayerCommandText(playerid, cmdtext[]);
	#endif
	
#endif