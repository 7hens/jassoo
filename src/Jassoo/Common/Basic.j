public {
    type Void extends function ();
    type Action extends function (integer);
    type Func extends function (integer)->integer;

    type Comparer extends function (integer, integer)->integer;
    type BooleanComparer extends function (boolean, boolean)->integer;
    type RealComparer extends function (real, real)->integer;
    type StringComparer extends function (string, string)->integer;
}
