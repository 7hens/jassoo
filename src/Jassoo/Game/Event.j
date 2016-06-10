private {
	constant integer event_MaxCount = 59;
}
public struct Event [event_MaxCount] {
	static thistype 
		Start= 0, Chat= 1,
		DownUp= 2, DownDown= 3, LeftUp= 4, LeftDown= 5,
		RightUp= 6, RightDown= 7, UpUp= 8, UpDown= 9,
		Esc= 10, Leave= 11, Defeat= 12, Victory= 13,
		StateLimit= 14, AllianceChanged= 15,
		Select= 16, Deselect= 17, Detect= 18, Rescue= 19,
		Summon= 20,  Attack= 21, Load= 22, Kill= 23, Decay= 24,
		Level= 25, Skill= 26, Order= 27, PointOrder= 28, TargetOrder= 29,
		SpellChannel= 30, SpellCast= 31, SpellEffect= 32, SpellFinish= 33, SpellEnd= 34,
		Revivable= 35, ReviveStart= 36, ReviveFinish= 37, ReviveCancel= 38,
		TrainStart= 39, TrainFinish= 40, TrainCancel= 41,
		UpgradeStart= 42, UpgradeFinish= 43, UpgradeCancel= 44,
		ResearchStart= 45, ResearchFinish= 46, ResearchCancel= 47,
		ConstructStart= 48, ConstructFinish= 49, ConstructCancel= 50,
		Sell= 51, Use= 52, Pick= 53, Drop= 54, Pawn= 55, Damage= 56,
		EnterRegion= 57, LeaveRegion= 58;

    private Stack Actions;
    private trigger h;

	method operator Handle ()->trigger { return this.h; }
    method operator HandleId ()->integer { return GetHandleId(this.h); }
	method operator Active ()->boolean { return IsTriggerEnabled(this.h); }
	method operator Active= (boolean active) {
        if (active)  EnableTrigger(this.h);
        else DisableTrigger(this.h);
    }

    static method operator Current ()->thistype { return Utils.Get(GetTriggeringTrigger()); }
    static method operator Unit ()->Unit { return Utils.Get(GetTriggerUnit()); }
    static method operator Player ()->GamePlayer { return GetPlayerId(GetTriggerPlayer()); }
	static method operator ChatString ()->string { return GetEventPlayerChatString(); }
	static method operator SpellSkill ()->integer { return GetSpellAbilityId(); }
	static method operator Region ()->Region { return Utils.Get(GetTriggeringRegion()); }

	static method operator Rescuer ()->Unit { return Utils.Get(GetRescuer()); }
	static method operator Summoner ()->Unit { return Utils.Get(GetSummoningUnit()); }
	static method operator Attacker ()->Unit { return Utils.Get(GetAttacker()); }
	static method operator TransportUnit ()->Unit { return Utils.Get(GetKillingUnit()); }
	static method operator Seller ()->Unit { return Utils.Get(GetSellingUnit()); }
	static method operator OrderTarget ()->Unit { return Utils.Get(GetOrderTarget()); }
	static method operator Reviver ()->Unit { return Utils.Get(GetRevivingUnit()); }
	static method operator Damager ()->Unit { return Utils.Get(GetEventDamageSource()); }
	static method operator DamageValue ()->real { return GetEventDamage(); }

    static method operator SpellTarget ()->IWidget {
        integer id = GetHandleId(GetSpellTargetDestructable());
        if (id != 0) return Utils.GetInteger(id);
        
        id = GetHandleId(GetSpellTargetItem());
        if (id!= 0) return Utils.GetInteger(id);
        
        return Utils.GetInteger(GetHandleId(GetSpellTargetUnit()));
    }
    static method operator SoldTarget ()->IWidget {
    	integer id= GetHandleId(GetSoldItem());
        if (id!= 0) return Utils.GetInteger(id);
        return Utils.GetInteger(GetHandleId(GetSoldUnit()));
    }

	//! textmacro Jassoo_Event_TriggerPosition takes event, position, coord
	static method operator $event$$coord$ ()->real {
		IWidget target= thistype.$event$Target;
		if (target!= 0) {
			return target.$coord$;
		}
		return Get$position$$coord$();
	}
	//! endtextmacro
	//! runtextmacro Jassoo_Event_TriggerPosition("Order", "OrderPoint", "X")
	//! runtextmacro Jassoo_Event_TriggerPosition("Order", "OrderPoint", "Y")
	//! runtextmacro Jassoo_Event_TriggerPosition("Spell", "SpellTarget", "X")
	//! runtextmacro Jassoo_Event_TriggerPosition("Spell", "SpellTarget"", "Y")

	method AddAction (Action action) {
        EnableTrigger(this.h);
        if (!this.Actions.Contains(action)) {
            this.Actions.Add(action);
        }
	}
    
    private method initialize () {
        this.h = CreateTrigger();
        this.Actions = Stack.create();
        Utils.PutTrigger(GetHandleId(this.h), this.h);
        Utils.PutInteger(GetHandleId(this.h), this);
        DisableTrigger(this.h);
        
        TriggerAddCondition(this.h, Condition(function ()->boolean {
            thistype this = thistype.Current;
            IEnumerator e = this.Actions.GetEnumerator();
            while (e.MoveNext()) {
                Action(e.Current).evaluate(thistype.Unit);
            }
            return false;
        }));
    }
    

    private static method onInit () {
        thistype i = 0;
        for (0 <= i < event_MaxCount) {
            i.initialize();
        }
        thistype.registerEvent();
        // Enable the struct Group and the trigger Damage
        EnableTrigger(thistype.EnterRegion.h);
        EnableTrigger(thistype.LeaveRegion.h);
    }
    
    private static method registerEvent () {
        integer i = 0;
        player plr = null;
        TriggerRegisterTimerEvent(thistype.Start.h, 0.0, false);
        for (0 <= i < 16) {
            plr= Player(i);
            TriggerRegisterPlayerChatEvent(thistype.Chat.h, plr, "", false);

			//! textmacro Jassoo_Trigger_PlayerEvent takes eventType, event
    		TriggerRegisterPlayerEvent(thistype.$eventType$.h, plr, EVENT_PLAYER_$event$);
			//! endtextmacro
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("DownDown", "ARROW_DOWN_DOWN")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("DownUp", "ARROW_DOWN_UP")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("LeftDown", "ARROW_LEFT_DOWN")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("LeftUp", "ARROW_LEFT_UP")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("RightDown", "ARROW_RIGHT_DOWN")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("RightUp", "ARROW_RIGHT_UP")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("UpDown", "ARROW_UP_DOWN")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("UpUp", "ARROW_UP_UP")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("Esc", "END_CINEMATIC")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("Leave", "LEAVE")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("Defeat", "DEFEAT")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("Victory", "VICTORY")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("StateLimit", "STATE_LIMIT")
			//! runtextmacro Jassoo_Trigger_PlayerEvent ("AllianceChanged", "ALLIANCE_CHANGED")

			//! textmacro Jassoo_Trigger_PlayerUnitEvent takes eventType, event
	    	TriggerRegisterPlayerUnitEvent(thistype.$eventType$.h,  plr, EVENT_PLAYER_$event$, Game.True);
			//! endtextmacro
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Select", "UNIT_SELECTED")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Deselect", "UNIT_DESELECTED")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Detect", "UNIT_DETECTED")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Rescue", "UNIT_RESCUED")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Summon", "UNIT_SUMMON")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Load", "UNIT_LOADED")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Attack", "UNIT_ATTACKED")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Kill", "UNIT_DEATH")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Decay", "UNIT_DECAY")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Revivable", "HERO_REVIVABLE")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Level", "HERO_LEVEL")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Skill", "HERO_SKILL")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Order", "UNIT_ISSUED_ORDER")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("PointOrder", "UNIT_ISSUED_POINT_ORDER")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("TargetOrder", "UNIT_ISSUED_TARGET_ORDER")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("SpellChannel", "UNIT_SPELL_CHANNEL")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("SpellCast", "UNIT_SPELL_CAST")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("SpellEffect", "UNIT_SPELL_EFFECT")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("SpellFinish", "UNIT_SPELL_FINISH")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("SpellEnd", "UNIT_SPELL_ENDCAST")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("ReviveStart", "HERO_REVIVE_START")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("ReviveFinish", "HERO_REVIVE_FINISH")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("ReviveCancel", "HERO_REVIVE_CANCEL")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("TrainStart", "UNIT_TRAIN_START")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("TrainFinish", "UNIT_TRAIN_FINISH")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("TrainCancel", "UNIT_TRAIN_CANCEL")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("UpgradeStart", "UNIT_UPGRADE_START")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("UpgradeFinish", "UNIT_UPGRADE_FINISH")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("UpgradeCancel", "UNIT_UPGRADE_CANCEL")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("ResearchStart", "UNIT_RESEARCH_START")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("ResearchFinish", "UNIT_RESEARCH_FINISH")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("ResearchCancel", "UNIT_RESEARCH_CANCEL")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("ConstructStart", "UNIT_CONSTRUCT_START")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("ConstructFinish", "UNIT_CONSTRUCT_FINISH")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("ConstructCancel", "UNIT_CONSTRUCT_CANCEL")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Sell", "UNIT_SELL")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Sell", "UNIT_SELL_ITEM")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Use", "UNIT_USE_ITEM")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Pick", "UNIT_PICKUP_ITEM")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Drop", "UNIT_DROP_ITEM")
			//! runtextmacro Jassoo_Trigger_PlayerUnitEvent ("Pawn", "UNIT_PAWN_ITEM")
        }
        plr = null;
    }
}
