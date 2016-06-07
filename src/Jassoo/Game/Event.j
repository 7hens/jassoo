private {
	constant integer event_MaxCount= 59;
}
public struct Event [event_MaxCount] {
	static Event 
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

    private delegate List Actions;
    private trigger h;
    private boolean registered;

	method operator Handle ()->trigger {return this.h;}
	method operator Active ()->boolean {return IsTriggerEnabled(this.h);}
	method operator Active= (boolean active) {
        if (active)  EnableTrigger(this.h);
        else DisableTrigger(this.h);
    }

    static method operator Player ()->GamePlayer {return GetPlayerId(GetTriggerPlayer());}
	static method operator ChatString ()->string {return GetEventPlayerChatString();}
	static method operator SpellSkill ()->integer {return GetSpellAbilityId();}
	static method operator Region ()->Region {return Game.GetInteger(GetHandleId(GetTriggeringRegion()));}

	static method operator Rescuer ()->Unit {return Game.GetInteger(GetHandleId(GetRescuer()));}
	static method operator Summoner ()->Unit {return Game.GetInteger(GetHandleId(GetSummoningUnit()));}
	static method operator Attacker ()->Unit {return Game.GetInteger(GetHandleId(GetAttacker()));}
	static method operator TransportUnit ()->Unit {return Game.GetInteger(GetHandleId(GetKillingUnit()));}
	static method operator Seller ()->Unit {return Game.GetInteger(GetHandleId(GetSellingUnit()));}
	static method operator OrderTarget ()->Unit {return Game.GetInteger(GetHandleId(GetOrderTarget()));}
	static method operator Reviver ()->Unit {return Game.GetInteger(GetHandleId(GetRevivingUnit()));}
	static method operator Damager ()->Unit {return Game.GetInteger(GetHandleId(GetEventDamageSource()));}
	static method operator DamageValue ()->real {return GetEventDamage();}

    static method operator SpellTarget ()->IWidget {
        integer id= GetHandleId(GetSpellTargetDestructable());
        if (id!= 0) return Game.GetInteger(id);
        id= GetHandleId(GetSpellTargetItem());
        if (id!= 0) return Game.GetInteger(id);
        return Game.GetInteger(GetHandleId(GetSpellTargetUnit()));
    }
    static method operator SoldTarget ()->IWidget {
    	integer id= GetHandleId(GetSoldItem());
        if (id!= 0) return Game.GetInteger(id);
        return Game.GetInteger(GetHandleId(GetSoldUnit()));
    }

	//! textmacro Wrapper_Event_TriggerPosition takes event, position, coord
	static method operator $event$$coord$ ()->real {
		IWidget target= Event.$event$Target;
		if (target!= 0) {
			return target.$coord$;
		}
		return Get$position$$coord$();
	}
	//! endtextmacro
	//! runtextmacro Wrapper_Event_TriggerPosition("Order", "OrderPoint", "X")
	//! runtextmacro Wrapper_Event_TriggerPosition("Order", "OrderPoint", "Y")
	//! runtextmacro Wrapper_Event_TriggerPosition("Spell", "SpellTarget", "X")
	//! runtextmacro Wrapper_Event_TriggerPosition("Spell", "SpellTarget"", "Y")

	method Add (Action action) {
		if (!this.registered) {
			EnableTrigger(this.h);
			this.registered= true;
		}
		this.Actions.Add(action);
	}

    private static method onInit () {
        Event this= 0;
        integer i= 0;
        player plr= null;
        for (i= 0; i< event_MaxCount; i+= 1) {
            this= i;
            this.h= CreateTrigger();
            this.Actions= List.create();
            this.registered= false;
            Game.PutTrigger(GetHandleId(this.h), this.h);
            Game.PutInteger(GetHandleId(this.h), this);
            DisableTrigger(this.h);
            TriggerAddCondition(this.h, Condition(function ()->boolean {
				Event this= Game.GetInteger(GetHandleId(GetTriggeringTrigger()));
				this.Actions.Evaluate(Game.GetInteger(GetHandleId(GetTriggerUnit())));
				return false;
            }));
        }
        TriggerRegisterTimerEvent(Event.Start.h, 0.0, false);
        for (i= 0; i< 16; i+= 1) {
            plr= Player(i);
            TriggerRegisterPlayerChatEvent(Event.Chat.h, plr, "", false);

			//! textmacro Wrapper_Trigger_PlayerEvent takes eventType, event
    		TriggerRegisterPlayerEvent(Event.$eventType$.h, plr, EVENT_PLAYER_$event$);
			//! endtextmacro
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("DownDown", "ARROW_DOWN_DOWN")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("DownUp", "ARROW_DOWN_UP")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("LeftDown", "ARROW_LEFT_DOWN")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("LeftUp", "ARROW_LEFT_UP")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("RightDown", "ARROW_RIGHT_DOWN")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("RightUp", "ARROW_RIGHT_UP")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("UpDown", "ARROW_UP_DOWN")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("UpUp", "ARROW_UP_UP")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("Esc", "END_CINEMATIC")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("Leave", "LEAVE")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("Defeat", "DEFEAT")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("Victory", "VICTORY")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("StateLimit", "STATE_LIMIT")
			//! runtextmacro Wrapper_Trigger_PlayerEvent ("AllianceChanged", "ALLIANCE_CHANGED")

			//! textmacro Wrapper_Trigger_PlayerUnitEvent takes eventType, event
	    	TriggerRegisterPlayerUnitEvent(Event.$eventType$.h,  plr, EVENT_PLAYER_$event$, Game.True);
			//! endtextmacro
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Select", "UNIT_SELECTED")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Deselect", "UNIT_DESELECTED")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Detect", "UNIT_DETECTED")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Rescue", "UNIT_RESCUED")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Summon", "UNIT_SUMMON")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Load", "UNIT_LOADED")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Attack", "UNIT_ATTACKED")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Kill", "UNIT_DEATH")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Decay", "UNIT_DECAY")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Revivable", "HERO_REVIVABLE")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Level", "HERO_LEVEL")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Skill", "HERO_SKILL")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Order", "UNIT_ISSUED_ORDER")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("PointOrder", "UNIT_ISSUED_POINT_ORDER")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("TargetOrder", "UNIT_ISSUED_TARGET_ORDER")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("SpellChannel", "UNIT_SPELL_CHANNEL")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("SpellCast", "UNIT_SPELL_CAST")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("SpellEffect", "UNIT_SPELL_EFFECT")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("SpellFinish", "UNIT_SPELL_FINISH")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("SpellEnd", "UNIT_SPELL_ENDCAST")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("ReviveStart", "HERO_REVIVE_START")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("ReviveFinish", "HERO_REVIVE_FINISH")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("ReviveCancel", "HERO_REVIVE_CANCEL")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("TrainStart", "UNIT_TRAIN_START")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("TrainFinish", "UNIT_TRAIN_FINISH")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("TrainCancel", "UNIT_TRAIN_CANCEL")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("UpgradeStart", "UNIT_UPGRADE_START")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("UpgradeFinish", "UNIT_UPGRADE_FINISH")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("UpgradeCancel", "UNIT_UPGRADE_CANCEL")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("ResearchStart", "UNIT_RESEARCH_START")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("ResearchFinish", "UNIT_RESEARCH_FINISH")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("ResearchCancel", "UNIT_RESEARCH_CANCEL")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("ConstructStart", "UNIT_CONSTRUCT_START")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("ConstructFinish", "UNIT_CONSTRUCT_FINISH")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("ConstructCancel", "UNIT_CONSTRUCT_CANCEL")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Sell", "UNIT_SELL")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Sell", "UNIT_SELL_ITEM")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Use", "UNIT_USE_ITEM")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Pick", "UNIT_PICKUP_ITEM")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Drop", "UNIT_DROP_ITEM")
			//! runtextmacro Wrapper_Trigger_PlayerUnitEvent ("Pawn", "UNIT_PAWN_ITEM")
        }
        // Enable the struct Group and the trigger Damage
        EnableTrigger(Event.EnterRegion.h);
        Event.EnterRegion.registered= true;
        EnableTrigger(Event.LeaveRegion.h);
        Event.LeaveRegion.registered= true;
        plr= null;
    }
}
