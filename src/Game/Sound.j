public struct Sound {
	private sound h;
	static method create (string path, boolean looping, boolean is3D, boolean stopWhenOut,
		integer fadeInV, integer fadeOutV, string eaxSetting)->thistype {
		Sound this= Sound.allocate();
		this.h= CreateSound(path, looping, is3D, stopWhenOut, fadeInV, fadeOutV, eaxSetting);
		Game.PutInteger(this.HandleId, this);
		KillSoundWhenDone(this.h);
		return this;
	}
	method destroy () {
		Game.FlushInteger(this.HandleId);
		StopSound(this.h, true, false);
		this.h= null;
		this.deallocate();
	}

	method operator Handle ()->sound {return this.h;}
	method operator HandleId ()->integer {return GetHandleId(this.h);}
	method operator Duration ()->integer {return GetSoundDuration(this.h);}
	method operator Duration= (integer duration) {SetSoundDuration(this.h, duration);}
	method SetVolumn (integer volume) {SetSoundVolume(this.h, volume);}
	method SetVelocity (Vector3 value) {SetSoundVelocity(this.h, value.X, value.Y, value.Z);}
	method SetPosition (Vector3 pos) {SetSoundPosition(this.h, pos.X, pos.Y, pos.Z);}
	method Play () {StartSound(this.h);}
	method Stop (boolean fadeOut) {StopSound(this.h, false, fadeOut);}
	method AttachToUnit (Unit target) {AttachSoundToUnit(this.h, target.Handle);}
}
