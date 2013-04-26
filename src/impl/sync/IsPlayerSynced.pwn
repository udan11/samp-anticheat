/**
 * <summary>Checks a player's sync status.</summary>
 * <param name="playerid">Player's ID.</param>
 * <param name="sync">Sync's ID.</param>
 * <returns>True if player is synced, false if not.</returns>
 */
stock AC::IsPlayerSynced(playerid, sync) {
	if (IsPlayerConnected(playerid)) {
		return (AC::players[playerid][AC::pSync] & (1 << sync)) ? true : false;
	}
	return false;
}