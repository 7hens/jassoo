private {
	function getRandomInt (integer low, integer high)->integer {return GetRandomInt(low, high);}
	function getRandomReal (real low, real high)->real {return GetRandomReal(low, high);}
	function sin (real r)->real {return Sin(r);}
	function cos (real r)->real {return Cos(r);}
	function tan (real r)->real {return Tan(r);}
	function asin (real r)->real {return Asin(r);}
	function acos (real r)->real {return Acos(r);}
	function atan (real r)->real {return Atan(r);}
	function atan2 (real y, real x)->real {return Atan2(y, x);}
}
public struct Math {
	static constant integer MaxInt= 2147483647;
	static constant integer MinInt= -2147483648;
	static constant real Tolerance= 0.000001;
	static constant real PI= 3.1415927; //3.14159265358979323846
	static constant real E= 2.7182818; //2.71828182845904523536

	static method operator Random ()->real {return GetRandomReal(0.0, 1.0);}
	static method GetRandomReal (real low, real high)->real {return getRandomReal(low, high);}
	static method GetRandomInt (integer low, integer high)->integer {return getRandomInt(low, high);}

	static method Sign (real r)->real {if (r< 0) return -1.0; if (r> 0) return 1.0; return 0.0;}
	static method ISign (integer r)->integer {if (r< 0) return -1; if (r> 0) return 1; return 0;}
	//! textmacro Common_Math_Template takes T, I
	static method $I$Abs ($T$ r)->$T$ {if (r< 0) return -r; return r;}
	static method $I$Min ($T$ a, $T$ b)->$T$ {if (a> b) return b; return a;}
	static method $I$Max ($T$ a, $T$ b)->$T$ {if (a< b) return b; return a;}
	static method $I$Clamp ($T$ value, $T$ low, $T$ high)->$T$ {
		$T$ temp= high;
		if (low> high) {high= low; low= temp;}
		return Math.$I$Min(Math.$I$Max(value, low), high);
	}
	//! endtextmacro
	//! runtextmacro Common_Math_Template ("real", "")
	//! runtextmacro Common_Math_Template ("integer", "I")

	static method Equals (real a, real b, real tolerance)->boolean {return a+ tolerance>= b&& a- tolerance<= b;}
	// 0== 0.0009(true), 0== 0.001(false)
	// 0!= 0.0009(true), 0!= 0.000...1(true)
	static method IsZero (real r)->boolean {return r>= -Math.Tolerance&& r<= Math.Tolerance;}
	static method ToRadians (real degrees)->real {return degrees/180.0* Math.PI;}
	static method ToDegrees (real radians)->real {return radians* 180.0/ Math.PI;}

	static method Sin (real r)->real {return sin(r);}
	static method Cos (real r)->real {return cos(r);}
	static method Tan (real r)->real {return tan(r);}
	static method Asin (real r)->real {return asin(r);}
	static method Acos (real r)->real {return acos(r);}
	static method Atan (real r)->real {return atan(r);}
	static method Atan2 (real y, real x)->real {return atan2(y, x);}

	//  Hyperbolic sine, cosine, tangent
	static method Sinh (real y)->real {return (Math.Exp(y)- Math.Exp(-y))/ 2.0;}
	static method Cosh (real x)->real {return (Math.Exp(x)+ Math.Exp(-x))/ 2.0;}
	static method Tanh (real r)->real {return (Math.Exp(r)- Math.Exp(-r))/ (Math.Exp(r)+ Math.Exp(-r));}

	static method Ceil (real r)->real {real i= I2R(R2I(r)); if(Math.Modulo(r, 1.0)> 0.0) return i+ 1.0; return i;}
	static method Floor (real r)->real {return I2R(R2I(r));}
	static method Round (real r)->real {real i= I2R(R2I(r)); if(Math.Modulo(r, 1.0)>= 0.5) return i+ 1.0; return i;}
	static method Sqr (real r)->real {return r* r;}
	static method Sqrt (real r)->real {return SquareRoot(r);}
	static method InvSqrt (real r)->real {
		if (!(r!= 0)) {
			debug Log.Error("Math.InvSqrt", "the value equals zero.");
			return 0;
		}
		return 1/ SquareRoot(r);
	}
	static method Cbr (real r)->real {return r* r* r;}
	static method Cbrt (real r)->real {return Math.Power(r, 0.333333);}
	static method InvCbrt (real r)->real {
		if (!(r!= 0)) {
			debug Log.Error("Math.InvCbrt", "the value equals zero.");
			return 0;
		}
		return 1/ Math.Power(r, 0.333333);
	}
	static method Power (real a, real power)->real {return Pow(a, power);}
	static method Exp (real power)->real {return Pow(Math.E, power);}
	static method Log (real r, real a)->real {return Math.Ln(r)/ Math.Ln(a);}
	static method Lg (real r)->real {return Math.Ln(r)/ Math.Ln(10.0);}
	static method Hypot (real x, real y)->real {return SquareRoot(x* x+ y* y);}

	//  if (the dividend was negative, the below modulus calculation will be negative, but within (-divisor~0).
	//  We can add (divisor) to shift this result into the desired range of (0~divisor).
	static method Modulo (real dividend, real divisor)->real {
		real modulus= dividend- I2R(R2I(dividend/ divisor))* divisor;
		if (modulus< 0)
			modulus+= divisor;
		return modulus;
	}
	static method IModulo (integer dividend, integer divisor)->integer {
		integer modulus= dividend- dividend/ divisor* divisor;
		if (modulus< 0)
			modulus+= divisor;
		return modulus;
	}

	// )->the value that is closest in value to the argument &&  is equal to a mathematical integer.
	//  if (two values that are integers are equally close, the result is the integer value that is even.
	static method Rint (real r)->real {
		real i= I2R(R2I(r));
		real modulo= Math.Modulo(r, 1.0);
		if (modulo> 0.5 || (modulo== 0.5 &&  Math.Modulo(i, 2.0)!= 0.0))
			return i+ 1.0;
		return i;
	}

	//  Computes the remainder operation on two arguments as prescribed by the IEEE 754 standard.
	//  The IEEERemainder method is not the same as the modulus operator.
	static method IEEERemainder (real dividend, real divisor)->real {
		return dividend- divisor* Math.Round(dividend/ divisor);
	}

	//  Uses Taylor series
	static method Ln (real r)->real {
		real sum= 0.0;
		real e= 1.648721; // Math.Sqrt(Math.E)== 1.64872127070012814685;
		real b= 0.0;
		while (r>= Math.E) {
			r/= Math.E;
			sum+= 1.0;
		}
		if (r>= e) {
			r/= e;
			sum+= 0.5;
		}
		e= 1.0;
		r-= 1.0;
		b= r;
		while (e<= 5.0) {
			sum+= r/e;
			e+= 1.0;
			r*= b* (-1.0);
		}
		return sum;
	}
}
