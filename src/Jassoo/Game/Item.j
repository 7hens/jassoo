public struct Item extends IWidget  {
	module widgetModule;
	static constant integer DummyId= 'Idum';
	private delegate Point Point;
	private item h;

	static method create (integer typeId, Point pos)->Item {
		Item this = pos.GetCopy();
		this.Point = Point;
		this.h = CreateItem(typeId, pos.X, pos.Y);
		Utils.PutInteger(this.HandleId, this);
		return this;
	}
	method destroy () {
		Utils.FlushInteger(this.HandleId);
		RemoveItem(this.h);
		this.h= null;
		this.Point.destroy();
	}

    static method Get (item h)->thistype {
		integer id = GetHandleId(h);
		thistype this;
		if (Utils.ExistsInteger(id)) {
			return Utils.GetInteger(id);
        }
		this = Point.create();
		this.Point = this;
		this.h = h;
		Utils.PutInteger(id, this);
		return this;
    }

	method operator Handle ()->item { return this.h; }
	method operator TypeId ()->integer { return GetItemTypeId(this.h); }
	method operator Invulnerable ()->boolean { return IsItemInvulnerable(this.h); }
	method operator Invulnerable= (boolean value) { SetItemInvulnerable(this.h, value); }
	method operator UserData ()->integer { return GetItemUserData(this.h); }
	method operator UserData= (integer data) { SetItemUserData(this.h, data); }
	method operator Level ()->integer { return GetItemLevel(this.h); }
	method operator Name ()->string { return GetItemName(this.h); }
	method operator X= (real x) { SetItemPosition(this.h, x, this.Y); }
	method operator Y= (real y) { SetItemPosition(this.h, this.X, y); }
	method operator Player ()->GamePlayer { return GamePlayer[GetPlayerId(GetItemPlayer(this.h))]; }
	method operator Player= (GamePlayer plr) { SetItemPlayer(this.h, Player(plr), true); }
	method operator Pawnable ()->boolean { return IsItemPawnable(this.h); }
	method operator Pawnable= (boolean pawnable) { SetItemPawnable(this.h, pawnable); }
	method operator Droppable= (boolean droppable) { SetItemDroppable(this.h, droppable); }
	method operator Charges ()->integer { return GetItemCharges(this.h); }
	method operator Charges= (integer charges) { SetItemCharges(this.h, charges); }
	method operator PowerUp ()->boolean { return IsItemPowerup(this.h); }
	method operator Sellable ()->boolean { return IsItemSellable(this.h); }
	method operator Owned ()->boolean { return IsItemOwned(this.h); }
	method operator Visible ()->boolean { return IsItemVisible(this.h); }
	method operator Visible= (boolean value) { SetItemVisible(this.h, value); }

	static method IsIdPowerUp (integer typeId)->boolean { return IsItemIdPowerup(typeId); }
	static method IsIdPawnable (integer typeId)->boolean { return IsItemIdPawnable(typeId); }
	static method IsIdSellable (integer typeId)->boolean { return IsItemIdSellable(typeId); }

	// About Position
	method BindPoint ()->Point {
		this.Point.Clamp();
		SetItemPosition(this.h, this.Point.X, this.Point.Y);
		return this.Point;
	}
}
