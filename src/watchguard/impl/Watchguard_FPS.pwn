#if defined AC_MASTER

	/**
	 * <summary>Checks if a player has low fps.</summary>
	 * <param name="playerid">Player's ID.</param>
	 */
	AC_STOCK AC_Watchguard_FPS(playerid) {
		new fps = AC_GetPlayerFPS(playerid);
		if (fps < AC_MIN_FPS) {
			AC_CheatDetected(playerid, AC_cFPS, fps);
		}
	}
	
#endif