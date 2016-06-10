public struct Point {
	static thistype Zero, UnitX, UnitY, UnitScale, NegativeUnitX, NegativeUnitY;
    static thistype Temp, Min, Max, Center;
	private static location loc= null;
	private delegate Vector2 Vector2;

	static method create ()->thistype {
		thistype this= Vector2.create();
		this.Vector2= this;
		return this;
	}
    
	method destroy () {this.Vector2.destroy();}
    
	method operator TerrainZ ()->real {return thistype.GetTerrainZ(this.X, this.Y);}
	method operator TerrainType ()->integer {return GetTerrainType(this.X, this.Y);}

	method Clamp ()->thistype {
		this.X= Math.Clamp(this.X, thistype.Min.X, thistype.Max.X);
		this.Y= Math.Clamp(this.Y, thistype.Min.Y, thistype.Max.Y);
		return this;
	}

	static method GetTerrainZ (real x, real y)->real {
		MoveLocation(thistype.loc, x, y);
		return GetLocationZ(thistype.loc);
	}
    
	method GetTerrainVector ()->Vector3 {
		return Vector3.create().Reset(this.X, this.Y, this.TerrainZ);
	}
    
	method IsPathingType (string pathingType)->boolean {
		return (
			pathingType== "DeepWater"
                && !IsTerrainPathable(this.X, this.Y, PATHING_TYPE_FLOATABILITY)
                && IsTerrainPathable(this.X, this.Y, PATHING_TYPE_WALKABILITY)
		) || (
			pathingType== "ShallowWater"
                && !IsTerrainPathable(this.X, this.Y, PATHING_TYPE_FLOATABILITY)
                && !IsTerrainPathable(this.X, this.Y, PATHING_TYPE_WALKABILITY)
                && IsTerrainPathable(this.X, this.Y, PATHING_TYPE_BUILDABILITY)
		) || (
			pathingType== "Land"
                && IsTerrainPathable(this.X ,this.Y, PATHING_TYPE_FLOATABILITY)
		) || (
			pathingType== "Platform"
                && !IsTerrainPathable(this.X, this.Y, PATHING_TYPE_FLOATABILITY)
                && !IsTerrainPathable(this.X, this.Y, PATHING_TYPE_WALKABILITY)
                && !IsTerrainPathable(this.X, this.Y, PATHING_TYPE_BUILDABILITY)
		);
	}

	method AddEffect (string path, real duration)->Timer {
		return Utils.TimedEffect(AddSpecialEffect(path ,this.X ,this.Y), duration);
	}

	private static method onInit () {
		real minX= GetCameraBoundMinX()- GetCameraMargin(CAMERA_MARGIN_LEFT);
		real maxX= GetCameraBoundMaxX()+ GetCameraMargin(CAMERA_MARGIN_RIGHT);
		real minY= GetCameraBoundMinY()- GetCameraMargin(CAMERA_MARGIN_BOTTOM);
		real maxY= GetCameraBoundMaxY()+ GetCameraMargin(CAMERA_MARGIN_TOP);
		thistype.loc= Location(0.0, 0.0);
		thistype.Min= thistype.create().Reset(minX, minY);
		thistype.Max= thistype.create().Reset(maxX, maxY);
		thistype.Center= thistype.create().Reset((maxX+ minX)/ 2, (maxY+ minY)/ 2);
		thistype.Zero= Vector2.Zero;
		thistype.UnitX= Vector2.UnitX;
		thistype.UnitY= Vector2.UnitY;
		thistype.UnitScale= Vector2.UnitScale;
		thistype.NegativeUnitX= Vector2.NegativeUnitX;
		thistype.NegativeUnitY= Vector2.NegativeUnitY;
		thistype.Temp= Vector2.Temp;
	}
}
