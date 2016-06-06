public struct Node {
	integer Data = 0;
	integer Size = 0;
	Node Parent = 0;
	Node Prev = 0,  Next = 0;
	Node First = 0, Last = 0;

	static method create (integer data)->Node {
		Node this = Node.allocate();
		this.Data = data;
		return this;
	}
	method destroy () {this.Finalize();}
	method Finalize ()->integer {
		Node parent = this.Parent;
		Node prev = this.Prev;
		Node next = this.Next;
		integer value = this.Data;
		if (this == 0) return 0;
		if (parent!= 0) {
			if (parent.First == this) parent.First = next;
			if (parent.Last == this) parent.Last = prev;
			parent.Size-= 1;
		}
		if (prev!= 0) prev.Next = next;
		if (next!= 0) next.Prev = prev;
		this.Clear();
		this.deallocate();
		return value;
	}
	method Clear () {
		if (this == 0) return;
		this.First.destroyNode();
		this.First = 0; this.Last = 0;
		this.Size = 0;
	}
	// destroy siblings, children, and this
	private method destroyNode () {
		if (this == 0) return;
		if (this.First == 0 &&  this.Next == 0)
			this.deallocate();
		else {
			this.First.destroyNode();
			this.Next.destroyNode();
			this.deallocate();
		}
	}

	method operator Empty ()->boolean {return this.Size == 0;}
	method operator Depth ()->integer {return this.First.depth;}
	private method operator depth ()->integer {
		if (this.First == 0)
			return 1;
		return IMaxBJ(this.First.depth+ 1 ,this.Next.depth);
	}
	method operator Random ()->Node {
		integer random = R2I(Math.Random* this.Size);
		Node i;
		if (this.Size == 0) return 0;
		for (i = this.First; i!= 0&& random> 0; i = i.Next)
			random-= 1;
		return i;
	}

	method Contains (integer data, boolean flag)->boolean {
		return this.NodeOf(data, flag)!= 0;
	}
	method Count (integer data, boolean flag)->integer {
		integer count = 0;
		Node i;
		for (i = this.First; i!= 0; i = i.Next) {
			if (i.Data == data)
				count += 1;
			if (flag)
				count += i.Count(data, true);
		}
		return count;
	}

	// Gets the Node of the given element
	method NodeOf (integer data, boolean flag)->Node {
		Node i, n;
		if (this == 0) return 0;
		for (i = this.First; i != 0; i = i.Next) {
			if (i.Data == data)
				return i;
			if (flag) {
				n = i.NodeOf(data, true);
				if (n != 0)
					return n;
			}
		}
		return 0;
	}
	method LastNodeOf (integer data, boolean flag)->Node {
		Node i, n;
		if (this == 0) return 0;
		for (i = this.Last; i != 0; i = i.Prev) {
			if (flag) {
				n = i.LastNodeOf(data, true);
				if (n != 0)
					return n;
			}
			if (i.Data == data)
				return i;
		}
		return 0;
	}


	//  AddFirst, AddLast, AddPrev, AddNext (Node i)
	method AddFirst (Node i)->Node {
		Node first = this.First;
		if (i == 0) return 0;
		i.Parent = this;
		i.Prev = 0;
		i.Next = first;
		if (first == 0)
			this.Last = i;
		else
			first.Prev = i;
		this.First = i;
		this.Size += 1;
		return i;
	}
	method AddLast (Node i)->Node {
		Node last = this.Last;
		if (i == 0) return 0;
		i.Parent = this;
		i.Prev = last;
		i.Next = 0;
		if (last == 0)
			this.First = i;
		else
			last.Next = i;
		this.Last = i;
		this.Size += 1;
		return i;
	}
	method AddPrev (Node i)->Node {
		Node prev = this.Prev;
		Node parent = this.Parent;
		if (i == 0) return 0;
		i.Parent = parent;
		i.Prev = prev;
		i.Next = this;
		if (prev != 0)
			prev.Next = i;
		this.Prev = i;
		if (parent != 0) {
			if (parent.First == this)
				parent.First = i;
			parent.Size += 1;
		}
		return i;
	}
	method AddNext (Node i)->Node {
		Node next = this.Next;
		Node parent = this.Parent;
		if (i == 0) return 0;
		i.Parent = parent;
		i.Prev = this;
		i.Next = next;
		if (next != 0)
			next.Prev = i;
		this.Next = i;
		if (parent != 0) {
			if (parent.Last == this)
				parent.Last = i;
			parent.Size += 1;
		}
		return i;
	}

	// New element
	method Push (integer data)->Node {return this.AddLast(Node.create(data));}
	method Add (integer data)->Node {return this.AddLast(Node.create(data));}
	method Unshift(integer data)->Node {return this.AddFirst(Node.create(data));}
	method InsertBefore (integer data)->Node {return this.AddPrev(Node.create(data));}
	method InsertAfter (integer data)->Node {return this.AddNext(Node.create(data));}

	// Delete element
	method Pop ()->integer {return this.Last.Finalize();}
	method Shift ()->integer {return this.First.Finalize();}
	method Remove (integer data, boolean flag)->boolean {
		Node i = this.NodeOf(data, flag);
		if (i == 0) return false;
		i.Finalize();
		return true;
	}
	method Purge (integer data, boolean flag)->integer {
		integer count = 0;
		Node i;
		for (i = this.First; i != 0; i = i.Next) {
			if (i.Data == data) {
				i.Finalize();
				count += 1;
			}
			if (flag)
				count += i.Purge(data, true);
		}
		return count;
	}

	//  Evaluate, Traverse
	method Evaluate (integer data, boolean flag) {
		Node i;
		for (i = this.First; i != 0; i = i.Next) {
			Action(i.Data).evaluate(data);
			if (flag)
				i.Evaluate(data, true);
		}
	}
	method Traverse (Action action, boolean flag) {
		Node i;
		for (i = this.First; i != 0; i = i.Next) {
			action.evaluate(i.Data);
			if (flag)
				i.Traverse(action, true);
		}
	}

	// Sort
	public method Sort (Comparer comparer) {
		Node first, second, tail, temp;
		integer firstSize, secondSize, i;
		integer step = 1;
		integer mergeCount = 2;
		if (this.Size < 2) return;
		while (mergeCount > 1) {
			first = this.First;
			tail = 0;
			mergeCount = 0;
			while (first != 0) {
				mergeCount += 1;
				second = first;
				for (i = 0; i < step && second != 0; i += 1)
					second = second.Next;
				firstSize = i;
				secondSize = step;
				while (firstSize > 0 || (secondSize > 0 && second != 0)) {
					if (firstSize > 0 && (secondSize == 0 || second == 0 || comparer.evaluate(first, second))) {
						temp = first;
						first = first.Next;
						firstSize -= 1;
					} else {
						temp = second;
						second = second.Next;
						secondSize -= 1;
					}
					if (tail != 0) {
						tail.Next = temp;
						temp.Prev = tail;
					} else {
						this.First = temp;
						this.First.Prev = 0;
					}
					tail = temp;
				}
				first = second;
			}
			tail.Next = 0;
			this.Last = tail;
			step *= 2;
		}
	}

	// SetArc, getArc
	// If @para weight equals zero, remove the special arc
	method SetWeight (Node that, integer weight)->integer {
		Node arc = this.getArc(that);
		integer originalWeight = 0;
		if (arc == 0) {
			if (weight!= 0)
				this.Add(weight).Last = that;
			return 0;
		}
		originalWeight = arc.Data;
		arc.Data = weight;
		if (weight == 0)
			arc.Finalize();
		return originalWeight;
	}
	method GetWeight (Node that)->integer {
		return this.getArc(that).Data;
	}
	private method getArc (Node that)->Node {
		Node i;
		for (i = this.First; i!= 0; i = i.Next) {
			if (i.Last == that)
				return i;
		}
		return 0;
	}

	method operator DebugString ()->string {
		string parent = I2S(this.Parent);
		string siblings = "("+ I2S(this.Prev)+ ", "+ I2S(this)+ ", "+ I2S(this.Next)+ ")";
		string children = "("+ I2S(this.First)+ ", "+ I2S(this.Last)+ ")";
		string data = "(@"+ I2S(this.Data)+ ", #"+ I2S(this.Size)+ ")";
		return "{"+ parent+ "--"+ siblings+ "--"+ children+ ", "+ data+ "}";
	}
}
