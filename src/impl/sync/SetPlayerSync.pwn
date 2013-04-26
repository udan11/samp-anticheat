/**
 * <summary>Sets a player's sync status.</summary>
 * <param name="playerid">Player's ID.</param>
 * <param name="sync">Sync's ID.</param>
 * <param name="status">Is player synced or not?</param>
 */
stock AC::SetPlayerSync(playerid, sync, status = 1) {
	if (IsPlayerConnected(playerid)) {
		if (status) {
			AC::players[playerid][AC::pSync] |= 1 << sync;
			AC::players[playerid][AC::pSyncFails][sync] = 0;
		} else {
			AC::players[playerid][AC::pSync] &= ~(1 << sync);
			++AC::players[playerid][AC::pSyncFails][sync];
			if (AC::players[playerid][AC::pSyncFails][sync] % AC_SYNC_MAX_FAILS) {
				AC::CheatDetected(playerid, AC::cSync, sync, "");
			}
		}
	}
}