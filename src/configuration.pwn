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