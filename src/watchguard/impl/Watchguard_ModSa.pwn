#if defined AC_MASTER

	/**
	 * <summary>Initiates a m0d_sa check.</summary>
	 * <param name="playerid">Player's ID.</param>
	 */
	AC_STOCK AC_Watchguard_ModSa(playerid) {
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, false);
		SetTimerEx(#AC_Watchguard_ModSa_, AC_MOD_SA_CHECK_INTERVAL, false, "i", playerid);
	}
	
	/**
	 * <summary>Checks if a player is using m0d_sa.</summary>
	 * <param name="playerid">Player's ID.</param>
	 */
	AC_PUBLIC AC_Watchguard_ModSa_(playerid) {
		new Float:vector[3];
		GetPlayerCameraFrontVector(playerid, vector[0], vector[1], vector[2]);
		TogglePlayerControllable(playerid, true);
		if (AC_IsPlayerAFK(playerid)) {
			// Player tries to by-pass this check by going into main menu and blocking updates.
			AC_Watchguard_ModSa(playerid);
		} else {
			if (vector[2] < AC_MOD_SA_MAGIC) {
				AC_CheatDetected(playerid, AC_cModSa);
			}
		}
	}
	
#endif