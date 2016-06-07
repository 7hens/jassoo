public struct Vector3 {
	static Vector3 Zero, UnitX, UnitY, UnitZ, UnitScale, NegativeUnitX, NegativeUnitY, NegativeUnitZ, Temp;
	private delegate Vector2 Vector2= 0;
	real Z= 0.0;

	static method create ()->Vector3 {
		Vector3 this= Vector2.create();
		this.Vector2= this;
		return this;
	}
	method destroy () {this.Vector2.destroy();}

	method operator < (Vector3 that)->boolean {return this.X< that.X&& this.Y< that.Y&& this.Z< that.Z;}
	method operator SquaredLength ()->real {return this.X* this.X+ this.Y* this.Y+ this.Z* this.Z;}
	method operator Length ()->real {return Math.Sqrt(this.X* this.X+ this.Y* this.Y+ this.Z* this.Z);}
	method operator Length= (real value) {this.Scale(value* Math.InvSqrt(this.SquaredLength));}
	method operator Azimuth ()->real {return this.Angle;}
	method operator Azimuth= (real value) {this.Angle= value;}
	method operator Pitching ()->real {return Atan2(this.Z, Math.Hypot(this.Y, this.X));}
	method operator Pitching= (real value) {
		real length= this.Length;
		real angle= this.Angle;
		this.X= length* Cos(value)* Cos(angle);
		this.Y= length* Cos(value)* Sin(angle);
		this.Z= length* Sin(value);
	}

	method Equals (Vector3 that)->boolean {
		return Math.IsZero(this.X- that.X)&& Math.IsZero(this.Y- that.Y)&& Math.IsZero(this.Z- that.Z);
	}
	method IsZero ()->boolean {return Math.IsZero(this.X)&& Math.IsZero(this.Y)&& Math.IsZero(this.Z);}
	method Reset(real x, real y, real z)->Vector3 {this.X= x; this.Y= y; this.Z= z; return this;}
	method Copy (Vector3 that)->Vector3 {return this.Reset(that.X, that.Y, that.Z);}
	method GetCopy ()->Vector3 {return Vector3.create().Reset(this.X, this.Y, this.Z);}
	method Normalize ()->real {
		real length= this.Length;
		if (length!= 0) this.Scale(1/ length);
		return length;
	}
	method GetNormalizedCopy ()->Vector2 {Vector3 n= this.GetCopy(); n.Normalize(); return n;}
	method GetNormal ()->Vector3 {
		Vector3 perpendicular= this.CrossProduct(Vector3.UnitX);
		if (perpendicular.SquaredLength<= 0) {
			perpendicular.destroy();
			perpendicular= this.CrossProduct(Vector3.UnitY);
		}
		return perpendicular;
	}

	method Swap (Vector3 that) {
		real temp;
		temp= this.X; this.X= that.X; that.X= temp;
		temp= this.Y; this.Y= that.Y; that.Y= temp;
		temp= this.Z; this.Z= that.Z; that.Z= temp;
	}
	method GetSquaredDistanceWith (Vector3 that)->real {
		return (this.X-that.X)*(this.X-that.X)+ (this.Y-that.Y)*(this.Y-that.Y)+ (this.Z-that.Z)*(this.Z-that.Z);
	}
	method GetDistanceWith (Vector3 that)->real {
		return Math.Sqrt(
			(this.X- that.X)* (this.X- that.X)+
			(this.Y- that.Y)* (this.Y- that.Y)+
			(this.Z- that.Z)* (this.Z- that.Z)
		);
	}
	method GetAngleWith (Vector3 that)->real {
		real mul= this.Length* that.Length;
		if (!(mul!= 0)) {
			debug Print("[Vector3.GetAngleWith] The length of at least one of the vectors is 0.0!");
			return 0.0;
		}
		return Acos((this.X* that.X+ this.Y* that.Y+ this.Z* that.Z)/ mul);
	}
	method GetMiddle (Vector3 that)->Vector3 {
		return Vector3.create().Reset((this.X+ that.X)/2, (this.Y+ that.Y)/2, (this.Z+ that.Z)/2);
	}
	method MakeFloor (Vector3 that)->Vector3 {
		if (that.X< this.X) this.X= that.X;
		if (that.Y< this.Y) this.Y= that.Y;
		if (that.Z< this.Z) this.Z= that.Z;
		return this;
	}
	method MakeCeil (Vector3 that)->Vector3 {
		if (that.X> this.X) this.X= that.X;
		if (that.Y> this.Y) this.Y= that.Y;
		if (that.Z> this.Z) this.Z= that.Z;
		return this;
	}

	method Add (Vector3 that)->Vector3 {this.X+= that.X; this.Y+= that.Y; this.Z+= that.Z; return this;}
	method Subtract (Vector3 that)->Vector3 {this.X-= that.X; this.Y-= that.Y; this.Z-= that.Z; return this;}
	method Scale (real factor)->Vector3 {this.X*= factor; this.Y*= factor; this.Z*= factor; return this;}
	method DotProduct (Vector3 that)->real {
		return this.X* that.X+ this.Y* that.Y+ this.Z* that.Z;
	}
	method CrossProduct (Vector3 that)->Vector3 {
		Vector3 result= Vector3.create();
		result.X= this.Y* that.Z- that.Y* this.Z;
		result.Y= this.Z* that.X- that.Z* this.X;
		result.Z= this.X* that.Y- that.X* this.Y;
		return result;
	}
	method Project (Vector3 direction)->Vector3 {
		real len2 = direction.X* direction.X+ direction.Y* direction.Y+ direction.Z*direction.Z;
		if (!(len2!= 0.0)) {
			debug Print("[Vector3.Project] The length of the direction vector is 0.0!");
			return 0;
		}
		len2 = (this.X* direction.X+ this.Y* direction.Y+ this.Z* direction.Z)/ len2;
		return this.Reset(direction.X* len2, direction.Y* len2, direction.Z* len2);
	}
	method Rotate (Vector3 axis, real angle)->Vector3 {
		real xx= 0.0, xy= 0.0, xz= 0.0;
		real yx= 0.0, yy= 0.0, yz= 0.0;
		real zx= 0.0, zy= 0.0, zz= 0.0;
		real al= axis.X* axis.X+ axis.Y* axis.Y+ axis.Z* axis.Z;
		real f= 0.0;
		real c= Cos(angle), s= Sin(angle);
		if (!(al!= 0.0)) {
			debug Print("[Vector3.Rotate] The length of the axis vector is 0.0!");
			return this;
		}
		f= (this.X* axis.X+ this.Y* axis.Y+ this.Z* axis.Z)/ al;
		zx= axis.X* f; zy= axis.Y* f; zz= axis.Z* f;
		xx= this.X- zx; xy= this.Y- zy; xz= this.Z- zz;
		al= SquareRoot(al);
		yx= (axis.Y* xz- axis.Z* xy)/ al;
		yy= (axis.Z* xx- axis.X* xz)/ al;
		yz= (axis.X* xy- axis.Y* xx)/ al;
		return this.Reset(xx*c+ yx*s+ zx, xy*c+ yy*s+ zy, xz*c+ yz*s+ zz);
	}
	method Interpolate (Vector3 that, real k)->Vector3 {
		Vector3 result= Vector3.allocate();
		real d= 1.0- k;
		result.X= that.X* d+ this.X* k;
		result.Y= that.Y* d+ this.X* k;
		result.Z= that.Z* d+ this.Z* k;
		return result;
	}

	method IsInCylinder (Vector3 cylinderOrigin, Vector3 cylinderHeight, real cylinderRadius)->boolean {
		real len2= 0.0;
		real x= this.X- cylinderOrigin.X;
		real y= this.Y- cylinderOrigin.Y;
		real z= this.Z- cylinderOrigin.Z;
		//  point below cylinder
		if (x* cylinderHeight.X+ y* cylinderHeight.Y+ z* cylinderHeight.Z< 0.0)
			return false;
		x-= cylinderHeight.X;
		y-= cylinderHeight.Y;
		z-= cylinderHeight.Z;
		//  point above cylinder
		if (x* cylinderHeight.X+ y* cylinderHeight.Y+ z* cylinderHeight.Z> 0.0)
			return false;
		len2=  cylinderHeight.X* cylinderHeight.X+ cylinderHeight.Y* cylinderHeight.Y+ cylinderHeight.Z* cylinderHeight.Z;
		if (!(len2!=  0.0)) {
			debug Print("[Vector3.IsInCylinder] The length of the cylinderHeight vector is 0.0!");
			return false;
		}
		len2=  (x* cylinderHeight.X+ y*cylinderHeight.Y+ z* cylinderHeight.Z)/ len2;
		x-= cylinderHeight.X* len2;
		y-= cylinderHeight.Y* len2;
		z-= cylinderHeight.Z* len2;
		//  point outside cylinder
		return x* x+ y* y+ z* z<= cylinderRadius* cylinderRadius;
	}

	method IsInCone (Vector3 coneOrigin, Vector3 coneHeight, real coneRadius)->boolean {
		real len2= 0.0;
		real x= this.X- coneOrigin.X;
		real y= this.Y- coneOrigin.Y;
		real z= this.Z- coneOrigin.Z;
		//  point below cone
		if (x* coneHeight.X+ y* coneHeight.Y+ z* coneHeight.Z< 0.0)
			return false;
		len2= coneHeight.X* coneHeight.X+ coneHeight.Y* coneHeight.Y+ coneHeight.Z* coneHeight.Z;
		if (!(len2!= 0.0)) {
			debug Print("[Vector3.IsInCone] The length of the coneHeight vector is 0.0!");
			return false;
		}
		len2= (x* coneHeight.X+ y* coneHeight.Y+ z* coneHeight.Z)/ len2;
		x= x- coneHeight.X* len2;
		y= y- coneHeight.Y* len2;
		z= z- coneHeight.Z* len2;
		//  point outside cone
		return SquareRoot(x* x+ y* y+ z* z)<= coneRadius*(1.0- len2);
	}

	method IsInSphere (Vector3 sphereOrigin, real sphereRadius)->boolean {
		return sphereRadius>= this.GetDistanceWith(sphereOrigin);
	}

	method ToString ()->string {
		return "("+ R2S(this.X)+ ", "+ R2S(this.Y)+ ", "+ R2S(this.Z)+ ")";
	}

	private static method onInit () {
		Vector3.Zero= Vector3(Vector2.Zero).Reset(0, 0, 0);
		Vector3.UnitX= Vector3(Vector2.UnitX).Reset(1, 0, 0);
		Vector3.UnitY= Vector3(Vector2.UnitY).Reset(0, 1, 0);
		Vector3.UnitZ= Vector3.create().Reset(0, 0, 1);
		Vector3.UnitScale= Vector3(Vector2.UnitScale).Reset(1, 1, 1);
		Vector3.NegativeUnitX= Vector3(Vector2.NegativeUnitX).Reset(-1, 0, 0);
		Vector3.NegativeUnitY= Vector3(Vector2.NegativeUnitY).Reset(0, -1, 0);
		Vector3.NegativeUnitZ= Vector3.create().Reset(0, 0, -1);
		Vector3.Temp= Vector3(Vector2.Temp).Reset(0, 0, 0);
	}
}
