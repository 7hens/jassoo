public struct Camera {
	static method operator X ()->real {return GetCameraEyePositionX();}
	static method operator Y ()->real {return GetCameraEyePositionX();}
	static method operator Z ()->real {return GetCameraEyePositionX();}

	static method Reset (real duration) {ResetToGameCamera(duration);}
	static method MoveTo (Vector3 pos, real duration) {
		PanCameraToTimedWithZ(pos.X, pos.Y, pos.Z, duration);
	}
	static method GetPos ()->Vector3 {
		return Vector3.create().Reset(GetCameraEyePositionX(), GetCameraEyePositionY(), GetCameraEyePositionZ());
	}
	static method SetBounds (Point min, Point max)  {
		SetCameraBounds(min.X, min.Y, min.X, max.Y, max.X, max.Y, max.X, min.Y);
	}
	static method Rotate (Point center, real radianToSweep, real duration) {
		SetCameraRotateMode(center.X, center.Y, radianToSweep, duration);
	}
	static method TargetController (Unit u, Point offset, boolean facing) {
		SetCameraTargetController(u.Handle, offset.X, offset.Y, facing);
	}
}
