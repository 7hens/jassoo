public struct Tree {
	delegate Node Node= 0;

	static method create ()->Tree {
		Tree this= Node.create(0);
		this.Node= this;
		return this;
	}
	method destroy () {this.Node.Finalize();}

	method Contains (integer data)->boolean {return this.NodeOf(data)!= 0;}
	method Count (integer data)->integer {return this.Node.Count(data, true);}
	method Remove (integer data)->boolean {return this.Node.Remove(data, true);}
	method Purge (integer data)->integer {return this.Node.Purge(data, true);}
	method NodeOf (integer data)->Node {return this.Node.NodeOf(data, true);}
    method LastNodeOf (integer data)->Node {return this.Node.LastNodeOf(data, true);}
	method NodeAt (integer index)->Node {
		Node i= this.Node.First;
		index= Tree.invertIndex(index);
		while (index> 0 && i!= 0) {
			if (Tree.isEvenNumber(index))
				i= i.Next;
			else
				i= i.First;
			index= (index- 1)/ 2;
		}
		return i;
	}
	private static method invertIndex (integer index)->integer {
		integer i= 0;
		while (index> 0) {
			i= i* 2+ 1;
			if (Tree.isEvenNumber(index))
				i+= 1;
			index= (index- 1)/ 2;
		}
		return i;
	}
	private static method isEvenNumber (integer i)->boolean {return R2I(Math.Modulo(i, 2.0))== 0;}

	method IndexOf (integer data)->integer {
		Node i= this.NodeOf(data);
		Node parent= i.Parent;
		integer index= 0;
		if (i== 0)
			return -1;
		while (parent!= this.Node.First) {
			index= index* 2+ 1;
			if (i== parent.Next)
				index+= 1;
			i= parent;
			parent= i.Parent;
		}
		return Tree.invertIndex(index);
	}

	method operator [] (integer index)->integer {return this.NodeAt(index).Data;}
	method operator []= (integer index, integer data) {
		Node i= this.NodeAt(index);
		if (i== 0) {
			index= Tree.invertIndex(index);
			i= this.goToNext(false);
			while (index> 0) {
				i= Tree(i).goToNext(Tree.isEvenNumber(index));
				index= (index- 1)/ 2;
			}
		}
		i.Data= data;
	}
	private method goToNext (boolean flag)->Node {
		if (this== 0) return 0;
		if (flag) {
			if (this.Next== 0)
				this.InsertAfter(0);
			return this.Next;
		}
		if (this.First== 0)
			this.Push(0);
		return this.First;
	}

	method Evaluate (integer data) {this.Node.Evaluate(data, true);}
	method Traverse (Action action) {this.Node.Traverse(action, true);}
}
