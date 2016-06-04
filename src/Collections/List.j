public struct List {
    delegate Node Node;

    static method create ()->List {
        List this= Node.create(0);
        this.Node= this;
        return this;
    }
    method destroy () {this.Node.Finalize();}

    method Contains (integer data)->boolean {return this.Node.NodeOf(data, false)!= 0;}
    method Count (integer data)->integer {return this.Node.Count(data, false);}
    method Remove (integer data)->boolean {return this.Node.Remove(data, false);}
    method Purge (integer data)->integer {return this.Node.Purge(data, false);}
    method NodeOf (integer data)->Node {return this.Node.NodeOf(data, false);}
    method LastNodeOf (integer data)->Node {return this.Node.LastNodeOf(data, false);}
    method NodeAt (integer index)->Node {
        Node i= this.First;
    	if (index< 0) index= this.Size+ index;
    	if (index>= this.Size|| index< 0) {
        	debug Print("[List.NodeAt] the given index is out of range.");
        	return 0;
    	}
    	for (i= this.First; i!= 0&& index> 0; i= i.Next)
    		index-= 1;
		return i;
    }
    method IndexOf (integer data)->integer {
		integer index= 0;
		Node i;
		for (i= this.First; i!= 0; i= i.Next) {
			if (i.Data== data)
				return index;
			index+= 1;
		}
		return -1;
    }
    method LastIndexOf (integer data)->integer {
		integer index= 1;
		Node i;
		for (i= this.Last; i!= 0; i= i.Prev) {
			if (i.Data== data)
				return this.Size- index;
			index+= 1;
		}
		return -1;
    }

    method operator [] (integer index)->List {return this.NodeAt(index).Data;}
    method operator []= (integer index, List data) {
        if (index< this.Size&& index>= -this.Size)
	        this.NodeAt(index).Data= data;
        else if (index== this.Size)
        	this.Add(data);
    }
    method Insert (integer value, integer index)->Node {
        if (index< this.Size&& index>= -this.Size)
	    	return this.NodeAt(index).InsertBefore(value);
    	if (index== this.Size)
	    	return this.Add(value);
    	return 0;
    }
    method Delete (integer index)->integer {return this.NodeAt(index).Finalize();}

    //  SetWeight, SetWeight2, GetWeight
    static method SetWeight (Node one, Node other, integer weight)->integer {
        return one.SetWeight(other, weight);
    }
    static method SetWeight2 (Node one, Node other, integer weight) {
        one.SetWeight(other, weight);
        other.SetWeight(one, weight);
    }
    static method GetWeight (Node one, Node other)->integer {
        return one.GetWeight(other);
    }

    //  Evaluate(data), Traverse(action)
    method Evaluate (integer data) {this.Node.Evaluate(data, false);}
    method Traverse (Action action) {this.Node.Traverse(action, false);}
}
