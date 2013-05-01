/**
 * <summary>Checks if a player is spawned.</summary>
 * <param name="playerid">Player's ID.</param>
 * <returns>True if player is spawned, false if not.</returns>
 */
AC_PUBLIC AC_IsPlayerSpawned(playerid) {
	#if defined AC_MASTER
		if (IsPlayerConnected(playerid)) {
			return AC_players[playerid][AC_pState] & AC_psSpawn ? true : false;
		}
		return false;
	#else
		return CallRemoteFunction(#AC_IsPlayerSpawned, "i", playerid);
	#endif
}