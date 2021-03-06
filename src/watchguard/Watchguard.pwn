#if defined AC_MASTER

	/**
	 * <summary>Anticheat's main function. Supervises players' actions.</summary>
	 */
	AC_PUBLIC AC_Watchguard() {
		foreach (new playerid : Player) {
			// There is no point in checking players who aren't spawned or are AFK.
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
			// TODO: Hook other modules.
			if (AC_cheats[AC_cUnknown][AC_ccIsEnabled]) {
				AC_Watchguard_Freeze(playerid);
			}
			if (AC_cheats[AC_cPing][AC_ccIsEnabled]) {
				AC_Watchguard_Ping(playerid);
			}
			if (AC_cheats[AC_cPing][AC_ccIsEnabled]) {
				AC_Watchguard_FPS(playerid);
			}
			if (AC_cheats[AC_cHealth][AC_ccIsEnabled]) {
				AC_Watchguard_Health(playerid);
			}
			if (AC_cheats[AC_cArmour][AC_ccIsEnabled]) {
				AC_Watchguard_Armour(playerid);
			}
			if (AC_cheats[AC_cMoney][AC_ccIsEnabled]) {
				AC_Watchguard_Money(playerid);
			}
			if (AC_cheats[AC_cJoypad][AC_ccIsEnabled]) {
				AC_Watchguard_Joypad(playerid);
			}
			if (AC_cheats[AC_cJetpack][AC_ccIsEnabled]) {
				AC_Watchguard_Jetpack(playerid);
			}
			// AC_cModSa is a one-time check. It can be efectuated later, but it has to be triggered manually.
		}
	}
	
#endif