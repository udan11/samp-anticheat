#if defined AC_MASTER

	// OnPlayerUpdate hook.
	public OnPlayerUpdate(playerid) {
		AC_players[playerid][AC_pLastUpdate] = GetTickCount();
		new drunkLevel = GetPlayerDrunkLevel(playerid);
		if (drunkLevel < 100) {
			// 2000 is the maximum drunk level the player doesn't notice.
			SetPlayerDrunkLevel(playerid, 2000);
			AC_players[playerid][AC_pDrunkLevel] = 2000;
		} else if (AC_players[playerid][AC_pDrunkLevel] != drunkLevel) {
			new fps = AC_players[playerid][AC_pDrunkLevel] - drunkLevel;
			if (0 < fps < 200) {
				new index = (AC_players[playerid][AC_pFPSIndex] + 1) % AC_MAX_FPS_INDEX;
				AC_players[playerid][AC_pFPS][index] = fps;
				AC_players[playerid][AC_pFPSIndex] = index;
			}
			AC_players[playerid][AC_pDrunkLevel] = drunkLevel;
		}
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
	
#endif