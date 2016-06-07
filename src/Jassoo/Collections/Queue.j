public struct Queue extends IStack {
    private StackNode stack;
    private StackNode rear;

    method operator Top ()->integer {
        StackNode next = this.stack.Next;
        if (next != 0) {
            return next.Data;
        }
        return 0;
    }
    
    method operator Bottom ()->integer {
        return this.rear.Data;
    }

    method operator Size ()->integer {
        return this.stack.Size;
    }
    
    static method create ()->thistype {
        thistype this = StackNode.create();
        this.stack = this;
        this.rear = this.stack;
        return this;
    }

    method destroy () {
        this.stack.destroy();
    }
    
    method Clear () {
        this.stack.Clear();
        this.rear = this.stack;
    }
    
    method IsEmpty ()->boolean {
        return this.stack.Next == 0;
    }
    
    method Contains (integer value)->boolean {
        return ths.stack.Contains(value);
    }

    method Push (integer value) {
        this.rear = this.rear.Push(value);
    }

    method Pop ()->integer {
        return this.stack.pop();
    }

    method GetEnumerator ()->IEnumerator {
        return StackEnumerator.create(this.stack);
    }
}
