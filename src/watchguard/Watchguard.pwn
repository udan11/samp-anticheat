/**
 * <summary>Anticheat's main function. Supervises players' actions.</summary>
 */
AC_PUBLIC AC_Watchguard() {
	foreach (new playerid : Player) {
		// There is no point in checking players who are AFK or aren't spawned.
		if (!AC_IsPlayerSpawned(playerid)) {
			continue;
		} else if (AC_IsPlayerAFK(playerid)) {
			if ((AC_cheats[AC_cAFK][AC_ccIsEnabled]) && ((AC_players[playerid][AC_pState] & AC_psWasAFK) == 0)) {
				AC_CheatDetected(playerid, AC_cAFK, 1);
			}
			AC_players[playerid][AC_pState] |= AC_psWasAFK;
			continue;
		} else {
			if ((AC_cheats[AC_cAFK][AC_ccIsEnabled]) && (AC_players[playerid][AC_pState] & AC_psWasAFK)) {
				AC_CheatDetected(playerid, AC_cAFK, 0);
			}
			AC_players[playerid][AC_pState] &= ~AC_psWasAFK;
		}
		// Anti-cheat modules calls.
		if (AC_cheats[AC_cPing][AC_ccIsEnabled]) {
			AC_Watchguard_Ping(playerid);
		}
		if (AC_cheats[AC_cHealth][AC_ccIsEnabled]) {
			AC_Watchguard_Health(playerid);
		}
		if (AC_cheats[AC_cArmour][AC_ccIsEnabled]) {
			AC_Watchguard_Armour(playerid);
		}
		// TODO: Hook other modules.
	}
}