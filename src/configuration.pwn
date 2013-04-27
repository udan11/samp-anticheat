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
stock AC_cheats[AC_eCheats][AC_eCheatConfig] = {
	// AC_cUnknown
	{false, "unknown hack"},
	// AC_cSync
	{false, "sync hack"},
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