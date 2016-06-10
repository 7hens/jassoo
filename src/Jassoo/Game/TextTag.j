public struct TextTag {
	private texttag h;
    
	static method create (string text, Vector3 pos)->TextTag {
		TextTag this= TextTag.allocate();
		this.h= CreateTextTag();
		Utils.PutInteger(this.HandleId, this);
		SetTextTagPermanent(this.h, true);
		SetTextTagText(this.h, text, pos.Z);
		SetTextTagPos(this.h, pos.X, pos.Y, pos.Z);
		return this;
	}
    
	method destroy () {
		Utils.FlushInteger(this.HandleId);
		DestroyTextTag(this.h);
		this.h= null;
		this.deallocate();
	}
    
	method operator Handle ()->texttag { return this.h; }
	method operator HandleId ()->integer { return GetHandleId(this.h); }
	method Display (boolean flag) { SetTextTagVisibility(this.h, flag); }
	method SetColor (Argb color) { SetTextTagColor(this.h, color.R, color.G, color.B, color.A); }
	method SetPos (Vector3 pos) { SetTextTagPos(this.h, pos.X, pos.Y, pos.Z); }
	method SetVelocity (real xv, real yv) { SetTextTagVelocity(this.h, xv, yv); }
	method SetText (string text, Vector3 pos) {
		SetTextTagText(this.h, text, pos.Z);
		SetTextTagPos(this.h, pos.X, pos.Y, pos.Z);
	}
}
