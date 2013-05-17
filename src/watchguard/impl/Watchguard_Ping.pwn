#if defined AC_MASTER

	/**
	 * <summary>Checks if a player has big ping.</summary>
	 * <param name="playerid">Player's ID.</param>
	 */
	AC_STOCK AC_Watchguard_Ping(playerid) {
		new ping = GetPlayerPing(playerid);
		if (ping > AC_MAX_PING) {
			AC_CheatDetected(playerid, AC_cPing, ping);
		}
	}
	
#endif