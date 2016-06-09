public struct Destruct extends IWidget {
    module widgetModule;
	private delegate Point Point;
	private destructable h;

	static method create (integer typeId, Vector3 pos, real face, real scale, integer variation)->Destruct {
		Destruct this= pos.GetCopy();
		this.Point= this;
        this.h= CreateDestructableZ(typeId, pos.X, pos.Y, pos.Z, face, scale, variation);
        Utils.PutInteger(this.HandleId, this);
        return this;
    }
    
    method destroy () {
	    Utils.FlushInteger(this.HandleId);
        RemoveDestructable(this.h);
        this.h= null;
        this.Point.destroy();
    }
    
    static method Get (destructable h)->thistype {
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

	method operator Handle ()->destructable { return this.h; }
    method operator TypeId ()->integer { return GetDestructableTypeId(this.h); }
    method operator Visible= (boolean value) { ShowDestructable(this.h, value); }
    method operator Invulnerable ()->boolean { return IsDestructableInvulnerable(this.h); }
    method operator Invulnerable= (boolean value) { SetDestructableInvulnerable(this.h, value); }
    method operator MaxHP ()->real { return GetDestructableMaxLife(this.h); }
    method operator MaxHP= (real value) { SetDestructableMaxLife(this.h, value); }
    method operator Name ()->string { return GetDestructableName(this.h); }
	method operator OccluderHeight ()->real { return GetDestructableOccluderHeight(this.h); }
	method operator OccluderHeight= (real occluderHeight) { SetDestructableOccluderHeight(this.h, occluderHeight); }
    method Display (boolean flag) { ShowDestructable(this.h, flag); }

    method RestoreLife (real value) { DestructableRestoreLife(this.h, value, true); }
    method Kill () { KillDestructable(this.h); }

	method SetAnimationSpeed (real speedFactor) {}
}
