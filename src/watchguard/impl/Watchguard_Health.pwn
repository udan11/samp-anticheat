/**
 * <summary>Checks if a player is using health hack.</summary>
 * <param name="playerid">Player's ID.</param>
 */
stock AC::Watchguard_Health(playerid) {
	new Float:health;
	GetPlayerHealth(playerid, health);
	if (!AC::IsPlayerSynced(playerid, AC::sHealth)) {
		AC::SetPlayerSync(playerid, AC::sHealth, health == AC::players[playerid][AC::pHealth]);
	} else {
		if (health > AC::players[playerid][AC::pHealth]) {
			AC::CheatDetected(playerid, AC::cHealth);
		} else {
			AC::players[playerid][AC::pHealth] = health;
		}
	}
}