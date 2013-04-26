/**
 * <summary>Checks if a player is using armour hack.</summary>
 * <param name="playerid">Player's ID.</param>
 */
stock AC::Watchguard_Armour(playerid) {
	new Float:armour;
	GetPlayerArmour(playerid, armour);
	if (!AC::IsPlayerSynced(playerid, AC::sArmour)) {
		AC::SetPlayerSync(playerid, AC::sArmour, armour == AC::players[playerid][AC::pArmour]);
	} else {
		if (armour > AC::players[playerid][AC::pArmour]) {
			AC::CheatDetected(playerid, AC::cArmour);
		} else {
			AC::players[playerid][AC::pArmour] = armour;
		}
	}
}