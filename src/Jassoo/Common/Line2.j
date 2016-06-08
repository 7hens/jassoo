public struct Line2 {
	Vector2 Start, End;

	static method create ()->Line2 {
		Line2 this= Line2.allocate();
		this.Start= Vector2.create();
		this.End= Vector2.create();
		return this;
	}
	method destroy () {
		this.Start.destroy();
		this.End.destroy();
		this.deallocate();
	}

	method Reset (Vector2 start, Vector2 end)->Line2 {
		this.Start.Copy(start);
		this.End.Copy(end);
		return this;
	}
	method ResetXY (real startX, real startY, real endX, real endY)->Line2 {
		this.Start.Reset(startX, startY);
		this.End.Reset(endX, endY);
		return this;
	}

	method operator SquaredLength ()->real {
		Vector2 start= this.Start;
		Vector2 end= this.End;
		return (start.X- end.X)* (start.X- end.X)+ (start.Y- end.Y)* (start.Y- end.Y);
	}
	method operator Length ()->real {return this.Start.GetDistanceWith(this.End);}
	method GetMiddle ()->Vector2 {return this.Start.GetMiddle(this.End);}
	method GetVector ()->Vector2 {return Vector2.create().Reset(this.End.X- this.Start.X, this.End.Y- this.Start.Y);}
	method GetUnitVector ()->Vector2 {
		if (this.Start.Equals(this.End)) {
			debug Log.Error("Line2.GetUnitVector", "The length of line equals zero.");
			return 0;
		}
		return this.End.GetCopy().Subtract(this.Start).Scale(1/ this.Length);
	}

	// Tells us if the given point lies to the left, right, or on the line.
	//	return 0 if the point is on the line, <0 if to the left, or >0 if to the right.
	method GetPointOrientation (Vector2 p)->real {
		return (this.End.X- this.Start.X)* (p.Y- this.Start.Y)- (this.End.Y- this.Start.Y)* (p.X- this.Start.X);
	}
	method GetClosestPoint (Vector2 p)->Vector2 {
		Vector2 start;
		Vector2 end= this.End.GetCopy().Subtract(p);
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
	method IsPointOnLine (Vector2 p)->boolean {
		return this.GetPointOrientation(p)== 0&& p.IsBetween(this.Start, this.End);
	}

	method GetAngleWith (Line2 that)->real {
		Vector2 thisUnit= this.GetUnitVector();
		Vector2 thatUnit= that.GetUnitVector();
		real result= thisUnit.GetAngleWith(thatUnit);
		thisUnit.destroy();
		thatUnit.destroy();
		return result;
	}
	method GetIntersection (Line2 that)->Vector2 {
		real commonDenominator= (that.End.Y- that.Start.Y)* (this.End.X- this.Start.X)-
								(that.End.X- that.Start.X)* (this.End.Y- this.Start.Y);
		real numeratorA= (that.End.X- that.Start.X)* (this.Start.Y- that.Start.Y)-
						(that.End.Y- that.Start.Y)* (this.Start.X- that.Start.X);
		real numeratorB= (this.End.X- this.Start.X)* (this.Start.Y- that.Start.Y)-
						(this.End.Y- this.Start.Y)* (this.Start.X- that.Start.X);
		real uA= numeratorA/ commonDenominator;
		real uB= numeratorB/ commonDenominator;
		if (Math.IsZero(commonDenominator)&& Math.IsZero(numeratorA)&& Math.IsZero(numeratorB)) {
			if (this.Start.Equals(that.Start)|| this.Start.Equals(that.End))
				return this.Start.GetCopy();
			else if (this.End.Equals(that.Start)|| this.End.Equals(that.End))
				return this.End.GetCopy();
			else
				return Vector2.create().Add(this.Start).Add(this.End).Add(that.Start).Add(that.End).Scale(0.25);
		}
		if (Math.IsZero(commonDenominator)|| uA< 0|| uA> 1|| uB< 0|| uB> 1)
			return 0;
		return this.End.GetCopy().Subtract(this.Start).Scale(uA).Add(this.Start);
	}
}
