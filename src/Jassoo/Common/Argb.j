public struct Argb extends array {
	static thistype Red= 0xFFFF0303;
	static thistype Orange= 0xFFFE8A0E;
	static thistype Yellow= 0xFFFFFC01;
	static thistype Green= 0xFF20C000;
	static thistype Cyan= 0xFF1CE6B9;
	static thistype Blue= 0xFF0042FF;
	static thistype Purple= 0xFF540081;
	static thistype White= 0xFFFFFFFF;
	static thistype Black= 0xFF000000;

	static method create (integer a, integer r, integer g, integer b)->thistype {
		return b+ g* 0x100+ r* 0x10000+ a* 0x1000000;
	}

	// Alpha
	method operator A ()->integer {
		if (integer(this)< 0)
			return 0x80+(-(-integer(this)+0x80000000))/0x1000000;
		return (integer(this))/0x1000000;
	}
	method operator A= (integer alpha)->thistype {
		integer a= 0, r= 0, g= 0, b= 0;
		integer col= integer(this);
		if (col< 0) {
			col= -(-col+ 0x80000000);
			a= 0x80+ col/ 0x1000000;
			col= col- (a- 0x80)* 0x1000000;
		} else {
			a= col/ 0x1000000;
			col= col- a* 0x1000000;
		}
		r= col/ 0x10000;
		col= col- r* 0x10000;
		g= col/ 0x100;
		b= col- g* 0x100;
		return thistype(b+ g* 0x100+ r* 0x10000+ alpha* 0x1000000);
	}
	// Red
	method operator R ()->integer {
		integer c= integer(this)* 0x100;
		if (c< 0)
			return 0x80+ (-(-c+ 0x80000000))/ 0x1000000;
		return c/ 0x1000000;
	}
	method operator R= (integer red)->thistype {
		integer a= 0, r= 0, g= 0, b= 0;
		integer col= integer(this);
		if (col< 0) {
			col= -(-col+ 0x80000000);
			a= 0x80+ col/ 0x1000000;
			col= col- (a- 0x80)* 0x1000000;
		} else {
			a= col/ 0x1000000;
			col= col- a* 0x1000000;
		}
		r= col/ 0x10000;
		col= col- r* 0x10000;
		g= col/ 0x100;
		b= col- g* 0x100;
		return thistype(b+ g* 0x100+ red* 0x10000+ a* 0x1000000);
	}
	// Green
	method operator G ()->integer {
		integer c= integer(this)* 0x10000;
		if (c< 0)
			return 0x80+ (-(-c+ 0x80000000))/ 0x1000000;
		return c/ 0x1000000;
	}
	method operator G= (integer green)->thistype {
		integer a= 0, r= 0, g= 0, b= 0;
		integer col= integer(this);
		if (col< 0) {
			col= -(-col+ 0x80000000);
			a= 0x80+ col/ 0x1000000;
			col= col- (a- 0x80)* 0x1000000;
		} else {
			a= col/ 0x1000000;
			col= col- a* 0x1000000;
		}
		r= col/ 0x10000;
		col= col- r* 0x10000;
		g= col/ 0x100;
		b= col- g* 0x100;
		return thistype(b+ green* 0x100+ r* 0x10000+ a* 0x1000000);
	}
	// Blue
	method operator B ()->integer {
		integer c= integer(this)* 0x1000000;
		if (c< 0)
			return 0x80+ (-(-c+ 0x80000000))/ 0x1000000;
		return c/ 0x1000000;
	}
	method operator B= (integer blue)->thistype {
		integer a= 0, r= 0, g= 0, b= 0;
		integer col= integer(this);
		if (col< 0) {
			col= -(-col+ 0x80000000);
			a= 0x80+ col/ 0x1000000;
			col= col- (a- 0x80)* 0x1000000;
		} else {
			a= col/ 0x1000000;
			col= col- a* 0x1000000;
		}
		r= col/ 0x10000;
		col= col- r* 0x10000;
		g= col/ 0x100;
		b= col- g* 0x100;
		return thistype(blue+ g* 0x100+ r* 0x10000+ a* 0x1000000);
	}

	//  Mixes two colors, s would be a number 0<=s<=1 that determines
	//  the weight given to color c2.
	//
	//  Mix(c1,c2,0)   = c1
	//  Mix(c1,c2,1)   = c2
	//  Mix(c1,c2,0.5) = Mixing the colors c1 &&  c2 in equal proportions.
	static method Mix (thistype one, thistype other, real ratio)->thistype {
		return thistype(R2I(other.B* ratio+ one.B* (1- ratio)+ 0.5)+
			R2I(other.G* ratio+ one.G* (1- ratio)+ 0.5)* 0x100+
			R2I(other.R* ratio+ one.R* (1- ratio)+ 0.5)* 0x10000+
			R2I(other.A* ratio+ one.A* (1- ratio)+ 0.5)* 0x1000000
		);
	}

	method ToString ()->string {
		string result= "";
		integer arr[];
		integer i;
		arr[0]= this.A;
		arr[1]= this.R;
		arr[2]= this.G;
		arr[3]= this.B;
		for (0<= i< 4) {
			if (arr[i]< 16)
				result+= "0";
			result+= Convert.Int2S(arr[i], 16);
		}
		return result;
	}
}
