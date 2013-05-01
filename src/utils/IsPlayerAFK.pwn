/**
 * <summary>Checks if a player is AFK.</summary>
 * <param name="playerid">Player's ID.</param>
 * <returns>True if player is AFK, false if not.</returns>
 */
AC_PUBLIC AC_IsPlayerAFK(playerid) {
	#if defined AC_MASTER
		if (IsPlayerConnected(playerid)) {
			return (GetTickCount() - AC_players[playerid][AC_pLastUpdate]) > AC_AFK_TIME;
		}
		return false;
	#else
		return CallRemoteFunction(#AC_IsPlayerAFK, "i", playerid);
	#endif
}