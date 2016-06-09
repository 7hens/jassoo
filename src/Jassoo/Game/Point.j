public struct Point {
	static Point Zero, UnitX, UnitY, UnitScale, NegativeUnitX, NegativeUnitY, Temp, Min, Max, Center;
	private static location loc= null;
	private delegate Vector2 Vector2;

	static method create ()->Point {
		Point this= Vector2.create();
		this.Vector2= this;
		return this;
	}
    
	method destroy () {this.Vector2.destroy();}
    
	method operator TerrainZ ()->real {return Point.GetTerrainZ(this.X, this.Y);}
	method operator TerrainType ()->integer {return GetTerrainType(this.X, this.Y);}

	method Clamp ()->Point {
		this.X= Math.Clamp(this.X, Point.Min.X, Point.Max.X);
		this.Y= Math.Clamp(this.Y, Point.Min.Y, Point.Max.Y);
		return this;
	}

	static method GetTerrainZ (real x, real y)->real {
		MoveLocation(Point.loc, x, y);
		return GetLocationZ(Point.loc);
	}
    
	method GetTerrainVector ()->Vector3 {
		return Vector3.create().Reset(this.X, this.Y, this.TerrainZ);
	}
    
	method IsPathingType (string pathingType)->boolean {
		return (
			pathingType== "DeepWater" &&
			!IsTerrainPathable(this.X, this.Y, PATHING_TYPE_FLOATABILITY) &&
			IsTerrainPathable(this.X, this.Y, PATHING_TYPE_WALKABILITY)
		) || (
			pathingType== "ShallowWater" &&
			!IsTerrainPathable(this.X, this.Y, PATHING_TYPE_FLOATABILITY) &&
			!IsTerrainPathable(this.X, this.Y, PATHING_TYPE_WALKABILITY) &&
			IsTerrainPathable(this.X, this.Y, PATHING_TYPE_BUILDABILITY)
		) || (
			pathingType== "Land" &&
			IsTerrainPathable(this.X ,this.Y, PATHING_TYPE_FLOATABILITY)
		) || (
			pathingType== "Platform" &&
			!IsTerrainPathable(this.X, this.Y, PATHING_TYPE_FLOATABILITY) &&
			!IsTerrainPathable(this.X, this.Y, PATHING_TYPE_WALKABILITY) &&
			!IsTerrainPathable(this.X, this.Y, PATHING_TYPE_BUILDABILITY)
		);
	}

	method AddEffect (string path, real duration)->Timer {
		return Game.TimedEffect(AddSpecialEffect(path ,this.X ,this.Y), duration);
	}

	private static method onInit () {
		real minX= GetCameraBoundMinX()- GetCameraMargin(CAMERA_MARGIN_LEFT);
		real maxX= GetCameraBoundMaxX()+ GetCameraMargin(CAMERA_MARGIN_RIGHT);
		real minY= GetCameraBoundMinY()- GetCameraMargin(CAMERA_MARGIN_BOTTOM);
		real maxY= GetCameraBoundMaxY()+ GetCameraMargin(CAMERA_MARGIN_TOP);
		Point.loc= Location(0.0, 0.0);
		Point.Min= Point.create().Reset(minX, minY);
		Point.Max= Point.create().Reset(maxX, maxY);
		Point.Center= Point.create().Reset((maxX+ minX)/ 2, (maxY+ minY)/ 2);
		Point.Zero= Vector2.Zero;
		Point.UnitX= Vector2.UnitX;
		Point.UnitY= Vector2.UnitY;
		Point.UnitScale= Vector2.UnitScale;
		Point.NegativeUnitX= Vector2.NegativeUnitX;
		Point.NegativeUnitY= Vector2.NegativeUnitY;
		Point.Temp= Vector2.Temp;
	}
}
