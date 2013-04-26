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
 * <summary>Macro used to label anticheat's variables, functions, etc.</summary>
 */
#define AC::							AC_

/**
 * <summary>Generate forward declarations for public and stock functions.</summary>
 */
#define AC_PUBLIC:%0(%1) \
	forward %0(%1); public %0(%1)
#define AC_STOCK:%0(%1) \
	forward %0(%1); stock %0(%1)

/**
 * <summary>Creates a stock that calls remote functions.</summary>
 */
#define REMOTE:%0<%1>(%2) \
	stock AC_%0(%2) return CallRemoteFunction(#AC::#%0,#%1,%2)
#file "api.pwn"
#line 0
// We check if no parameter was passed to the anticheat.
#if (!defined ANTICHEAT_CORE) && (!defined ANTICHEAT_API)
	#if defined FILTERSCRIPT
		#define ANTICHEAT_API
	#else
		#define ANTICHEAT_CORE
	#endif
#endif

#if defined ANTICHEAT_API

	/**
	 * <summary>API used by remote scripts (other than the core).</summary>
	 */
	// TODO.
	
	#if defined ANTICHEAT_NEW_FUNCTIONS
		/*
		REMOTE:IsPlayerAFK<i>(playerid);
		REMOTE:IsPlayerSpawned<i>(playerid);
		*/
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
forward Anticheat_OnCheatDetected(playerid, cheatid, extraid = 0, info[] = "");

// Defines new functions. Not the real purpose of this anticheat.
#if defined ANTICHEAT_NEW_FUNCTIONS
	/*
	#define IsPlayerAFK				AC::IsPlayerAFK
	#define IsPlayerSpawned			AC::IsPlayerSpawned
	*/
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
enum _:AC::eCheats {

	/**
	 * <summary>Unknown hack (used for internal purpose).</summary>
	 */
	AC::cUnknown,
	
	/**
	 * <summary>Not an actual hack. Used for desynced players.</summary>
	 */
	AC::cSync, // TODO
	
	/**
	 * <summary>Not an actual hack. Players with high ping usually spoils other players' gameplay.</summary>
	 */
	AC::cPing, // TODO
	
	/**
	 * <summary>Not an actual hack. Players with low FPS usually spoils other players' gameplay.</summary>
	 */
	AC::cFPS, // TODO
	
	/**
	 * <summary>Not an actual hack. Used for AFK players.</summary>
	 */
	AC::cAFK, // TODO
	
	/**
	 * <summary>Health hack. Restores user's health.</summary>
	 */
	AC::cHealth, // TODO
	
	/**
	 * <summary>Armour hack. Restores user's armour.</summary>
	 */
	AC::cArmour, // TODO
	
	/**
	 * <summary>Money hack.</summary>
	 */
	AC::cMoney, // TODO
	
	/**
	 * <summary>Fake kill. The user is reported to have been killed by multiple persons in short interval.</summary>
	 */
	AC::cFakeKill, // TODO
	
	/**
	 * <summary>Teleport hack. Gives the ability to teleport.</summary>
	 */
	AC::cTeleport, // TODO
	
	/**
	 * <summary>Speed hack. The user / it's vehicle moves faster.</summary>
	 */
	AC::cSpeed, // TODO
	
	/**
	 * <summary>Fly hack. The user looks like he is flying.</summary>
	 */
	AC::cFly, // TODO
	
	/**
	 * <summary>Airbreak hack.</summary>
	 */
	AC::cAirbreak, // TODO
	
	/**
	 * <summary>Weapon hack. The user has the ability to spawn weapons.</summary>
	 */
	AC::cWeapon, // TODO
	
	/**
	 * <summary>Not an actual hack. It detect the player using joypads. It's easier to aim using a joypad.</summary>
	 */
	AC::cJoypad, // TODO
	
	/**
	 * <summary>Aim bot detection. This cheat is quite new and detection methods are not very accurate.</summary>
	 */
	AC::cAimBot, // TODO
	
	/**
	 * <summary>Jetpack hack. Detects if a player has acquired a jetpack in a unscripted way.</summary>
	 */
	AC::cJetpack, // TODO
	
	/**
	 * <summary>Vehicle warp hack. The user has the ability to warp vehicles around him.</summary>
	 */
	AC::cVehicleWarp, // TODO
	
	/**
	 * <summary>Vehicle repair hack. The user has the ability to repair its vehicle without going to a repair / modding shop.</summary>
	 */
	AC::cVehicleRepair, // TODO
	
	/**
	 * <summary>Vehicle mod hack. The user adds (illegal) mods without being in a modding shop.</summary>
	 */
	AC::cVehicleMod, // TODO
	
	/**
	 * <summary>RCON bruteforces. If a player tries to find the RCON password.</summary>
	 */
	AC::cRconBruteforce, // TODO
	
	/**
	 * <summary>Checks if a player is using the famous `m0d_sa` AIO hacking tool.</summary>
	 */
	AC::cModSa, // TODO
};

/**
 * <summary>Enumeration used to define the configuration of an anti-cheat module.</summary>
 */
enum AC::eCheatConfig {
	AC::ccIsEnabled,
	AC::ccName[AC_MAX_CHEAT_NAME]
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
#file "constants/player.pwn"
#line 0
/**
 * Player states.
 */
enum _:AC::ePlayerState {
	AC::psSpawn = 1,					// bitmask  0
	AC::psFreeze,						// bitmask  1
	AC::ps02,							// bitmask  2
	AC::ps03,							// bitmask  3
	AC::ps04,							// bitmask  4
	AC::ps05,							// bitmask  5
	AC::ps06,							// bitmask  6
	AC::ps07,							// bitmask  7
	AC::ps08,							// bitmask  8
	AC::ps09,							// bitmask  9
	AC::ps10,							// bitmask 10
	AC::ps11,							// bitmask 11
	AC::ps12,							// bitmask 12
	AC::ps13,							// bitmask 13
	AC::ps14,							// bitmask 14
	AC::ps15,							// bitmask 15
	AC::ps16,							// bitmask 16
	AC::ps17,							// bitmask 17
	AC::ps18,							// bitmask 18
	AC::ps19,							// bitmask 19
	AC::ps20,							// bitmask 10
	AC::ps21,							// bitmask 21
	AC::ps22,							// bitmask 22
	AC::ps23,							// bitmask 23
	AC::ps24,							// bitmask 24
	AC::ps25,							// bitmask 25
	AC::ps26,							// bitmask 26
	AC::ps27,							// bitmask 27
	AC::ps28,							// bitmask 28
	AC::ps29,							// bitmask 29
	AC::ps30,							// bitmask 30
	AC::ps31,							// bitmask 31
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
enum _:AC::eSync {
	AC::sHealth,
	AC::sArmour
};
#file "variables.pwn"
#line 0
/**
 * The ID of the watchguard timer.
 */
stock AC::watchguardTimer = 0;

/**
 * <summary>Stores a player's game data.</summary>
 */
enum AC::ePlayer {

	/**
	 * <summary>Player's last known state.</summary>
	 */
	AC::pState,
	
	/**
	 * <summary>Player's sync status.</summary>
	 */
	AC::pSync,
	
	/**
	 * <summary>Keeps track of player's sync failures.</summary>
	 */
	AC::pSyncFails[AC::eSync],

	/**
	 * <summary>Stores latest FPS measurements.</summary>
	 */
	AC::pFPS[AC_MAX_FPS_INDEX],

	/**
	 * <summary>The time (in ms) when the player was last updated.</summary>
	 */
	AC::pLastUpdate,

	/**
	 * <summary>Player's health.</summary>
	 */
	Float:AC::pHealth,

	/**
	 * <summary>Player's armour.</summary>
	 */
	Float:AC::pArmour,

	/**
	 * <summary>Player's money.</summary>
	 */
	AC::pMoney,

	/**
	 * <summary>The latest time (in ms) when the player died.</summary>
	 */
	AC::pLastDeath,
	
	/**
	 * <summary>Player's latest known position.</summary>
	 */
	Float:AC::pPos[3],
	
	/**
	 * <summary>Player's latest known velocity.</summary>
	 */
	Float:AC::pVelocity[3],
	
	/**
	 * <summary>Player's weapons (ID and ammo).</summary>
	 * <remarks>Two fields are used instead of a bidimensional array because Pawn doesn't support 4D arrays.</remarks>
	 */
	AC::pWeaponsID[AC_MAX_WEAPON_SLOTS],
	AC::pWeaponsAmmo[AC_MAX_WEAPON_SLOTS],
	
	/**
	 * <summary>Player's special action.</summary>
	 */
	AC::pSpecialAction,
	
};

/**
 * <summary>Stores players' game data.</summary>
 */
new AC::players[MAX_PLAYERS][AC::ePlayer];
#file "configuration.pwn"
#line 0
/**
 * <summary>The time (in ms) between checks.</summary>
 * <remarks>Default timers from SA-MP are lazy. I suggest using a timer-fix for better output.</remarks>
 */
#define AC_WATCHGUARD_INTERVAL			1500

/**
 * <summary>The time (in ms) after a player is considered AFK.</summary>
 */
#define AC_AFK_TIME						1500

/**
 * <summary>Whether two or three dimension vectors should be used.</summary>
 * <remarks>
 *		When 3D vectors are used, falling is reported as speed / teleport hack (sometimes).
 *		In other words, using 2D vectors reduces the number of fake reports.
 * </remarks>
 */
#define AC_USE_2D_VECTORS				true

/**
 * <summary>Variable that holds the state of specific anti-cheat module and it's name.</summary>
 */
stock AC::cheats[AC::eCheats][AC::eCheatConfig] = {
	// AC::cUnknown
	{false, "unknown hack"},
	// AC::cSync
	{false, "sync hack"},
	// AC::cPing
	{true, "high ping"},
	// AC::cFPS
	{true, "low fps"},
	// AC::cAFK
	{false, "afk"},
	// AC::cHealth
	{true, "health hack"},
	// AC::cArmour
	{true, "armour hack"},
	// AC::cMoney
	{true, "money hack"},
	// AC::cFakeKill
	{true, "fake kill"},
	// AC::cTeleport
	{true, "teleport hack"},
	// AC::cSpeed
	{true, "speed hack"},
	// AC::cFly
	{true, "fly hack"},
	// AC::cAirbreak
	{true, "airbreak hack"},
	// AC::cWeapon
	{true, "weapon hack"},
	// AC::cJoypad
	{true, "joypad"},
	// AC::cAimBot
	{true, "aim bot"},
	// AC::cJetpack
	{true, "jetpack hack"},
	// AC::cVehicleWarp
	{true, "vehicle warp hack"},
	// AC::cVehicleRepair
	{true, "vehicle repair hack"},
	// AC::cVehicleMod
	{true, "vehicle (illegal) mod"},
	// AC::cRconBruteforce
	{true, "RCON bruteforcer"},
	// AC::cModSa
	{true, "m0d_sa (hacking tool)"}
};
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
#file "impl/CheatDetected.pwn"
#line 0
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
#file "impl/IsPlayerAFK.pwn"
#line 0
/**
 * <summary>Checks if a player is AFK.</summary>
 * <param name="playerid">Player's ID.</param>
 * <returns>True if player is AFK, false if not.</returns>
 */
stock AC::IsPlayerAFK(playerid) {
	if (IsPlayerConnected(playerid)) {
		return (GetTickCount() - AC::players[playerid][AC::pLastUpdate]) > AC_AFK_TIME;
	}
	return false;
}
#file "impl/IsPlayerSpawned.pwn"
#line 0
/**
 * <summary>Checks if a player is spawned.</summary>
 * <param name="playerid">Player's ID.</param>
 * <returns>True if player is spawned, false if not.</returns>
 */
stock AC::IsPlayerSpawned(playerid) {
	if (IsPlayerConnected(playerid)) {
		return AC::players[playerid][AC::pState] & AC::psSpawn ? true : false;
	}
	return false;
}
#file "impl/sync/IsPlayerSynced.pwn"
#line 0
/**
 * <summary>Checks a player's sync status.</summary>
 * <param name="playerid">Player's ID.</param>
 * <param name="sync">Sync's ID.</param>
 * <returns>True if player is synced, false if not.</returns>
 */
stock AC::IsPlayerSynced(playerid, sync) {
	if (IsPlayerConnected(playerid)) {
		return (AC::players[playerid][AC::pSync] & (1 << sync)) ? true : false;
	}
	return false;
}
#file "impl/sync/SetPlayerSync.pwn"
#line 0
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
#file "watchguard/impl/Watchguard_Armour.pwn"
#line 0
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
#file "watchguard/impl/Watchguard_Health.pwn"
#line 0
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
#file "hooks/callbacks/OnScriptExit.pwn"
#line 0
// Killing watchguard timer.
#if defined FILTERSCRIPT
	public OnFilterScriptExit() {
		KillTimer(AC::watchguardTimer);
		if (funcidx(#AC_OnFilterScriptExit) != -1) {
			CallLocalFunction(#AC_OnFilterScriptExit, "");
		}
		return 1;
	}
	#if defined _ALS_OnFilterScriptExit
		#undef OnFilterScriptExit
	#else
		#define _ALS_OnFilterScriptExit
	#endif
	#define OnFilterScriptExit AC_OnFilterScriptExit
	forward AC_OnFilterScriptExit();
#else
	public OnGameModeExit() {
		KillTimer(AC::watchguardTimer);
		if (funcidx(#AC_OnGameModeExit) != -1) {
			CallLocalFunction(#AC_OnGameModeExit, "");
		}
		return 1;
	}
	#if defined _ALS_OnGameModeExit
		#undef OnGameModeExit
	#else
		#define _ALS_OnGameModeExit
	#endif
	#define OnGameModeExit AC_OnGameModeExit
	forward AC_OnGameModeExit();
#endif
#file "hooks/callbacks/OnScriptInit.pwn"
#line 0
// Injecting watchguard timer.
#if defined FILTERSCRIPT
	public OnFilterScriptInit() {
		AC::watchguardTimer = SetTimer(#AC::Watchguard, AC_WATCHGUARD_INTERVAL, true);
		if (funcidx(#AC_OnFilterScriptInit) != -1) {
			CallLocalFunction(#AC_OnFilterScriptInit, "");
		}
		return 1;
	}
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit AC_OnFilterScriptInit
	forward AC_OnFilterScriptInit();
#else
	public OnGameModeInit() {
		AC::watchguardTimer = SetTimer(#AC::Watchguard, AC_WATCHGUARD_INTERVAL, true);
		if (funcidx(#AC_OnGameModeInit) != -1) {
			CallLocalFunction(#AC_OnGameModeInit, "");
		}
		return 1;
	}
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit AC_OnGameModeInit
	forward AC_OnGameModeInit();
#endif
#file "watchguard/Watchguard.pwn"
#line 0
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
#file "./Anticheat.pwn"
#line 0