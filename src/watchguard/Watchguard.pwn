/**
 * <summary>Anticheat's main function. Supervises players' actions.</summary>
 */
AC_PUBLIC AC_Watchguard() {
	foreach (new playerid : Player) {
		if (!AC_IsPlayerSpawned(playerid)) {
			continue;
		} else if (AC_IsPlayerAFK(playerid)) {
			continue;
		}
		AC_Watchguard_Health(playerid);
		AC_Watchguard_Armour(playerid);
	}
}