private struct StackNode {
    integer Data;
    thistype Next;
    
    static method create ()->thistype {
        thistype this = thistype.allocate();
        this.Data = 0;
        this.Next = 0;
        return this;
    }
    
    method destroy () {
        this.Clear();
        this.deallocate();
    }
    
    method operator Size ()->integer {
        integer size = 0;
        thistype i = this.Next;
        while (i != 0) {
            this.Next = i.Next;
            size += 1;
        }
        return size;
    }

    method Push (integer value)->thistype {
        thistype node = thistype.allocate();
        node.Data = value;
        node.Next = this.Next;
        this.Next = node;
        return this;
    }

    method Pop ()->integer {
        thistype next = this.Next;
        integer value = 0;
        if (next != 0) {
            value = next.Data;
            this.Next = next.Next;
            next.destroy();
        }
        return value;
    }
    
    method Clear () {
        thistype i = this.Next;
        while (i != 0) {
            this.Next = i.Next;
            i.deallocate();
        }
    }
    
    method NodeOf (integer value)->StackNode {
        thistype i = this.Next;
        while (i != 0) {
            if (i.Data == value) {
                return i;
            }
            i = i.Next;
        }
        return 0;
    }
    
	method Count (integer value)->integer {
		integer count = 0;
		thistype i = 0;
		for (i = this.Next; i != 0; i = i.Next) {
			if (i.Data == value) {
				count += 1;
            }
		}
		return count;
	}
    
    method Remove (integer value)->boolean {
        thistype i = this.Next;
        thistype j = this;
        while (i != 0) {
            if (i.Data == value) {
                j.Next = i.Next;
                i.deallocate();
                return true;
            }
            j = i;
            i = i.Next;
        }
        return false;
    }
    
    method Purge (integer value)->integer {
        thistype i = this.Next;
        thistype j = this;
		integer count = 0;
        while (i != 0) {
            if (i.Data == value) {
                j.Next = i.Next;
                i.deallocate();
                i = j;
                count += 1;
            }
            j = i;
            i = i.Next;
        }
        return count;
    }
    
    method Filter (Filter filter)->integer {
        thistype i = this.Next;
        thistype j = this;
		integer count = 0;
        while (i != 0) {
            if (filter.evaluate(i.Data)) {
                j.Next = i.Next;
                i.deallocate();
                i = j;
                count += 1;
            }
            j = i;
            i = i.Next;
        }
        return count;
    }
}

private struct StackEnumerator extends IEnumerator {
    private StackNode stack;
    private StackNode cursor;

    static method create (StackNode stack)->thistype {
        thistype this = thistype.allocate();
        this.stack = stack;
        this.cursor = stack;
        return this;
    }

    method operator Current ()->integer {
        return this.cursor.Data;
    }

    method MoveNext ()->boolean {
        if (this.cursor != 0) {
            this.cursor = this.cursor.Next;
            return true;
        }
        this.destroy();
        return false;
    }

    method Reset () {
        this.cursor = this.stack;
    }
}
