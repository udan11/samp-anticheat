#file "main.pwn"
#line 0
/**
 * Copyright (c) 2013, Dan
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met: 
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer. 
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution. 
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Special thanks to:
 *	  cessil - useful anticheat tips
 *	  Slice - memset
 *	  Y_Less - very thorough research
 */
 
// #include guard
#if defined __anticheat_included
	#endinput
#endif
#define __anticheat_included

// Checking for `a_samp.inc`.
#if !defined _samp_included
	#error "Please include <a_samp> before the anticheat."
#endif

#include <foreach>

/**
 * <summary>Checks if a string is null.</summary>
 */
#if !defined isnull
	#define isnull(%1) \
		((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

/**
 * <summary>Macro used for debugging purposes.</summary>
 */
#if defined AC_DEBUG
	#define _AC_DEBUG(%0)				printf(%0)
#else
	#define _AC_DEBUG(%0);
#endif

/**
 * <summary>Generate forward declarations for public and stock functions.</summary>
 */
#define AC_PUBLIC%0\32;%0(%1) \
	forward %0(%1); public %0(%1)
#define AC_STOCK%0\32;%0(%1) \
	forward %0(%1); stock %0(%1)
#file "api.pwn"
#line 0
// We check if no parameter was passed to the anticheat.
#if (!defined AC_MASTER) && (!defined AC_SLAVE)
	#if defined FILTERSCRIPT
		#define AC_SLAVE
	#else
		#define AC_MASTER
	#endif
#endif

// Rename old natives (unprotected).
native U_GetPlayerMoney(playerid) = GetPlayerMoney;
native U_GetPlayerSpecialAction(playerid) = GetPlayerSpecialAction;

#if defined AC_SLAVE

	/**
	 * <summary>API used by remote scripts (other than the core).</summary>
	 */
	 
	AC_STOCK AC_GetPlayerMoney(playerid) {
		return CallRemoteFunction(#AC_GetPlayerMoney, "i", playerid);
	}
	#if defined _ALS_GetPlayerMoney
		#undef GetPlayerMoney
	#else
		#define _ALS_GetPlayerMoney
	#endif
	#define GetPlayerMoney AC_GetPlayerMoney
	
	AC_STOCK AC_GivePlayerMoney(playerid, money) {
		return CallRemoteFunction(#AC_GivePlayerMoney, "ii", playerid, money);
	}
	#if defined _ALS_GivePlayerMoney
		#undef GivePlayerMoney
	#else
		#define _ALS_GivePlayerMoney
	#endif
	#define GivePlayerMoney AC_GivePlayerMoney
	
	AC_STOCK AC_ResetPlayerMoney(playerid) {
		return CallRemoteFunction(#AC_ResetPlayerMoney, "i", playerid);
	}
	#if defined _ALS_ResetPlayerMoney
		#undef ResetPlayerMoney
	#else
		#define _ALS_ResetPlayerMoney
	#endif
	#define ResetPlayerMoney AC_ResetPlayerMoney
	
	AC_STOCK AC_SetPlayerArmour(playerid, Float:health) {
		return CallRemoteFunction(#AC_SetPlayerArmour, "if", playerid, health);
	}
	#if defined _ALS_SetPlayerArmour
		#undef SetPlayerArmour
	#else
		#define _ALS_SetPlayerArmour
	#endif
	#define SetPlayerArmour AC_SetPlayerArmour
	
	AC_STOCK AC_SetPlayerHealth(playerid, Float:health) {
		return CallRemoteFunction(#AC_SetPlayerHealth, "if", playerid, health);
	}
	#if defined _ALS_SetPlayerHealth
		#undef SetPlayerHealth
	#else
		#define _ALS_SetPlayerHealth
	#endif
	#define SetPlayerHealth AC_SetPlayerHealth
	
	#if defined AC_NEW_FUNCTIONS
		AC_REMOTE IsPlayerAFK<i>(playerid);
		AC_REMOTE IsPlayerSpawned<i>(playerid);
	#endif
	
	#endinput // We stop here, we don't need the core.
#endif

/**
 * Callback triggered when a cheat is detected.
 * <param name="playerid">Player's ID.</param>
 * <param name="cheatid">Cheat ID.</param>
 * <param name="extraid">Additional cheat ID (depends on hack tool, detection method, etc.).</param>
 * <param name="info">Additional information.</param>
 */
forward AC_OnCheatDetected(playerid, cheatid, extraid, info[]);

// Defines new functions. Not the real purpose of this anticheat.
#if defined AC_NEW_FUNCTIONS
	#define IsPlayerAFK				AC_IsPlayerAFK
	#define IsPlayerSpawned			AC_IsPlayerSpawned
#endif
#file "constants/cheats.pwn"
#line 0
/**
 * <summary>Maximum length of a cheat's name.</summary>
 */
#define AC_MAX_CHEAT_NAME				32

/**
 * <summary>An enumeration with the basic definitons of the cheats.</summary>
 */
enum _:AC_eCheats {

	/**
	 * <summary>Unknown hack (used for internal purpose).</summary>
	 */
	AC_cUnknown,
	
	/**
	 * <summary>Not an actual hack. Used for desynced players.</summary>
	 */
	AC_cSync,
	
	/**
	 * <summary>Not an actual hack. Players with high ping usually spoils other players' gameplay.</summary>
	 */
	AC_cPing,
	
	/**
	 * <summary>Not an actual hack. Players with low FPS usually spoils other players' gameplay.</summary>
	 */
	AC_cFPS, // TODO
	
	/**
	 * <summary>Not an actual hack. Used for AFK players.</summary>
	 */
	AC_cAFK,
	
	/**
	 * <summary>Health hack. Restores user's health.</summary>
	 */
	AC_cHealth,
	
	/**
	 * <summary>Armour hack. Restores user's armour.</summary>
	 */
	AC_cArmour,
	
	/**
	 * <summary>Money hack.</summary>
	 */
	AC_cMoney,
	
	/**
	 * <summary>Fake kill. The user is reported to have been killed by multiple persons in short interval.</summary>
	 */
	AC_cFakeKill, // TODO
	
	/**
	 * <summary>Teleport hack. Gives the ability to teleport.</summary>
	 */
	AC_cTeleport, // TODO
	
	/**
	 * <summary>Speed hack. The user / it's vehicle moves faster.</summary>
	 */
	AC_cSpeed, // TODO
	
	/**
	 * <summary>Fly hack. The user looks like he is flying.</summary>
	 */
	AC_cFly, // TODO
	
	/**
	 * <summary>Airbreak hack.</summary>
	 */
	AC_cAirbreak, // TODO
	
	/**
	 * <summary>Weapon hack. The user has the ability to spawn weapons.</summary>
	 */
	AC_cWeapon, // TODO
	
	/**
	 * <summary>Not an actual hack. It detect the player using joypads. It's easier to aim using a joypad.</summary>
	 */
	AC_cJoypad,
	
	/**
	 * <summary>Aim bot detection. This cheat is quite new and detection methods are not very accurate.</summary>
	 */
	AC_cAimBot, // TODO
	
	/**
	 * <summary>Jetpack hack. Detects if a player has acquired a jetpack in a unscripted way.</summary>
	 */
	AC_cJetpack,
	
	/**
	 * <summary>Vehicle warp hack. The user has the ability to warp vehicles around him.</summary>
	 */
	AC_cVehicleWarp, // TODO
	
	/**
	 * <summary>Vehicle repair hack. The user has the ability to repair its vehicle without going to a repair / modding shop.</summary>
	 */
	AC_cVehicleRepair, // TODO
	
	/**
	 * <summary>Vehicle mod hack. The user adds (illegal) mods without being in a modding shop.</summary>
	 */
	AC_cVehicleMod, // TODO
	
	/**
	 * <summary>RCON bruteforces. If a player tries to find the RCON password.</summary>
	 */
	AC_cRconBruteforce, // TODO
	
	/**
	 * <summary>Checks if a player is using the famous `m0d_sa` AIO hacking tool.</summary>
	 */
	AC_cModSa, // TODO
};

/**
 * <summary>Enumeration used to define the configuration of an anti-cheat module.</summary>
 */
enum AC_eCheatConfig {
	AC_ccIsEnabled,
	AC_ccName[AC_MAX_CHEAT_NAME]
};

/**
 * <summary>Variable that holds the state of specific anti-cheat module and it's name.</summary>
 */
stock AC_cheats[AC_eCheats][AC_eCheatConfig] = {
	// AC_cUnknown
	{false, "unknown hack"},
	// AC_cSync
	{false, "desync"},
	// AC_cPing
	{true, "high ping"},
	// AC_cFPS
	{true, "low fps"},
	// AC_cAFK
	{false, "afk"},
	// AC_cHealth
	{true, "health hack"},
	// AC_cArmour
	{true, "armour hack"},
	// AC_cMoney
	{true, "money hack"},
	// AC_cFakeKill
	{true, "fake kill"},
	// AC_cTeleport
	{true, "teleport hack"},
	// AC_cSpeed
	{true, "speed hack"},
	// AC_cFly
	{true, "fly hack"},
	// AC_cAirbreak
	{true, "airbreak hack"},
	// AC_cWeapon
	{true, "weapon hack"},
	// AC_cJoypad
	{true, "joypad"},
	// AC_cAimBot
	{true, "aim bot"},
	// AC_cJetpack
	{true, "jetpack hack"},
	// AC_cVehicleWarp
	{true, "vehicle warp hack"},
	// AC_cVehicleRepair
	{true, "vehicle repair hack"},
	// AC_cVehicleMod
	{true, "vehicle (illegal) mod"},
	// AC_cRconBruteforce
	{true, "RCON bruteforcer"},
	// AC_cModSa
	{true, "m0d_sa (hacking tool)"}
};
#file "constants/game.pwn"
#line 0
/**
 * <summary>Multiple measurements are done to deal with FPS spikes.</summary>
 */
#define AC_MAX_FPS_INDEX				4

/**
 * <summary>Maximum slots for weapons.</summary>
 */
#define AC_MAX_WEAPON_SLOTS				13

/**
 * <summary>Whether two or three dimension vectors should be used.</summary>
 * <remarks>
 *		When 3D vectors are used, falling is reported as speed / teleport hack (sometimes).
 *		In other words, using 2D vectors reduces the number of fake reports.
 * </remarks>
 */
#define AC_USE_2D_VECTORS				true

/**
 * <summary>Vending machins' range.</summary>
 */
#define AC_VENDING_MACHINE_RANGE		15.0

/**
 * <summary>The time (in ms) between checks.</summary>
 * <remarks>Default timers from SA-MP are lazy. I suggest using a timer-fix for better output.</remarks>
 */
#define AC_WATCHGUARD_INTERVAL			1500

/**
 * <summary>Vending machines' position.</summary>
 */
stock const Float:AC_VENDING_MACHINES[][3] = {
	{-14.70, 1175.36, 18.95}, 		{201.02, -107.62, 0.90}, 
	{662.43, -552.16, 15.71}, 		{-76.03, 1227.99, 19.13}, 
	{1154.73, -1460.89, 15.16}, 	{1277.84, 372.52, 18.95}, 
	{1398.84, 2222.61, 10.42}, 		{1520.15, 1055.27, 10.00}, 
	{1634.11, -2237.53, 12.89}, 	{1659.46, 1722.86, 10.22}, 
	{1729.79, -1943.05, 12.95}, 	{1789.21, -1369.27, 15.16}, 
	{1928.73, -1772.45, 12.95}, 	{2060.12, -1897.64, 12.93}, 
	{2085.77, 2071.36, 10.45}, 		{2139.52, -1161.48, 23.36}, 
	{2153.23, -1016.15, 62.23}, 	{2271.73, -76.46, 25.96}, 
	{2319.99, 2532.85, 10.22}, 		{2325.98, -1645.13, 14.21}, 
	{2352.18, -1357.16, 23.77}, 	{2480.86, -1959.27, 12.96}, 
	{2503.14, 1243.70, 10.22}, 		{-253.74, 2597.95, 62.24}, 
	{-253.74, 2599.76, 62.24}, 		{2647.70, 1129.66, 10.22}, 
	{2845.73, 1295.05, 10.79}, 		{-862.83, 1536.61, 21.98}, 
	{-1350.12, 492.29, 10.59}, 		{-1350.12, 493.86, 10.59}, 
	{-1455.12, 2591.66, 55.23}, 	{-1980.79, 142.66, 27.07}, 
	{-2005.65, -490.05, 34.73}, 	{-2011.14, -398.34, 34.73}, 
	{-2034.46, -490.05, 34.73}, 	{-2039.85, -398.34, 34.73}, 
	{-2063.27, -490.05, 34.73}, 	{-2068.56, -398.34, 34.73}, 
	{-2092.09, -490.05, 34.73}, 	{-2097.27, -398.34, 34.73}, 
	{-2118.62, -422.41, 34.73}, 	{-2118.97, -423.65, 34.73}, 
	{-2229.19, 286.41, 34.70}, 		{-2420.18, 985.95, 44.30}, 
	{-2420.22, 984.58, 44.30}, 		{2155.84, 1607.88, 1000.06}, 
	{2155.91, 1606.77, 1000.05}, 	{2202.45, 1617.01, 1000.06}, 
	{2209.24, 1621.21, 1000.06}, 	{2209.91, 1607.20, 1000.05}, 
	{2222.20, 1606.77, 1000.05}, 	{2222.37, 1602.64, 1000.06}, 
	{2225.20, -1153.42, 1025.91}, 	{-15.10, -140.23, 1003.63}, 
	{-16.12, -91.64, 1003.63}, 		{-16.53, -140.30, 1003.63}, 
	{-17.55, -91.71, 1003.63}, 		{-19.04, -57.84, 1003.63}, 
	{-32.45, -186.70, 1003.63},		{-33.88, -186.77, 1003.63},
	{330.68, 178.50, 1020.07}, 		{331.92, 178.50, 1020.07}, 
	{-35.73, -140.23, 1003.63}, 	{350.91, 206.09, 1008.48}, 
	{-36.15, -57.88, 1003.63}, 		{361.56, 158.62, 1008.48}, 
	{371.59, 178.45, 1020.07}, 		{373.83, -178.14, 1000.73}, 
	{374.89, 188.98, 1008.48}, 		{379.04, -178.88, 1000.73}, 
	{495.97, -24.32, 1000.73}, 		{500.56, -1.37, 1000.73}, 
	{501.83, -1.43, 1000.73}, 		{2576.70, -1284.43, 1061.09}
};
#file "constants/player.pwn"
#line 0
/**
 * <summary>The time (in ms) after a player is considered AFK.</summary>
 */
#define AC_AFK_TIME						1500

/**
 * <summary>Maximum ping allowed. Whoever has a bigger ping will be reported as cheater.</summary>
 */
#define AC_MAX_PING						500

/**
 * Player states.
 */
enum _:AC_ePlayerState (<<= 1) {
	AC_psSpawn = 1,						// bitmask  0
	AC_psWasAFK,						// bitmask  1
	AC_psFreeze,						// bitmask  2
	AC_ps03,							// bitmask  3
	AC_ps04,							// bitmask  4
	AC_ps05,							// bitmask  5
	AC_ps06,							// bitmask  6
	AC_ps07,							// bitmask  7
	AC_ps08,							// bitmask  8
	AC_ps09,							// bitmask  9
	AC_ps10,							// bitmask 10
	AC_ps11,							// bitmask 11
	AC_ps12,							// bitmask 12
	AC_ps13,							// bitmask 13
	AC_ps14,							// bitmask 14
	AC_ps15,							// bitmask 15
	AC_ps16,							// bitmask 16
	AC_ps17,							// bitmask 17
	AC_ps18,							// bitmask 18
	AC_ps19,							// bitmask 19
	AC_ps20,							// bitmask 10
	AC_ps21,							// bitmask 21
	AC_ps22,							// bitmask 22
	AC_ps23,							// bitmask 23
	AC_ps24,							// bitmask 24
	AC_ps25,							// bitmask 25
	AC_ps26,							// bitmask 26
	AC_ps27,							// bitmask 27
	AC_ps28,							// bitmask 28
	AC_ps29,							// bitmask 29
	AC_ps30,							// bitmask 30
	AC_ps31,							// bitmask 31
};
#file "constants/sync.pwn"
#line 0
/**
 * <summary>Every AC_SYNC_MAX_FAILS fails a cheat alert is triggered.</summary>
 */
#define AC_SYNC_MAX_FAILS				30

/**
 * <summary>Sync types.</summary>
 */
enum _:AC_eSync {
	AC_sHealth,
	AC_sArmour
};
#file "variables.pwn"
#line 0
/**
 * The ID of the watchguard timer.
 */
stock AC_watchguardTimer = 0;

/**
 * <summary>Stores a player's game data.</summary>
 */
enum _:AC_ePlayer {

	/**
	 * <summary>Player's last known state.</summary>
	 */
	AC_pState,
	
	/**
	 * <summary>Player's sync status.</summary>
	 */
	AC_pSync,
	
	/**
	 * <summary>Keeps track of player's sync failures.</summary>
	 */
	AC_pSyncFails[AC_eSync],

	/**
	 * <summary>Stores latest FPS measurements.</summary>
	 */
	AC_pFPS[AC_MAX_FPS_INDEX],
	
	/**
	 * <summary>Last FPS index used.</summary>
	 */
	AC_pFPSIndex,

	/**
	 * <summary>The time (in ms) when the player was last updated.</summary>
	 */
	AC_pLastUpdate,

	/**
	 * <summary>Player's health.</summary>
	 */
	Float:AC_pHealth,

	/**
	 * <summary>Player's armour.</summary>
	 */
	Float:AC_pArmour,

	/**
	 * <summary>Player's money.</summary>
	 */
	AC_pMoney,

	/**
	 * <summary>The latest time (in ms) when the player died.</summary>
	 */
	AC_pLastDeath,
	
	/**
	 * <summary>Player's latest known position.</summary>
	 */
	Float:AC_pPos[3],
	
	/**
	 * <summary>Player's latest known velocity.</summary>
	 */
	Float:AC_pVelocity[3],
	
	/**
	 * <summary>Player's weapons (ID and ammo).</summary>
	 * <remarks>Two fields are used instead of a bidimensional array because Pawn doesn't support 4D arrays.</remarks>
	 */
	AC_pWeaponsID[AC_MAX_WEAPON_SLOTS],
	AC_pWeaponsAmmo[AC_MAX_WEAPON_SLOTS],
	
	/**
	 * <summary>Player's special action.</summary>
	 */
	AC_pSpecialAction,
	
};

/**
 * <summary>Stores players' game data.</summary>
 */
new AC_players[MAX_PLAYERS][AC_ePlayer];
#file "utils/CheatDetected.pwn"
#line 0
/**
 * Triggers the `Anticheat_OnCheatDetected` callback.
 * <param name="playerid">Player's ID.</param>
 * <param name="cheatid">Cheat ID.</param>
 * <param name="extraid">Additional cheat ID (depends on hack tool, detection method, etc.).</param>
 * <param name="info">Additional information.</param>
 */
stock AC_CheatDetected(playerid, cheatid, extraid = 0, info[] = "") {
	_AC_DEBUG("[anticheat] AC_CheatDetected(playerid = %d, cheatid = %d, extraid = %d, info = %s", playerid, cheatid, extraid, info);
	if (isnull(info)) {
		CallLocalFunction(#AC_OnCheatDetected, "iiis", playerid, cheatid, extraid, "\1");
	} else {
		CallLocalFunction(#AC_OnCheatDetected, "iiis", playerid, cheatid, extraid, info);
	}
}
#file "utils/GetSpeed.pwn"
#line 0
/**
 * <summary>Calculates the speed of an object using an Euclidean vector.</summary>
 * <param name="vx">X-axis of the vector.</param>
 * <param name="vy">Y-axis of the vector.</param>
 * <param name="vz">Z-axis of the vector.</param>
 * <returns>The speed.</returns>
 */
AC_STOCK Float:GetSpeed(Float:vx, Float:vy, Float:vz) {
	return floatsqroot(vx * vx + vy * vy + vz * vz)
	// Forward declaration is required because of the retrun value (float).
}
#file "utils/IsPlayerAFK.pwn"
#line 0
/**
 * <summary>Checks if a player is AFK.</summary>
 * <param name="playerid">Player's ID.</param>
 * <returns>True if player is AFK, false if not.</returns>
 */
AC_PUBLIC AC_IsPlayerAFK(playerid) {
	if (IsPlayerConnected(playerid)) {
		return (GetTickCount() - AC_players[playerid][AC_pLastUpdate]) > AC_AFK_TIME;
	}
	return false;
}
#file "utils/IsPlayerAtVendingMachine.pwn"
#line 0
/**
 * <summary>Checks if a player is around a vending machine.</summary>
 * <param name="playerid">Player's ID.</param>
 * <returns>True if the player is near a vending machine or false if not.</returns>
 */
stock AC_IsPlayerAtVendingMachine(playerid) {
	for (new i = 0; i != sizeof(AC_VENDING_MACHINES); ++i) {
		if (IsPlayerInRangeOfPoint(playerid, AC_VENDING_MACHINE_RANGE, AC_VENDING_MACHINES[i][0], AC_VENDING_MACHINES[i][1], AC_VENDING_MACHINES[i][2])) {
			return true;
		}
	}
	return false;
}
#file "utils/IsPlayerSpawned.pwn"
#line 0
/**
 * <summary>Checks if a player is spawned.</summary>
 * <param name="playerid">Player's ID.</param>
 * <returns>True if player is spawned, false if not.</returns>
 */
AC_PUBLIC AC_IsPlayerSpawned(playerid) {
	if (IsPlayerConnected(playerid)) {
		return AC_players[playerid][AC_pState] & AC_psSpawn ? true : false;
	}
	return false;
}
#file "utils/memset.pwn"
#line 0
/**
 * <author>Slice</author>
 * <remarks>http://forum.sa-mp.com/showthread.php?p=1606781</remarks>
 */
stock memset(aArray[], iValue, iSize = sizeof(aArray)) {
	new iAddress;
	// Store the address of the array
	#emit LOAD.S.pri 12
	#emit STOR.S.pri iAddress
	// Convert the size from cells to bytes
	iSize *= 4;
	// Loop until there is nothing more to fill
	while (iSize > 0) {
		// I have to do this because the FILL instruction doesn't accept a dynamic number.
		if (iSize >= 4096) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 4096
			iSize -= 4096;
			iAddress += 4096;
		} else if (iSize >= 1024) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 1024
			iSize -= 1024;
			iAddress += 1024;
		} else if (iSize >= 256) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 256
			iSize -= 256;
			iAddress += 256;
		} else if (iSize >= 64) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 64
			iSize -= 64;
			iAddress += 64;
		} else if (iSize >= 16) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 16
			iSize -= 16;
			iAddress += 16;
		} else {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 4
			iSize -= 4;
			iAddress += 4;
		}
	}
	// aArray is used, just not by its symbol name
	#pragma unused aArray
}
#file "utils/sync/IsPlayerSynced.pwn"
#line 0
/**
 * <summary>Checks a player's sync status.</summary>
 * <param name="playerid">Player's ID.</param>
 * <param name="sync">Sync's ID.</param>
 * <returns>True if player is synced, false if not.</returns>
 */
stock AC_IsPlayerSynced(playerid, sync) {
	if (IsPlayerConnected(playerid)) {
		return (AC_players[playerid][AC_pSync] & (1 << sync)) ? true : false;
	}
	return false;
}
#file "utils/sync/SetPlayerSync.pwn"
#line 0
/**
 * <summary>Sets a player's sync status.</summary>
 * <param name="playerid">Player's ID.</param>
 * <param name="sync">Sync's ID.</param>
 * <param name="status">Is player synced or not?</param>
 */
stock AC_SetPlayerSync(playerid, sync, status = true) {
	if (IsPlayerConnected(playerid)) {
		if (status) {
			AC_players[playerid][AC_pSync] |= 1 << sync;
			AC_players[playerid][AC_pSyncFails][sync] = 0;
		} else {
			AC_players[playerid][AC_pSync] &= ~(1 << sync);
			++AC_players[playerid][AC_pSyncFails][sync];
			if (AC_players[playerid][AC_pSyncFails][sync] % AC_SYNC_MAX_FAILS == 0) {
				AC_CheatDetected(playerid, AC_cSync, sync, "");
			}
		}
	}
}
#file "hooks/natives/GetPlayerMoney.pwn"
#line 0
// GetPlayerMoney hook.
AC_PUBLIC AC_GetPlayerMoney(playerid) {
	if (IsPlayerConnected(playerid)) {
		new bad_money = U_GetPlayerMoney(playerid);
		return bad_money < AC_players[playerid][AC_pMoney] ? bad_money : AC_players[playerid][AC_pMoney];
	}
	return 0;
}
#if defined _ALS_GetPlayerMoney
	#undef GetPlayerMoney
#else
	#define _ALS_GetPlayerMoney
#endif
#define GetPlayerMoney AC_GetPlayerMoney
#file "hooks/natives/GetPlayerSpecialAction.pwn"
#line 0
// GetPlayerSpecialAction hook.
AC_PUBLIC AC_GetPlayerSpecialAction(playerid) {
	if (IsPlayerConnected(playerid)) {
		return AC_players[playerid][AC_pSpecialAction];
	}
	return SPECIAL_ACTION_NONE;
}
#if defined _ALS_GetPlayerSpecialAction
	#undef GetPlayerSpecialAction
#else
	#define _ALS_GetPlayerSpecialAction
#endif
#define GetPlayerSpecialAction AC_GetPlayerSpecialAction
#file "hooks/natives/GivePlayerMoney.pwn"
#line 0
// GivePlayerMoney hook.
AC_PUBLIC AC_GivePlayerMoney(playerid, money) {
	if (IsPlayerConnected(playerid)) {
		AC_players[playerid][AC_pMoney] += money;
	}
	return GivePlayerMoney(playerid, money);
}
#if defined _ALS_GivePlayerMoney
	#undef GivePlayerMoney
#else
	#define _ALS_GivePlayerMoney
#endif
#define GivePlayerMoney AC_GivePlayerMoney
#file "hooks/natives/ResetPlayerMoney.pwn"
#line 0
// ResetPlayerMoney hook.
AC_PUBLIC AC_ResetPlayerMoney(playerid) {
	if (IsPlayerConnected(playerid)) {
		AC_players[playerid][AC_pMoney] = 0;
	}
	return ResetPlayerMoney(playerid);
}
#if defined _ALS_ResetPlayerMoney
	#undef ResetPlayerMoney
#else
	#define _ALS_ResetPlayerMoney
#endif
#define ResetPlayerMoney AC_ResetPlayerMoney
#file "hooks/natives/SetPlayerArmour.pwn"
#line 0
// SetPlayerArmour hook.
AC_PUBLIC AC_SetPlayerArmour(playerid, Float:armour) {
	if (IsPlayerConnected(playerid)) {
		AC_players[playerid][AC_pArmour] = armour;
		AC_SetPlayerSync(playerid, AC_sArmour, false);
	}
	return SetPlayerArmour(playerid, armour);
}
#if defined _ALS_SetPlayerArmour
	#undef SetPlayerArmour
#else
	#define _ALS_SetPlayerArmour
#endif
#define SetPlayerArmour AC_SetPlayerArmour
#file "hooks/natives/SetPlayerHealth.pwn"
#line 0
// SetPlayerHealth hook.
AC_PUBLIC AC_SetPlayerHealth(playerid, Float:health) {
	if (IsPlayerConnected(playerid)) {
		AC_players[playerid][AC_pHealth] = health;
		AC_SetPlayerSync(playerid, AC_sHealth, false);
	}
	return SetPlayerHealth(playerid, health);
}
#if defined _ALS_SetPlayerHealth
	#undef SetPlayerHealth
#else
	#define _ALS_SetPlayerHealth
#endif
#define SetPlayerHealth AC_SetPlayerHealth
#file "hooks/natives/SetPlayerSpecialAction.pwn"
#line 0
// SetPlayerSpecialAction hook.
AC_PUBLIC AC_SetPlayerSpecialAction(playerid, actionid) {
	if (IsPlayerConnected(playerid)) {
		AC_players[playerid][AC_pSpecialAction] = actionid;
	}
	return SetPlayerSpecialAction(playerid, actionid);
}
#if defined _ALS_SetPlayerSpecialAction
	#undef SetPlayerSpecialAction
#else
	#define _ALS_SetPlayerSpecialAction
#endif
#define SetPlayerSpecialAction AC_SetPlayerSpecialAction
#file "hooks/callbacks/OnPlayerCommandText.pwn"
#line 0
// OnPlayerCommandText hook.
public OnPlayerCommandText(playerid, cmdtext[]) {
	AC_players[playerid][AC_pLastUpdate] = GetTickCount();
	#if defined AC_OnPlayerCommandText
		return AC_OnPlayerCommandText(playerid, cmdtext);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerCommandText
	#undef OnPlayerCommandText
#else
	#define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText AC_OnPlayerCommandText

#if defined AC_OnPlayerCommandText
	forward AC_OnPlayerCommandText(playerid, cmdtext[]);
#endif
#file "hooks/callbacks/OnPlayerConnect.pwn"
#line 0
// OnPlayerConnect hook.
public OnPlayerConnect(playerid) {
	memset(AC_players[playerid], 0, AC_ePlayer);
	#if defined AC_OnPlayerConnect
		return AC_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect AC_OnPlayerConnect

#if defined AC_OnPlayerConnect
	forward AC_OnPlayerConnect(playerid);
#endif
#file "hooks/callbacks/OnPlayerDeath.pwn"
#line 0
// OnPlayerDeath hook.
public OnPlayerDeath(playerid) {
	AC_players[playerid][AC_pState] &= ~AC_psSpawn;
	#if defined AC_OnPlayerDeath
		return AC_OnPlayerDeath(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath AC_OnPlayerDeath

#if defined AC_OnPlayerDeath
	forward AC_OnPlayerDeath(playerid);
#endif
#file "hooks/callbacks/OnPlayerSpawn.pwn"
#line 0
// OnPlayerSpawn hook.
public OnPlayerSpawn(playerid) {
	AC_players[playerid][AC_pState] = 0;
	AC_players[playerid][AC_pState] |= AC_psSpawn;
	AC_players[playerid][AC_pState] &= ~AC_psFreeze;
	AC_players[playerid][AC_pSync] = 0;
	AC_players[playerid][AC_pLastUpdate] = GetTickCount();
	AC_players[playerid][AC_pHealth] = 100.0;
	AC_players[playerid][AC_pArmour] = 0.0;
	// TODO: Update position.
	// TODO: Update weapons.
	AC_players[playerid][AC_pSpecialAction] = SPECIAL_ACTION_NONE;
	#if defined AC_OnPlayerSpawn
		return AC_OnPlayerSpawn(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn AC_OnPlayerSpawn

#if defined AC_OnPlayerSpawn
	forward AC_OnPlayerSpawn(playerid);
#endif
#file "hooks/callbacks/OnPlayerText.pwn"
#line 0
// OnPlayerText hook.
public OnPlayerText(playerid, text[]) {
	AC_players[playerid][AC_pLastUpdate] = GetTickCount();
	#if defined AC_OnPlayerText
		return AC_OnPlayerText(playerid, text);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif
#define OnPlayerText AC_OnPlayerText

#if defined AC_OnPlayerText
	forward AC_OnPlayerText(playerid, text[]);
#endif
#file "hooks/callbacks/OnPlayerUpdate.pwn"
#line 0
// OnPlayerUpdate hook.
public OnPlayerUpdate(playerid) {
	AC_players[playerid][AC_pLastUpdate] = GetTickCount();
	#if defined AC_OnPlayerUpdate
		return AC_OnPlayerUpdate(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate AC_OnPlayerUpdate

#if defined AC_OnPlayerUpdate
	forward AC_OnPlayerUpdate(playerid);
#endif
#file "hooks/callbacks/OnScriptExit.pwn"
#line 0
/**
 * <summary>Called when the anticheat's core is being destroyed.</summary>
 */
stock AC_OnScriptExit() {
	KillTimer(AC_watchguardTimer);
	return 1;
}

// Killing watchguard timer.
#if defined FILTERSCRIPT
	public OnFilterScriptExit() {
		AC_OnScriptExit();
		#if defined AC_OnFilterScriptExit
			return AC_OnFilterScriptExit();
		#else
			return 1;
		#endif
	}
	
	#if defined _ALS_OnFilterScriptExit
		#undef OnFilterScriptExit
	#else
		#define _ALS_OnFilterScriptExit
	#endif
	#define OnFilterScriptExit AC_OnFilterScriptExit
	
	#if defined AC_OnFilterScriptExit
		forward AC_OnFilterScriptExit();
	#endif
#else
	public OnGameModeExit() {
		AC_OnScriptExit();
		#if defined AC_OnGameModeExit
			return AC_OnGameModeExit();
		#else
			return 1;
		#endif
	}
	
	#if defined _ALS_OnGameModeExit
		#undef OnGameModeExit
	#else
		#define _ALS_OnGameModeExit
	#endif
	#define OnGameModeExit AC_OnGameModeExit
	
	#if defined AC_OnGameModeExit
		forward AC_OnGameModeExit();
	#endif
#endif
#file "hooks/callbacks/OnScriptInit.pwn"
#line 0
/**
 * <summary>Called when the anticheat's core is being initialized.</summary>
 */
stock AC_OnScriptInit() {
	_AC_DEBUG("[anticheat] Anticheat's timer succesfully injected!");
	AC_watchguardTimer = SetTimer(#AC_Watchguard, AC_WATCHGUARD_INTERVAL, true);
	return 1;
}

// Starting watchguard timer.
#if defined FILTERSCRIPT
	public OnFilterScriptInit() {
		AC_OnScriptInit();
		#if defined AC_OnFilterScriptInit
			return AC_OnFilterScriptInit();
		#else
			return 1;
		#endif
	}
	
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit AC_OnFilterScriptInit
	
	#if defined AC_OnFilterScriptInit
		forward AC_OnFilterScriptInit();
	#endif
#else
	public OnGameModeInit() {
		AC_OnScriptInit();
		#if defined AC_OnGameModeInit
			return AC_OnGameModeInit();
		#else
			return 1;
		#endif
	}
	
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit AC_OnGameModeInit
	
	#if defined AC_OnGameModeInit
		forward AC_OnGameModeInit();
	#endif
#endif
#file "watchguard/Watchguard.pwn"
#line 0
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
		if (AC_cheats[AC_cMoney][AC_ccIsEnabled]) {
			AC_Watchguard_Money(playerid);
		}
		if (AC_cheats[AC_cJoypad][AC_ccIsEnabled]) {
			AC_Watchguard_Joypad(playerid);
		}
		if (AC_cheats[AC_cJetpack][AC_ccIsEnabled]) {
			AC_Watchguard_Jetpack(playerid);
		}
		// TODO: Hook other modules.
	}
}
#file "watchguard/impl/AC_Watchguard_Ping.pwn"
#line 0
/**
 * <summary>Checks if a player is using armour hack.</summary>
 * <param name="playerid">Player's ID.</param>
 */
stock AC_Watchguard_Ping(playerid) {
	if (GetPlayerPing(playerid) > AC_MAX_PING) {
		AC_CheatDetected(playerid, AC_cPing);
	}
}
#file "watchguard/impl/Watchguard_Armour.pwn"
#line 0
/**
 * <summary>Checks if a player is using armour hack.</summary>
 * <param name="playerid">Player's ID.</param>
 */
stock AC_Watchguard_Armour(playerid) {
	new Float:armour;
	GetPlayerArmour(playerid, armour);
	if (!AC_IsPlayerSynced(playerid, AC_sArmour)) {
		AC_SetPlayerSync(playerid, AC_sArmour, armour == AC_players[playerid][AC_pArmour]);
	} else {
		if (armour > AC_players[playerid][AC_pArmour]) {
			AC_CheatDetected(playerid, AC_cArmour);
		}
		AC_players[playerid][AC_pArmour] = armour;
	}
}
#file "watchguard/impl/Watchguard_Health.pwn"
#line 0
/**
 * <summary>Checks if a player is using health hack.</summary>
 * <param name="playerid">Player's ID.</param>
 */
stock AC_Watchguard_Health(playerid) {
	new Float:health;
	GetPlayerHealth(playerid, health);
	if (!AC_IsPlayerSynced(playerid, AC_sHealth)) {
		AC_SetPlayerSync(playerid, AC_sHealth, health == AC_players[playerid][AC_pHealth]);
	} else {
		if ((!AC_IsPlayerAtVendingMachine(playerid)) && (health > AC_players[playerid][AC_pHealth])) {
			AC_CheatDetected(playerid, AC_cHealth);
		}
		AC_players[playerid][AC_pHealth] = health;
	}
}
#file "watchguard/impl/Watchguard_Jetpack.pwn"
#line 0
/**
 * <summary>Checks if a player is using jetpack hack.</summary>
 * <param name="playerid">Player's ID.</param>
 */
stock AC_Watchguard_Jetpack(playerid) {
	new bad_action = U_GetPlayerSpecialAction(playerid), action = GetPlayerSpecialAction(playerid);
	if ((bad_action == SPECIAL_ACTION_USEJETPACK) && (action != SPECIAL_ACTION_USEJETPACK)) {
		// TODO: Check if the player is near a jetpack pickup.
		AC_CheatDetected(playerid, AC_cJetpack);
	}
}
#file "watchguard/impl/Watchguard_Joypad.pwn"
#line 0
/**
 * <summary>Checks if a player is using a joypad.</summary>
 * <param name="playerid">Player's ID.</param>
 */
stock AC_Watchguard_Joypad(playerid) {
	new keys, ud, lr;
	GetPlayerKeys(playerid, keys, ud, lr);
	if (((ud != 128) && (ud != 0) && (ud != -128)) || ((lr != 128) && (lr != 0) && (lr != -128))) {
		AC_CheatDetected(playerid, AC_cJoypad);
	}
}
#file "watchguard/impl/Watchguard_Money.pwn"
#line 0
/**
 * <summary>Checks if a player is using money hack.</summary>
 * <param name="playerid">Player's ID.</param>
 */
stock AC_Watchguard_Money(playerid) {
	new bad_money = U_GetPlayerMoney(playerid), money = GetPlayerMoney(playerid);
	if (bad_money > money) {
		AC_CheatDetected(playerid, AC_cMoney);
	}
}
#file "./Anticheat.inc"
#line 0