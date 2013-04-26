/**
 * <summary>Checks if a player is spawned.</summary>
 * <param name="playerid">Player's ID.</param>
 * <returns>True if player is spawned, false if not.</returns>
 */
stock AC::IsPlayerSpawned(playerid) {
	if (IsPlayerConnected(playerid)) {
		return AC::players[playerid][AC::pState] & AC::psSpawn ? true : false;
	}
	return false;
}