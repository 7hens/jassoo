public struct String {
	string Data;
	static method create (string value)->String {
		String this= String.allocate();
		this.Data= value;
		return this;
	}
	static method operator [] (string value)->String {return String.create(value);}

	method operator Length ()->integer {return StringLength(this.Data);}
	method operator HashCode ()->integer {return StringHash(this.Data);}
	method operator [] (integer index)->string {return StringUtil.CharAt(this.Data, index);}
	method operator []= (integer index, string value) {
		integer strLen= StringLength(this.Data);
		if (index< 0)
			index= strLen+ index;
		if (index> strLen&& index< 0) return;
		if (index== strLen)
			this.Data+= value;
		else
			this.Data= StringUtil.SubStr(this.Data, index)+ value+ StringUtil.SubStr(this.Data, index+ 1- strLen);
	}
	method Contains (string pattern)->boolean {return StringUtil.IndexOf(this.Data, pattern)!= -1;}
	method StartsWith (string pattern)->boolean {return StringUtil.StartsWith(this.Data, pattern);}
	method EndsWith (string pattern)->boolean {return StringUtil.EndsWith(this.Data, pattern);}
	method Compare (string str)->integer {return StringUtil.Compare(this.Data, str);}
	method IndexOf (string sub)->integer {return StringUtil.IndexOf(this.Data, sub);}
	method CharAt (integer index)->string {return StringUtil.CharAt(this.Data, index);}
	method SubString (integer begin, integer length)->string {return StringUtil.SubString(this.Data, begin, length);}
	method SubStr (integer length)->string {return StringUtil.SubStr(this.Data, length);}

	method Render (Argb color)->string {return this.setData(StringUtil.Render(this.Data, color));}
	method Replace (string old, string new)->string {return this.setData(StringUtil.Replace(this.Data, old, new));}
	method LastReplace (string old, string new)->string {return this.setData(StringUtil.LastReplace(this.Data, old, new));}
	method ReplaceAll (string old, string new)->string {return this.setData(StringUtil.Replace(this.Data, old, new));}
	method ToLowerCase ()->string {return this.setData(StringUtil.ToLowerCase(this.Data));}
	method ToUpperCase ()->string {return this.setData(StringUtil.ToUpperCase(this.Data));}
	method Trim (string str)->string {return this.setData(StringUtil.Trim(this.Data));}
	method Reverse ()->string {return this.setData(StringUtil.Reverse(this.Data));}
	private method setData (string value)->string {this.Data= value; return value;}
}
