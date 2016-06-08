public struct Group {
	static Group WorldGroup = 0;
	delegate Stack Stack = 0;

	static method create ()->Group {
		Group this = Stack.create();
		this.Stack = this;
		return this;
	}
	method destroy () {this.Stack.destroy();}

	method GetCenterPoint ()->Point {
		Point result= Point.create();
		Unit u = 0;
		IEnumerator e = this.GetEnumerator();
        if (this.IsEmpty()) {
            return result;
        }
        while (e.MoveNext()) {
            u = e.Current;
            result.Reset(result.X + u.X, result.Y + u.Y);
        }
		return result.Scale(1 / this.Size);
	}
	method GetClosestUnit (Unit u)->Unit {
		real sqrDist, minSqrDist;
		Unit result, v;
		IEnumerator e = this.GetEnumerator();
		if (this.IsEmpty()) return 0;
        
		result = this.First;
		if (this.Size == 1) return result;
		if (result == u) result = this.Last;
        
		u.ResetPoint();
		result.ResetPoint();
		minSqrDist = u.GetSquaredDistanceWith(result);
        
        while (e.MoveNext()) {
            v = e.Current;
            if (v != u && v != result) {
                v.ResetPoint();
				sqrDist= u.GetSquaredDistanceWith(v);
                
				if (sqrDist < minSqrDist) {
					result = v;
					minSqrDist = sqrDist;
				}
            }
        }
		return result;
	}
    
	method GetFurthestUnit (Unit u)->Unit {
		real sqrDist, minSqrDist;
		Unit result, v;
		IEnumerator e = this.GetEnumerator();
		if (this.IsEmpty()) return 0;
        
		result = this.First;
		if (this.Size == 1) return result;
		if (result == u) result = this.Last;
        
		u.ResetPoint();
		result.ResetPoint();
		minSqrDist = u.GetSquaredDistanceWith(result);
        
        while (e.MoveNext()) {
            v = e.Current;
            if (v != u && v != result) {
                v.ResetPoint();
				sqrDist= u.GetSquaredDistanceWith(v);
                
				if (sqrDist > minSqrDist) {
					result = v;
					minSqrDist = sqrDist;
				}
            }
        }
		return result;
	}
    
	method Add (Unit u) {
		if (!this.Contains(u)) {
			this.Stack.Add(u);
        }
	}
    
	method Push (Unit u) {
		if (!this.Contains(u)) {
			this.Stack.Push(u);
        }
	}
    
	method AddGroup (Group grp) {
        IEnumerator e = this.GetEnumerator();
        while (e.MoveNext()) {
            this.Add(e.Current);
        }
	}
    
	method Refresh ()->Group {
        this.Filter(Unit.IsAlive);
        return this;
	}
    
	method AddUnitsInRange (Point pos, real radius) {
        IEnumerator e = this.GetEnumerator();
        Unit current = 0;
        while (e.MoveNext()) {
            current = e.Current;
            if (current.IsInRange(pos, radius)) {
                this.Add(current);
            }
        }
	}
    
	method OrderImmediate (integer orderId) {
        IEnumerator e = this.GetEnumerator();
        while (e.MoveNext()) {
			Unit(e.Current).OrderImmediate(orderId);
        }
	}
    
	method OrderPoint (integer orderId, Point pos) {
        IEnumerator e = this.GetEnumerator();
        while (e.MoveNext()) {
			Unit(e.Current).OrderPoint(orderId, pos);
        }
	}
    
	method OrderTarget (integer orderId, IWidget target) {
        IEnumerator e = this.GetEnumerator();
        while (e.MoveNext()) {
			Unit(e.Current).OrderTarget(orderId, target);
        }
	}

	private static method onInit () {
		Group.WorldGroup= Group.create();
	}
}
