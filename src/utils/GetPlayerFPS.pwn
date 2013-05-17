/**
 * <summary>Checks if a player is AFK.</summary>
 * <param name="playerid">Player's ID.</param>
 * <returns>Player's FPS rate.</returns>
 */
AC_PUBLIC AC_GetPlayerFPS(playerid) {
	#if defined AC_MASTER
		if (IsPlayerConnected(playerid)) {
			new fps;
			for (new i = 0; i != AC_MAX_FPS_INDEX; ++i) {
				if (AC_players[playerid][AC_pFPS][i] != 0) {
					fps += AC_players[playerid][AC_pFPS][i];
				} else {
					fps += AC_MIN_FPS;
				}
			}
			return fps / AC_MAX_FPS_INDEX;
		}
		return 0;
	#else
		return CallRemoteFunction(#AC_GetPlayerFPS, "i", playerid);
	#endif
}