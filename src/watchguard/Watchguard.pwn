/**
 * <summary>Anticheat's main function. Supervises players' actions.</summary>
 */
AC_PUBLIC:AC::Watchguard() {
	foreach (new playerid : Player) {
		if (!AC::IsPlayerSpawned(playerid)) {
			continue;
		} else if (AC::IsPlayerAFK(playerid)) {
			continue;
		}
		AC::Watchguard_Health(playerid);
		AC::Watchguard_Armour(playerid);
	}
}