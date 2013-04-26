/**
 * <summary>Checks if a player is AFK.</summary>
 * <param name="playerid">Player's ID.</param>
 * <returns>True if player is AFK, false if not.</returns>
 */
stock AC::IsPlayerAFK(playerid) {
	if (IsPlayerConnected(playerid)) {
		return (GetTickCount() - AC::players[playerid][AC::pLastUpdate]) > AC_AFK_TIME;
	}
	return false;
}