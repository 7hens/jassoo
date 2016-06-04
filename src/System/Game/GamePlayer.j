// no confliction!
private function clearSelection () {ClearSelection();}
private function selectUnit (unit u, boolean flag) {SelectUnit(u, flag);}

public struct GamePlayer [15] {
	Group SelectedUnits;
	private player h;

	method operator GivesBounty ()->boolean {return GetPlayerState(this.h, PLAYER_STATE_GIVES_BOUNTY)== 1;}
	method operator GivesBounty= (boolean value) {SetPlayerState(this.h, PLAYER_STATE_GIVES_BOUNTY, Convert.B2I(value));}
	method operator Followable ()->boolean {return GetPlayerState(this.h, PLAYER_STATE_UNFOLLOWABLE)== 0;}
	method operator Followable= (boolean value) {SetPlayerState(this.h, PLAYER_STATE_UNFOLLOWABLE, Convert.B2I(value));}
	method operator Team ()->integer {return GetPlayerTeam(this.h);}
	method operator Team= (integer team) {SetPlayerTeam(this.h, team);}
	method operator Gold ()->integer {return GetPlayerState(this.h, PLAYER_STATE_RESOURCE_GOLD);}
	method operator Gold= (integer gold) {SetPlayerState(this.h, PLAYER_STATE_RESOURCE_GOLD, gold);}
	method operator Food ()->integer {return GetPlayerState(this.h, PLAYER_STATE_RESOURCE_FOOD_USED);}
	method operator Food= (integer food) {SetPlayerState(this.h, PLAYER_STATE_RESOURCE_FOOD_USED, food);}
	method operator FoodCap ()->integer {return GetPlayerState(this.h, PLAYER_STATE_RESOURCE_FOOD_CAP);}
	method operator FoodCap= (integer foodCap) {SetPlayerState(this.h, PLAYER_STATE_RESOURCE_FOOD_CAP, foodCap);}
	method operator FoodCapCeiling ()->integer {return GetPlayerState(this.h, PLAYER_STATE_FOOD_CAP_CEILING);}
	method operator FoodCapCeiling= (integer value) {SetPlayerState(this.h, PLAYER_STATE_FOOD_CAP_CEILING, value);}
	method operator Name ()->string {return GetPlayerName(this.h);}
	method operator Name= (string name) {SetPlayerName(this.h, name);}
	method operator StartX ()->real {return GetStartLocationX(GetPlayerStartLocation(this.h));}
	method operator StartY ()->real {return GetStartLocationY(GetPlayerStartLocation(this.h));}
	method operator Handicap ()->real {return GetPlayerHandicap(this.h);}
	method operator Handicap= (real value) {SetPlayerHandicap(this.h, value);}
	method operator IsObserver ()->boolean {return IsPlayerObserver(this.h);}
	method operator IsLocal()->boolean {return this.h== GetLocalPlayer();}

	method GetTechResearched (integer techId)->integer {return GetPlayerTechCount(this.h, techId, true);}
	method SetTechResearched (integer techId, integer level) {SetPlayerTechResearched(this.h, techId, level);}
	method GetTechMaxAllowed (integer techId)->integer {return GetPlayerTechMaxAllowed(this.h, techId);}
	method SetTechMaxAllowed (integer techId, integer maximum) {SetPlayerTechMaxAllowed(this.h, techId, maximum);}
	method SetAbilityAvailable (integer abid, boolean avail) {SetPlayerAbilityAvailable(this.h, abid, avail);}
	method ShowMessage (string text, real x, real y, real dura) {DisplayTimedTextToPlayer(this.h, x, y, dura, text);}

	method operator Color ()->Argb {
		playercolor playerColor= GetPlayerColor(this.h);
		if (playerColor==PLAYER_COLOR_RED) {
			return 0xFFFF0303;
		} else if (playerColor==PLAYER_COLOR_BLUE) {
			return 0xFF0042FF;
		} else if (playerColor==PLAYER_COLOR_CYAN) {
			return 0xFF1CE6B9;
		} else if (playerColor==PLAYER_COLOR_PURPLE) {
			return 0xFF540081;
		} else if (playerColor==PLAYER_COLOR_YELLOW) {
			return 0xFFFFFC01;
		} else if (playerColor==PLAYER_COLOR_ORANGE) {
			return 0xFFFE8A0E;
		} else if (playerColor==PLAYER_COLOR_GREEN) {
			return 0xFF20C000;
		} else if (playerColor==PLAYER_COLOR_PINK) {
			return 0xFFE55BB0;
		} else if (playerColor==PLAYER_COLOR_LIGHT_GRAY) {
			return 0xFF959697;
		} else if (playerColor==PLAYER_COLOR_LIGHT_BLUE) {
			return 0xFF7EBFF1;
		} else if (playerColor==PLAYER_COLOR_AQUA) {
			return 0xFF106246;
		} else if (playerColor==PLAYER_COLOR_BROWN) {
			return 0xFF4E2A04;
		}
		return 0xFF111111;
	}
	method SelectUnit (Unit u, boolean flag) {if (this.IsLocal) selectUnit(u.Handle, flag);}
	method ClearSelection () {if (this.IsLocal) clearSelection();}

	private static method onInit () {
		integer i= 0;
		GamePlayer this= 0;
		for (0<= i< 16) {
			this= i;
			this.h= Player(i);
			this.SelectedUnits= Group.create();
			this.GivesBounty= true;
		}
		Event.Select.Add(function (Unit u) {
			Event.Player.SelectedUnits.Add(u);
		});
		Event.Deselect.Add(function (Unit u) {
			Event.Player.SelectedUnits.Remove(u);
		});
	}
 }
