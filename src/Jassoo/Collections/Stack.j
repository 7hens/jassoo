public struct Stack {
    private StackNode head;
    private StackNode rear;
    private integer size;

    static method create ()->thistype {
        thistype this = StackNode.create();
        this.head = this;
        this.rear = this;
        this.size = 0;
        return this;
    }

    method destroy () {
        this.size = 0;
        this.head.destroy();
    }
    
    method operator Size ()->integer {
        return this.size;
    }

    method operator First ()->integer {
        StackNode next = this.head.Next;
        if (next != 0) {
            return next.Data;
        }
        return 0;
    }
    
    method operator Last ()->integer {
        return this.rear.Data;
    }
    
	method operator Random ()->integer {
		integer random = R2I(Math.Random * this.size);
        StackNode i = this.head.Next;
        while (i != 0 && random > 0) {
            random -= 1;
            i = i.Next;
        }
        return i.Data;
	}
    
    method Add (integer value) {
        this.size += 1;
        this.rear = this.rear.Push(value);
    }
    
    method Push (integer value) {
        this.size += 1;
        this.head.Push(value);
    }

    method Pop ()->integer {
        if (this.size > 0) {
            this.size -= 1;
            return this.head.Pop();
        }
        return 0;
    }
    
    method Clear () {
        this.size = 0;
        this.head.Clear();
        this.rear = this.head;
    }
    
    method IsEmpty ()->boolean {
        return this.size == 0;
    }
    
    method Contains (integer value)->boolean {
        return this.head.NodeOf(value) != 0;
    }
    
    method Count (integer value)->integer {
        return this.head.Count(value);
    }
    
    method Remove (integer value)->boolean {
        return this.head.Remove(value);
    }
    
    method Purge (integer value)->integer {
        return this.head.Purge(value);
    }
    
    method Filter (Filter filter)->integer {
        return this.head.Filter(filter);
    }

    method GetEnumerator ()->IEnumerator {
        return StackEnumerator.create(this.head);
    }
}

