#if defined AC_MASTER

	// OnPlayerDeath hook.
	public OnPlayerDeath(playerid, killerid, reason) {
		new now = GetTickCount();
		if (killerid != INVALID_PLAYER_ID) {
			if (now - AC_players[playerid][AC_pLastDeath] < AC_DEATH_TIME) {
				AC_CheatDetected(playerid, AC_cFakeKill);
			}
			/*
			// Alternative (not tested): The weapons don't match.
			if (GetPlayerWeapon(killerid) != reason) {
				AC_CheatDetected(playerid, AC_cFakeKill);
			}
			// Alternative (not tested): Target player is not streamed in for killer.
			if (!IsPlayerStreamedInForPlayer(playerid, killerid)) {
				AC_CheatDetected(playerid, AC_cFakeKill);
			}
			*/
		}
		AC_players[playerid][AC_pLastDeath] = now;
		AC_players[playerid][AC_pState] &= ~AC_psSpawn;
		#if defined AC_OnPlayerDeath
			return AC_OnPlayerDeath(playerid, killerid, reason);
		#else
			return 1;
		#endif
	}

	#if defined _ALS_OnPlayerDeath
		#undef OnPlayerDeath
	#else
		#define _ALS_OnPlayerDeath
	#endif
	#define OnPlayerDeath AC_OnPlayerDeath

	#if defined AC_OnPlayerDeath
		forward AC_OnPlayerDeath(playerid, killerid, reason);
	#endif
	
#endif