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
 * <summary>Macro used to label variables, functions, etc. used by this anticheat.</summary>
 */
#define AC::							AC_

/**
 * <summary>Macro used to generate automatic forward declarations.</summary>
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
	#define EXTERN:%0<%1>(%2) \
		stock AC::%0 (%2) \
			return CallRemoteFunction ("JB_"#%0, #%1, %2)
	// TODO.
	#endinput // We stop here, we don't need the core.
#endif
#file "constants/cheats.pwn"
#line 0
/**
 * <summary>Maximum name of a cheat.</summary>
 */
#define AC_MAX_CHEAT_NAME				32

/**
 * <summary>An enumeration with the basic definitons of the cheats.</summary>
 */
enum AC::eCheats {

	/**
	 * <summary>Unknown hack (used for internal purpose).</summary>
	 */
	AC::cUnknown,  // TODO
	
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
 * <summary>This deals with FPS spikes.</summary>
 */
#define AC_MAX_FPS_INDEX				4

/**
 * <summary>Maximum slots for weapons.</summary>
 */
#define AC_MAX_WEAPON_SLOTS				13
#file "constants/sync.pwn"
#line 0
/**
 * <summary>Max sync types.</summary>
 */
#define AC_MAX_SYNC						32

/**
 * <summary>Sync types.</summary>
 */
enum AC::eSync (<<= 1) {
	AC::s00 = 1,						// bitmask  0
	AC::s01,							// bitmask  1
	AC::s02,							// bitmask  2
	AC::s03,							// bitmask  3
	AC::s04,							// bitmask  4
	AC::s05,							// bitmask  5
	AC::s06,							// bitmask  6
	AC::s07,							// bitmask  7
	AC::s08,							// bitmask  8
	AC::s09,							// bitmask  9
	AC::s10,							// bitmask 10
	AC::s11,							// bitmask 11
	AC::s12,							// bitmask 12
	AC::s13,							// bitmask 13
	AC::s14,							// bitmask 14
	AC::s15,							// bitmask 15
	AC::s16,							// bitmask 16
	AC::s17,							// bitmask 17
	AC::s18,							// bitmask 18
	AC::s19,							// bitmask 19
	AC::s20,							// bitmask 10
	AC::s21,							// bitmask 21
	AC::s22,							// bitmask 22
	AC::s23,							// bitmask 23
	AC::s24,							// bitmask 24
	AC::s25,							// bitmask 25
	AC::s26,							// bitmask 26
	AC::s27,							// bitmask 27
	AC::s28,							// bitmask 28
	AC::s29,							// bitmask 29
	AC::s30,							// bitmask 30
	AC::s31,							// bitmask 31
};
#file "variables.pwn"
#line 0
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
	AC::pSynced,
	
	/**
	 * <summary>Keeps track of player's sync failures.</summary>
	 */
	AC::pSyncFails[AC_MAX_SYNC],

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

/**
 * <summary>Should 2D speeds be used?</summary>
 * <remarks>
 * 		Using 2D positions reduces the number of fake reports.
 *		When 3D positions are used, falling is reported as speed / teleport hack (sometimes).
 * </remarks>
 */
stock AC::use2dPositions = true;
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
			iSize    -= 4096;
			iAddress += 4096;
		} else if (iSize >= 1024) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 1024
			iSize    -= 1024;
			iAddress += 1024;
		} else if (iSize >= 256) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 256
			iSize    -= 256;
			iAddress += 256;
		} else if (iSize >= 64) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 64
			iSize    -= 64;
			iAddress += 64;
		} else if (iSize >= 16) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 16
			iSize    -= 16;
			iAddress += 16;
		} else {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 4
			iSize    -= 4;
			iAddress += 4;
		}
	}
	// aArray is used, just not by its symbol name
	#pragma unused aArray
}
#file "watchguard/Watchguard.pwn"
#line 0
/**
 * <summary>Anticheat's main function. Supervises players' actions.</summary>
 */
AC_PUBLIC:Watchguard() {
	/*
	foreach (new playerid : Player) {
		if (!IsPlayerSpawned(playerid)) {
			continue;
		} else if (IsPlayerAFK(playerid)) {
			continue;
		}
		// TODO: Perform checks.
	}
	*/
}
#file "./Anticheat.pwn"
#line 0