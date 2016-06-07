public struct Group {
	static Group WorldGroup= 0;
	private delegate List List= 0;

	static method create ()->Group {
		Group this= List.create();
		this.List= this;
		return this;
	}
	method destroy () {this.List.destroy();}

	method operator FirstUnit ()->Unit {return this.First.Data;}
	method operator LastUnit ()->Unit {return this.Last.Data;}

	method GetCenterPoint ()->Point {
		Point result= Point.create();
		Unit enum;
		Node i;
		if (this.Empty)
			return result;
		for (i= this.First; i!= 0; i= i.Next) {
			enum= i.Data;
			result.Reset(result.X+ enum.X, result.Y+ enum.Y);
		}
		return result.Scale(1/ this.Size);
	}
	method GetClosestUnit (Unit u)->Unit {
		real sqrDist, minSqrDist;
		Unit result, enum;
		Node i;
		if (this.Empty) return 0;
		result= this.First.Data;
		if (this.Size== 1) return result;
		if (result== u) result= this.Last.Data;
		u.ResetPoint();
		result.ResetPoint();
		minSqrDist= u.GetSquaredDistanceWith(result);
		for (i= this.First; i!= 0; i= i.Next) {
			enum= i.Data;
			if (enum!= u&& enum!= result) {
				enum.ResetPoint();
				sqrDist= u.GetSquaredDistanceWith(enum);
				if (sqrDist< minSqrDist) {
					result= enum;
					minSqrDist= sqrDist;
				}
			}
		}
		return result;
	}
	method GetFurthestUnit (Unit u)->Unit {
		real sqrDist, maxSqrDist;
		Unit result, enum;
		Node i;
		if (this.Empty) return 0;
		result= this.First.Data;
		if (this.Size== 1) return result;
		if (result== u) result= this.Last.Data;
		u.ResetPoint();
		result.ResetPoint();
		maxSqrDist= u.GetSquaredDistanceWith(result);
		for (i= this.First; i!= 0; i= i.Next) {
			enum= i.Data;
			if (enum!= u&& enum!= result) {
				enum.ResetPoint();
				sqrDist= u.GetSquaredDistanceWith(enum);
				if (sqrDist> maxSqrDist) {
					result= enum;
					maxSqrDist= sqrDist;
				}
			}
		}
		return result;
	}
	method Add (Unit u) {
		if (!this.List.Contains(u))
			this.List.Add(u);
	}
	method Push (Unit u) {
		if (!this.List.Contains(u))
			this.List.Push(u);
	}
	method AddGroup (Group grp)->Group {
		Node i;
		for (i= grp.First; i!= 0; i= i.Next)
			this.Add(i.Data);
		return grp;
	}
	method Refresh ()->Group {
		Node i, j;
		Unit enum;
		for (i= this.First; i!= 0; i= j) {
			j= i.Next;
			enum= i.Data;
			if (!enum.Alive|| enum.Handle== null)
				i.destroy();
		}
		return this;
	}
	method AddUnitsInRange (Point pos, real radius) {
		Unit enum;
		Node i;
		for (i= Group.WorldGroup.First; i!= 0; i= i.Next) {
			enum= i.Data;
			if (enum.IsInRange(pos, radius))
				this.Add(enum);
		}
	}
	method OrderImmediate (integer orderId) {
		Node i;
		for (i= this.First; i!= 0; i= i.Next)
			Unit(i.Data).OrderImmediate(orderId);
	}
	method OrderPoint (integer orderId, Point pos) {
		Node i;
		for (i= this.First; i!= 0; i= i.Next)
			Unit(i.Data).OrderPoint(orderId, pos);
	}
	method OrderTarget (integer orderId, IWidget target) {
		Node i;
		for (i= this.First; i!= 0; i= i.Next)
			Unit(i.Data).OrderTarget(orderId, target);
	}

	private static method onInit () {
		Group.WorldGroup= Group.create();
	}
}
