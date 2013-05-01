#if defined AC_MASTER

	/**
	 * <summary>Checks if a player is using armour hack.</summary>
	 * <param name="playerid">Player's ID.</param>
	 */
	stock AC_Watchguard_Ping(playerid) {
		if (GetPlayerPing(playerid) > AC_MAX_PING) {
			AC_CheatDetected(playerid, AC_cPing);
		}
	}
	
#endif