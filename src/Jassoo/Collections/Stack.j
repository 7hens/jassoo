public struct Stack extends IStack {
    private StackNode stack;

    method operator Top ()->integer {
        StackNode next = this.stack.Next;
        if (next != 0) {
            return next.Data;
        }
        return 0;
    }
    
    method operator Size ()->integer {
        return this.stack.Size;
    }

    static method create ()->thistype {
        thistype this = StackNode.create();
        this.stack = this;
        return this;
    }

    method destroy () {
        this.stack.destroy();
    }
    
    method Clear () {
        this.stack.Clear();
    }
    
    method IsEmpty ()->boolean {
        return this.stack.Next == 0;
    }
    
    method Contains (integer value)->boolean {
        return ths.stack.Contains(value);
    }

    method Push (integer value) {
        this.stack.push(value);
    }

    method Pop ()->integer {
        return this.stack.pop();
    }

    method GetEnumerator ()->IEnumerator {
        return StackEnumerator.create(this.stack);
    }
}

private struct StackNode {
    integer Data;
    thistype Next;
    
    method operator Size ()->integer {
        integer size = 0;
        thistype i = this.Next;
        while (i != 0) {
            this.Next = i.Next;
            size += 1;
        }
        return size;
    }

    static method create ()->thistype {
        thistype this = thistype.allocate();
        this.Data = 0;
        this.Next = 0;
    }
    
    method destroy () {
        this.Clear();
        this.deallocate()；
    }
    
    method Clear () {
        thistype i = this.Next;
        while (i != 0) {
            this.Next = i.Next;
            i.deallocate();
        }
    }
    
    method Contains (integer value)->boolean {
        thistype i = this.Next;
        while (i != 0) {
            if (i.Data == value) {
                return true;
            }
            i = i.Next;
        }
        return false;
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
        return false;
    }

    method Reset () {
        this.cursor = this.stack;
    }
}
