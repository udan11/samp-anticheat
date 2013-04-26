/**
 * Triggers the `Anticheat_OnCheatDetected` callback.
 * <param name="playerid">Player's ID.</param>
 * <param name="cheatid">Cheat ID.</param>
 * <param name="extraid">Additional cheat ID (depends on hack tool, detection method, etc.).</param>
 * <param name="info">Additional information.</param>
 */
stock AC::CheatDetected(playerid, cheatid, extraid = 0, info[] = "") {
	if (isnull(info)) {
		CallLocalFunction(#Anticheat_OnCheatDetected, "iiis", playerid, cheatid, extraid, "\1");
	} else {
		CallLocalFunction(#Anticheat_OnCheatDetected, "iiis", playerid, cheatid, extraid, info);
	}
}