public struct Image {
	private image h;
	static method create (string path, Vector3 pos, Vector3 size, integer imageType)->Image {
		Image this= Image.allocate();
		this.h= CreateImage(path, size.X, size.Y, size.Z, pos.X, pos.Y, pos.Z, 0.0, 0.0, 0.0, imageType);
		SetImageRenderAlways(this.h, true );
		Game.PutInteger(this.HandleId, this);
		return this;
	}
	method destroy () {
		Game.FlushInteger(this.HandleId);
		DestroyImage(this.h);
		this.h= null;
		this.deallocate();
	}

	method operator Handle ()->image {return this.h;}
	method operator HandleId ()->integer {return GetHandleId(this.h);}
	method Show (boolean flag) {ShowImage(this.h, flag);}
	method SetColor (Argb color) {SetImageColor(this.h, color.R, color.G, color.B, color.A);}
	method SetType (integer imageType) {SetImageType(this.h, imageType);}
	method SetPosistion (Vector3 pos) {SetImagePosition(this.h, pos.X, pos.Y, pos.Z);}
	method SetAboveWater (boolean flag, boolean useWaterAlpha) {SetImageAboveWater(this.h, flag, useWaterAlpha);}
}
