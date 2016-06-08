private  {
	function i2R (integer i)->real {return I2R(i);}
	function i2S (integer i)->string {return I2S(i);}
	function r2I (real r)->integer {return R2I(r);}
	function r2S (real r)->string {return R2S(r);}
	function s2I (string s)->integer {return S2I(s);}
	function s2R (string s)->real {return S2R(s);}
}

public struct Convert {
	// Valid chars: 32~126 (Total 95) 128 €
	// !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
	//
	// Valid escaped character: \\  \"  \b  \t  \n  \f  \r
	private static constant string charSet= " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
	private static constant string charSet64= "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/";

	static method S2Id (string s)->integer {
		string charSet= Convert.charSet;
		integer strLength= StringLength(s);
		integer result= 0, char= 0, i= 0;
		for (0<= i< strLength) {
			char= StringUtil.IndexOf(charSet, SubString(s, i, i+ 1));
			debug Log.Assert(char>= 0, "Convert.S2Id", "The converted char is not between 32 &&  126!");
			result+= (char+ 32)* R2I(Math.Power(256.0, strLength- i- 1));
		}
		return result;
	}
	static method Id2S (integer id)->string {
		string charSet= Convert.charSet;
		string result= "";
		integer modulo= 0;
		while (id> 0) {
			modulo= R2I(Math.Modulo(id, 256.0));
			if (modulo< 32 || modulo> 126) {
				debug Log.Warn("Convert.Id2S", "The modulo("+ I2S(modulo)+ ") is not in [32, 126]");
				result+= "€";
			}
			result+= SubString(charSet, modulo- 32, modulo- 31);
			id/= 256;
		}
		return result;
	}

	static method S2Int (string s, integer base)->integer {
		string charSet= SubString(Convert.charSet64, 0, base);
		integer strLength= StringLength(s);
		integer result= 0;
		integer sign= 1;
		integer begin= 0;
		integer char= 0;
        debug Log.Assert(base > 1 && base <= 64, "Convert.S2Int", "The base("+ I2S(base)+ ") must be in [2, 64]!");
		if (SubString(s, 0, 1)== "-") {
			sign= -1;
			begin= 1;
		}
		while (begin< strLength) {
			char= StringUtil.IndexOf(charSet, SubString(s, begin, begin+ 1));
            debug Log.Assert(char >= 0, "Convert.S2Int", "Try to convert '"+ s+ "' as base("+ I2S(base)+ ")!");
			begin= begin+ 1;
			result= result+ char* R2I(Math.Power(base, strLength- begin));
		}
		return result* sign;
	}
	static method Int2S (integer i, integer base)->string {
		string charSet= SubString(Convert.charSet64, 0, base);
		string result= "";
		integer modulo= 0;
        debug Log.Assert(base > 1 && base <= 64, "Convert.Int2S", "The base("+ I2S(base)+ ") must be in [2, 64]!");
		if (i< 0) {
			result= "-";
			i= -i;
		} else if (i== 0) {
			return "0";
		}
		while (i> 0) {
			modulo= R2I(Math.Modulo(i, base));
			result= result+ SubString(charSet, modulo, modulo+ 1);
			i = i/ base;
		}
		return result;
	}
	// Don't set the @para count too large beacause of the Jass Decimal precision of less than 6 digits
	static method Real2S (real r, integer count)->string {
		string result= "";
		string str;
		integer strLen, i;
		if (count> 3) {
			count-= 3;
			result= R2S(Math.Floor(r* 1000)/ 1000);
			str= StringUtil.Replace(R2S(r* Math.Power(10, count)), ".", "");
			strLen= StringLength(str);
			for (strLen<= i< count)
				str= "0"+ str;
			return result+ StringUtil.SubStr(str, -count);
		} else if (count>= 0) {
			result= R2S(r);
			return StringUtil.SubStr(result, StringLength(result)+ count- 3);
		}
		debug Log.Error("Convert.Real2S", "the decimal digits("+ I2S(count) +") is lower than zero!");
		return "";
	}

    static method B2I (boolean b)->integer {if (b) return 1; return 0;}
    static method B2R (boolean b)->real {if (b) return 1.0; return 0.0;}
    static method B2S (boolean b)->string {if (b) return "true"; return "false";}
	
    static method I2B (integer i)->boolean {return i!= 0;}
    static method I2R (integer i)->real {return i2R(i);}
    static method I2S (integer i)->string {return i2S(i);}
	
    static method R2B (real r)->boolean {return r!= 0.0;}
    static method R2I (real r)->integer {return r2I(r);}
    static method R2S (real r)->string {return r2S(r);}
	
    static method S2B (string s)->boolean {return s!= "";}
    static method S2I (string s)->integer {return s2I(s);}
    static method S2R (string s)->real {return s2R(s);}
}
