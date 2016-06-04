public struct Line3 {
	private delegate Line2 Line2;

	static method create ()->Line3 {
		Line3 this= Line2.create();
		this.Line2= this;
		return this;
	}
	method destroy () {this.Line2.destroy();}

	method operator Start ()->Vector3 {return this.Line2.Start;}
	method operator Start= (Vector3 value) {if (value!= 0) this.Line2.Start= value;}
	method operator End ()->Vector3 {return this.Line2.End;}
	method operator End= (Vector3 value) {if (value!= 0) this.Line2.End= value;}
	method Reset (Vector3 start, Vector3 end)->Line3 {
		Vector3(this.Line2.Start).Copy(start);
		Vector3(this.Line2.End).Copy(end);
		return this;
	}
	method ResetXYZ (real startX, real startY, real startZ, real endX, real endY, real endZ)->Line3 {
		Vector3(this.Line2.Start).Reset(startX, startY, startZ);
		Vector3(this.Line2.End).Reset(endX, endY, endZ);
		return this;
	}
	method operator SquaredLength ()->real {
		Vector3 start= this.Start;
		Vector3 end= this.End;
		return (start.X- end.X)* (start.X- end.X)+ (start.Y- end.Y)* (start.Y- end.Y)+ (start.Z- end.Z)* (start.Z- end.Z);
	}
	method operator Length ()->real {return Vector3(this.Line2.Start).GetDistanceWith(this.Line2.End);}
	method GetMiddle ()->Vector3 {return Vector3(this.Line2.Start).GetMiddle(this.Line2.End);}
	method GetVector ()->Vector3 {return Vector3(this.Line2.End).GetCopy().Subtract(this.Line2.Start);}
	method GetUnitVector ()->Vector3 {
		Vector3 start= this.Line2.Start, end= this.Line2.End;
		if (start.Equals(end)) {
			debug Print("[Line3.GetUnitVector] The length of line equals zero.");
			return 0;
		}
		return end.GetCopy().Subtract(start).Scale(1/ this.Length);
	}

	method GetClosestPoint (Vector3 p)->Vector3 {
		Vector3 start;
		Vector3 end= this.End.GetCopy().Subtract(p);
		real length= end.Length;
		real dotProduct;
		if (Math.IsZero(length))
			return end;
		start= p.GetCopy().Subtract(this.Start);
		end.Scale(1/ length);
		dotProduct= end.DotProduct(start);
		start.destroy();
		if (dotProduct< 0)
			return end.Copy(this.Start);
		if (dotProduct> length)
			return end.Copy(this.End);
		return end.Scale(dotProduct).Add(this.Start);
	}
	method IntersectsWithSphere (Vector3 sphereOrigin, real sphereRadius)->boolean {
		Vector3 q= sphereOrigin.GetCopy().Subtract(this.Line2.Start);
		Vector3 unitVector= this.GetUnitVector();
		real dotProduct= q.DotProduct(unitVector);
		boolean result= (sphereRadius* sphereOrigin< q.SquaredLength- dotProduct* dotProduct);
		q.destroy();
		unitVector.destroy();
		return result;
	}
}
