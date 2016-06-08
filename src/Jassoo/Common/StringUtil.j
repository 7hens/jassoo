//! no confliction!
private function subString (string source, integer start, integer end)->string {
	return SubString(source, start, end);
}

public struct StringUtil {
	static method Render (string str, Argb color)->string {return "|c"+ color.ToString()+ str+ "|r";}
	static method Hash (string str)->integer {return StringHash(str);}
	static method Length (string str)->integer {return StringLength(str);}

	static method Contains (string str, string pattern)->boolean {
		return StringUtil.IndexOf(str, pattern)!= -1;
	}
	static method StartsWith (string str, string pattern)->boolean {
		integer thisLen= StringLength(str);
		integer patternLen= StringLength(pattern);
		if (thisLen< patternLen|| patternLen== 0)
			return false;
		return subString(str, 0, patternLen)== pattern;
	}
	static method EndsWith (string str, string pattern)->boolean {
		integer thisLen= StringLength(str);
		integer patternLen= StringLength(pattern);
		if (thisLen< patternLen|| patternLen== 0)
			return false;
		return subString(str, thisLen- patternLen, thisLen)== pattern;
	}

	static method Compare (string str, string str2)->integer {
		integer strLen= StringLength(str);
		integer strLen2= StringLength(str2);
		integer minLen= IMinBJ(strLen, strLen2);
		integer i= 0;
		integer char= 0;
		integer char2= 0;
		if (str== str2) {
			return 0;
		}
		for (0<= i< minLen) {
			char= Convert.S2Id(StringUtil.CharAt(str, i));
			char2= Convert.S2Id(StringUtil.CharAt(str2, i));
			if (char!= char2) {
				return char- char2;
			}
		}
		return 0;
	}

	static method IndexOf (string str, string sub)->integer {
		integer strLen= StringLength(str);
		integer subLen= StringLength(sub);
		integer i= 0;
		if (strLen>= subLen&& subLen> 0) {
			for (i=0; i<= strLen- subLen; i+= 1) {
				if (sub== StringUtil.SubString(str, i, subLen))
					return i;
			}
		}
		return -1;
	}
	static method LastIndexOf (string str, string sub)->integer {
		integer strLen= StringLength(str);
		integer subLen= StringLength(sub);
		integer i= 0;
		if (strLen>= subLen&& subLen> 0) {
			for (i= strLen- subLen; i>= 0; i-= 1) {
				if (sub== StringUtil.SubString(str, i, subLen))
					return i;
			}
		}
		return -1;
	}
	static method CharAt (string str, integer index)->string {
		if (index< 0)
			index= StringLength(str)+ index;
		return subString(str, index, index+ 1);
	}

	static method Slice (string str, integer begin, integer end)->string {
		return subString(str, begin, end);
	}
	static method SubString (string str, integer begin, integer length)->string {
		return subString(str, begin, begin+ length);
	}

	static method SubStr (string str, integer length)->string {
		integer strLen= StringLength(str);
		if (length> strLen || length< -strLen) {
			debug Log.Error("StringUtil.SubStr", "the length("+ I2S(length)+ ") is out of range(\""+ str+ "\")!");
			return str;
		}
		if (length>= 0)
			return StringUtil.SubString(str, 0, length);
		return StringUtil.SubString(str, strLen+ length, -length);
	}

	static method Replace (string str, string old, string new)->string {
		integer i= StringUtil.IndexOf(str, old);
		if (i!= -1)
			return StringUtil.SubStr(str, i)+ new+ StringUtil.SubStr(str, i+ StringLength(old)- StringLength(str));
		return str;
	}
	static method LastReplace (string str, string old, string new)->string {
		integer i= StringUtil.LastIndexOf(str, old);
		if (i!= -1)
			return StringUtil.SubStr(str, i)+ new+ StringUtil.SubStr(str, i+ StringLength(old)- StringLength(str));
		return str;
	}
	static method ReplaceAll (string str, string old, string new)->string {
		integer i= StringUtil.IndexOf(str, old);
		while (i!= -1) {
			str= StringUtil.SubStr(str, i)+ new+ StringUtil.SubStr(str, i+ StringLength(old)- StringLength(str));
			i= StringUtil.IndexOf(str, old);
		}
		return str;
	}

	static method ToLowerCase (string str)->string {
		string result= "";
		integer strLen= StringLength(str);
		integer char= 0;
		integer i= 0;
		for (0<= i< strLen) {
			char= Convert.S2Id(StringUtil.CharAt(str, i));
			if (char> 64 &&  char< 91)
				char+= 32;
			result+= Convert.Id2S(char);
		}
		return result;
	}

	static method ToUpperCase (string str)->string {
		string result= "";
		integer strLen= StringLength(str);
		integer char= 0;
		integer i= 0;
		for (0<= i< strLen) {
			char= Convert.S2Id(StringUtil.CharAt(str, i));
			if (char> 96 &&  char< 123)
				char-= 32;
			result+= Convert.Id2S(char);
		}
		return result;
	}

	static method Reverse (string str)->string {
		string result= "";
		integer strLen= StringLength(str);
		integer i= 0;
		for (strLen>= i> 0) {
			result+= StringUtil.CharAt(str, i- 1);
		}
		return result;
	}

	static method Trim (string str)->string {
		integer begin= 0;
		integer end= StringLength(str);
		string char= "";
		if (str== "")
			return "";
		char= subString(str, 0, 1);
		while (char== " " || char== "\t" || char== "\n") {
			begin+= 1;
			char= StringUtil.CharAt(str, begin);
		}
		char= subString(str, end- 1, end);
		while (char== " " || char== "\t" || char== "\n") {
			end-= 1;
			char= StringUtil.CharAt(str, end- 1);
		}
		return subString(str, begin, end);
	}
	// Split("a,,b, c", ","); //--["a", "", "b", " c"]
	// Split("ab, c, \nd", ", \n"); //--["ab", "c", "d"]
	static method Split (string str, string delimiters)->StringArray {
		StringArray result = StringArray.create();
		integer strLen = StringLength(str);
		integer delimLen = StringLength(delimiters);
		integer i=0, j=0, prev=0;
		if (str == "") return result;
		if (delimLen == 0) {
			for (0 <= i < strLen)
				result[i] = StringUtil.CharAt(str, i);
			return result;
		}
		for (0 <= i < strLen) {
			if (StringUtil.Contains(delimiters, subString(str, i, i + 1))) {
				result[j] = subString(str, prev, i);
				j += 1;
				prev = i+ 1;
			}
		}
        result[j]= subString(str, prev, strLen);
		return result;
	}
	// It will cause a bug, if you set @para separator as "|"
	static method Join (StringArray arr, string separator)->string {
		string result= "";
		integer i;
        for (1 <= i < arr.Size) {
			result += separator + arr[i];
        }
		return arr[0]+ result;
	}
}
