public struct Unit extends IWidget {
	module widgetModule;
	static constant integer DummyId= 'Udum';
	private delegate Point Point;
	private unit h;

	static method create (GamePlayer plr, integer typeId, Point pos, real face)->Unit {
		return Unit.bind(CreateUnit(Player(plr), typeId, pos.X, pos.Y, face));
	}
	method destroy () {RemoveUnit(this.h);}
	private static method bind (unit u)->Unit {
		integer id= GetHandleId(u);
		Unit this;
		if (Game.ExistsInt(id))
			return Game.LoadInt(id);
		this= Point.create();
		this.Point= this;
		this.h= u;
		Game.SaveInt(id, this);
		return this;
	}
	// implement Widget
	method operator Handle ()->unit {return this.h;}
	method operator TypeId ()->integer {return GetUnitTypeId(this.h);}
	method operator Visible ()->boolean {return !IsUnitHidden(this.h);}
	method operator Visible= (boolean visible) {ShowUnit(this.h, visible);}
	method operator Invulnerable= (boolean value) {SetUnitInvulnerable(this.h, value);}
	method operator UserData ()->integer {return GetUnitUserData(this.h);}
	method operator UserData= (integer data) {SetUnitUserData(this.h, data);}
	method operator Level ()->integer {return GetUnitLevel(this.h);}
	method operator Level= (integer level) {SetHeroLevel(this.h, level, false);}
	method operator MaxHp ()->real {return GetUnitState(this.h, UNIT_STATE_MAX_LIFE);}
	method operator Name ()->string {return GetUnitName(this.h);}
	method operator X= (real x) {SetUnitX(this.h, x);}
	method operator Y= (real y) {SetUnitY(this.h, y);}
	method operator Z= (real z) {this.FlyHeight= z- Point.GetTerrainZ(this.X, this.Y);}
	method operator FlyHeight ()->real {return GetUnitFlyHeight(this.h);}
	method operator FlyHeight= (real height) {SetUnitFlyHeight(this.h, height, 999999.9);}
	method operator Face ()->real {return Deg2Rad(GetUnitFacing(this.h));}
	method operator Face= (real face) {SetUnitFacingTimed(this.h, Rad2Deg(face), 0.0);}
	method operator Player ()->GamePlayer {return GetPlayerId(GetOwningPlayer(this.h));}
	method operator Player= (GamePlayer plr) {SetUnitOwner(this.h, Player(plr), true);}

	// Unit
	method operator Active ()->boolean {return !IsUnitPaused(this.h);}
	method operator Active= (boolean active) {PauseUnit(this.h, !active);}
	method operator Sleeping ()->boolean {return UnitIsSleeping(this.h);}
	method operator Sleeping= (boolean sleeping) {UnitAddSleep(this.h, sleeping);}
	method operator Pathing= (boolean pathing) {SetUnitPathing(this.h, pathing);}
	method operator FoodUsed ()->integer {return GetUnitFoodUsed(this.h);}
	method operator FoodMade ()->integer {return GetUnitFoodMade(this.h);}
	method operator Str ()->integer {return GetHeroStr(this.h, false);}
	method operator Str= (integer str) {SetHeroStr(this.h, str, true);}
	method operator Str2 ()->integer {return GetHeroStr(this.h, true)- GetHeroStr(this.h, false);}
	method operator Agi ()->integer {return GetHeroAgi(this.h, false);}
	method operator Agi= (integer agi) {SetHeroAgi(this.h, agi, true);}
	method operator Agi2 ()->integer {return GetHeroAgi(this.h, true)- GetHeroAgi(this.h, false);}
	method operator Int ()->integer {return GetHeroInt(this.h, false);}
	method operator Int= (integer int) {SetHeroInt(this.h, int, true);}
	method operator Int2 ()->integer {return GetHeroInt(this.h, true)- GetHeroInt(this.h, false);}
	method operator SkillPoints ()->integer {return GetHeroSkillPoints(this.h);}
	method operator SkillPoints= (integer value) {UnitModifySkillPoints(this.h, value);}
	method operator XP ()->integer {return GetHeroXP(this.h);}
	method operator XP= (integer xp) {SetHeroXP(this.h, xp, false);}
	method operator MP ()->real {return GetUnitState(this.h, UNIT_STATE_MANA);}
	method operator MP= (real mp) {SetUnitState(this.h, UNIT_STATE_MANA, mp);}
	method operator MaxMP ()->real {return GetUnitState(this.h, UNIT_STATE_MAX_MANA);}
	method operator MoveSpeed ()->real {return GetUnitMoveSpeed(this.h);}
	method operator MoveSpeed= (real moveSpeed) {SetUnitMoveSpeed(this.h, moveSpeed);}
	method operator DefaultMoveSpeed ()->real {return GetUnitDefaultMoveSpeed(this.h);}
	method operator DefaultTurnSpeed ()->real {return GetUnitDefaultTurnSpeed(this.h);}
	method operator AcquireRange ()->real {return GetUnitAcquireRange(this.h);}
	method operator AcquireRange= (real acquireRange) {SetUnitAcquireRange(this.h, acquireRange);}
	method operator DefaultAcquireRange ()->real {return GetUnitDefaultAcquireRange(this.h);}
	method operator DefaultFlyHeight ()->real {return GetUnitDefaultFlyHeight(this.h);}
	method operator Scale= (Vector3 scale) {SetUnitScale(this.h, scale.X, scale.Y, scale.Z);}

	// About Position
	method IsInRange (Point pos, real radius)->boolean {return IsUnitInRangeXY(this.h, pos.X, pos.Y, radius);}
	method BindPoint ()->Point {
		this.Point.Clamp();
		SetUnitX(this.h, this.Point.X);
		SetUnitY(this.h, this.Point.Y);
		return this.Point;
	}

	// About Player
	method ShareVision (GamePlayer plr, boolean shareVision) {UnitShareVision(this.h, Player(plr), shareVision);}
	method IsSelected (GamePlayer plr)->boolean {return IsUnitSelected(this.h, Player(plr));}

	// About Damage
	method DamageTarget (IWidget target, real damage, string damageType)->boolean {
		return UnitDamageTarget(this.h, Game.LoadWidget(target), damage, damageType== "Attack",
			false, ATTACK_TYPE_MELEE, Unit.getDamageType(damageType), WEAPON_TYPE_WHOKNOWS);
	}
	private static method getDamageType (string damageType)->damagetype {
		if (damageType== "Attack")
			return DAMAGE_TYPE_NORMAL;
		else if (damageType== "Magic")
			return DAMAGE_TYPE_MAGIC;
		return DAMAGE_TYPE_UNIVERSAL;
	}

	// About Life
	method Revive (Point pos) {
		if (IsHeroUnitId(this.TypeId))
			ReviveHero(this.h, pos.X, pos.Y, false);
	}
	method Kill () {KillUnit(this.h);}
	method SetExploded (boolean flag) {SetUnitExploded(this.h, flag);}
	method ApplyTimedLife (integer buffId, real lifespan) {UnitApplyTimedLife(this.h, buffId, lifespan);}
	method PauseTimedLife (boolean flag) {UnitPauseTimedLife(this.h, flag);}

	// About Ability
	method ResetCooldown () {UnitResetCooldown(this.h);}
	method MakeSkillPermanent (integer abid, boolean p)->boolean {return UnitMakeAbilityPermanent(this.h, p, abid);}
	method GetSkillLevel (integer abid)->integer {return GetUnitAbilityLevel(this.h, abid);}
	method SetSkillLevel (integer abid, integer level)->integer {
		unit h= this.h;
		integer originalLevel= GetUnitAbilityLevel(h, abid);
		if (level> 0) {
			if (originalLevel== 0)
				UnitAddAbility(h, abid);
			SetUnitAbilityLevel(h, abid, level);
		} else
			UnitRemoveAbility(h, abid);
		h= null;
		return originalLevel;
	}

	// About Item
	method AddItem (Item itm)->boolean {return UnitAddItem(this.h, itm.Handle);}
	method RemoveItem (Item itm) {UnitRemoveItem(this.h, itm.Handle);}
	method HasItem (Item itm)->boolean {return UnitHasItem(this.h, itm.Handle);}
	method GetItemInSlot (integer slot)->Item {return GetHandleId(UnitItemInSlot(this.h, slot));}

	// About Order
	method operator CurrentOrder ()->integer {return GetUnitCurrentOrder(this.h);}
	method OrderImmediate (integer orderId)->boolean {
		return IssueImmediateOrderById(this.h, orderId);
	}
	method OrderPoint (integer orderId, Point pos)->boolean {
		return IssuePointOrderById(this.h, orderId, pos.X, pos.Y);
	}
	method OrderTarget (integer orderId, IWidget target)->boolean {
		return IssueTargetOrderById(this.h, orderId, Game.LoadWidget(target));}
	method OrderBuild (integer unitId, Point pos)->boolean {
		return IssueBuildOrderById(this.h, unitId, pos.X, pos.Y);
	}

    // About Anime
    method BindAnime (string anime, boolean flag) {AddUnitAnimationProperties(this.h, anime, flag);}
	method SetAnime (string anime) {SetUnitAnimation(this.h, anime);}
	method QueueAnime (string anime) {QueueUnitAnimation(this.h, anime);}
	method ResetAnime () {ResetUnitAnimation(this.h);}
	method ResetLookAt () {ResetUnitLookAt(this.h);}
	// the @para bone can be either "head" or "chest"
	method LookAt (string bone, Unit target, Vector3 offset) {
		SetUnitLookAt(this.h, "bone_"+ bone, target.Handle, offset.X, offset.Y, offset.Z);
	}

	private static method onInit () {
		group g= CreateGroup();
        GroupEnumUnitsInRect(g, Region.WorldRect, Condition(function ()->boolean {
	    	unit u= GetFilterUnit();
	        Group.WorldGroup.Add(Unit.bind(u));
	        TriggerRegisterUnitEvent(Event.Damage.Handle, u, EVENT_UNIT_DAMAGED);
	        u= null;
	        return false;
        }));
		Event.EnterRegion.Add(function (integer i) {
			if (Event.Region== Region.WorldRegion) {
				Group.WorldGroup.Add(Unit.bind(GetEnteringUnit()));
			}
		});
		Event.LeaveRegion.Add(function (Unit u) {
			if (Event.Region== Region.WorldRegion) {
				Group.WorldGroup.Remove(u);
				Game.FlushInt(u.HashCode);
				u.h= null;
				u.Point.destroy();
			}
		});
        DestroyGroup(g);
        g= null;
	}
 }
