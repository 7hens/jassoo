public struct Vector2 {
	static Vector2 Zero, UnitX, UnitY, UnitScale, NegativeUnitX, NegativeUnitY, Temp;
	real X= 0.0, Y= 0.0;

	method operator < (Vector2 that)->boolean {return this.X< that.X&& this.Y< that.Y;}
	method operator SquaredLength ()->real {return this.X* this.X+ this.Y* this.Y;}
	method operator Length ()->real {return Math.Sqrt(this.X* this.X+ this.Y* this.Y);}
	method operator Length= (real value) {this.Scale(value* Math.InvSqrt(this.SquaredLength));}
	method operator Angle ()->real {return Atan2(this.Y, this.X);}
	method operator Angle= (real value) {
		real length= this.Length;
		this.X= length* Cos(value);
		this.Y= length* Sin(value);
	}

	method Equals (Vector2 that)->boolean {return Math.IsZero(this.X- that.X)&& Math.IsZero(this.Y- that.Y);}
	method IsZero ()->boolean {return Math.IsZero(this.X)&& Math.IsZero(this.Y);}
	method Reset(real x, real y)->Vector2 {this.X= x; this.Y= y; return this;}
	method ResetXY(real x, real y)->Vector2 {this.X= x; this.Y= y; return this;}
	method Copy (Vector2 that)->Vector2 {return this.Reset(that.X, that.Y);}
	method GetCopy ()->Vector2 {return Vector2.create().Reset(this.X, this.Y);}
	method Normalize ()->real {
		real length= this.Length;
        // Will also work for zero-sized vectors, but will change nothing
		if (length!= 0) this.Scale(1/ length);
		return length;
	}
	method GetNormalizedCopy ()->Vector2 {Vector2 n= this.GetCopy(); n.Normalize(); return n;}
	// Generates a vector perpendicular to this vector (eg an 'up' vector).
	method GetNormal ()->Vector2 {return Vector2.create().Reset(-this.Y, this.X);}
	method GetRandomDeviant (real angle)->Vector2 {
		real cosa, sina;
		angle*= Math.Random;
		cosa= Cos(angle); sina= Sin(angle);
		return Vector2.create().Reset(this.X* cosa- this.Y* sina, this.X* sina+ this.Y* cosa);
	}

	method Swap (Vector2 that) {
		real temp;
		temp= this.X; this.X= that.X; that.X= temp;
		temp= this.Y; this.Y= that.Y; that.Y= temp;
	}
	method GetSquaredDistanceWith (Vector2 that)->real {
		return (this.X- that.X)* (this.X- that.X)+ (this.Y- that.Y)* (this.Y- that.Y);
	}
	method GetDistanceWith (Vector2 that)->real {
		return Math.Sqrt((this.X- that.X)* (this.X- that.X)+ (this.Y- that.Y)* (this.Y- that.Y));
	}
	method GetAngleWith (Vector2 that)->real {
		real mul= this.Length* that.Length;
		if (!(mul!= 0)) {
			debug Print("[Vector2.GetAngleWith] The length of at least one of the vectors is 0.0!");
			return 0.0;
		}
		return Acos((this.X* that.X+ this.Y* that.Y)/ mul);
	}
	method GetMiddle (Vector2 that)->Vector2 {
		return Vector2.create().Reset((this.X+ that.X)/2, (this.Y+ that.Y)/2);
	}
	method MakeFloor (Vector2 that)->Vector2 {
		if (that.X< this.X) this.X= that.X;
		if (that.Y< this.Y) this.Y= that.Y;
		return this;
	}
	method MakeCeil (Vector2 that)->Vector2 {
		if (that.X> this.X) this.X= that.X;
		if (that.Y> this.Y) this.Y= that.Y;
		return this;
	}

	method Add (Vector2 that)->Vector2 {this.X+= that.X; this.Y+= that.Y; return this;}
	method Subtract (Vector2 that)->Vector2 {this.X-= that.X; this.Y-= that.Y; return this;}
	method Scale (real factor)->Vector2 {this.X*= factor; this.Y*= factor; return this;}
	method DotProduct (Vector2 that)->real {
		return this.X* that.X+ this.Y* that.Y;
	}
	method CrossProduct (Vector2 that)->real {
		return this.X* that.Y- this.Y* that.X;
	}
	method Project (Vector2 direction)->Vector2 {
		real len2 = direction.X* direction.X+ direction.Y* direction.Y;
		if (!(len2!= 0.0)) {
			debug Print("[Vector2.Project] The length of the direction vector is 0.0!");
			return 0;
		}
		len2 = (this.X* direction.X+ this.Y* direction.Y)/ len2;
		return this.Reset(direction.X* len2, direction.Y* len2);
	}
	//  Creates an interpolated vector between this vector && that vector.
	//      that @param: The that vector to interpolate with.
	//      k @param: Interpolation value between 0.0 (all the that vector) &&  1.0 (all this vector).
	//      @return: An interpolated vector. This vector is not modified.
	method Interpolate (Vector2 that, real k)->Vector2 {
		Vector2 result= Vector2.allocate();
		real d= 1.0- k;
		result.X= that.X* d+ this.X* k;
		result.Y= that.Y* d+ this.X* k;
		return result;
	}

	method IsBetween (Vector2 begin, Vector2 end)->boolean {
		if (begin.X!= end.X)
			return (begin.X<= this.X&& this.X<= end.X)|| (begin.X>= this.X&& this.X>= end.X);
		return (begin.Y<= this.Y&& this.Y<= end.Y)|| (begin.Y>= this.Y&& this.Y>= end.Y);
	}
	method IsInCircle (Vector2 circleOrigin, real circleRadius)->boolean {
		return circleRadius>= this.GetDistanceWith(circleOrigin);
	}

	method ToString ()->string {
		return "("+ Convert.Real2S(this.X, 6)+ ","+ Convert.Real2S(this.Y, 6)+ ")";
	}

	private static method onInit () {
		Vector2.Zero= Vector2.create().Reset(0, 0);
		Vector2.UnitX= Vector2.create().Reset(1, 0);
		Vector2.UnitY= Vector2.create().Reset(0, 1);
		Vector2.UnitScale= Vector2.create().Reset(1, 1);
		Vector2.NegativeUnitX= Vector2.create().Reset(-1, 0);
		Vector2.NegativeUnitY= Vector2.create().Reset(0, -1);
		Vector2.Temp= Vector2(0).Reset(0, 0);
	}
}
