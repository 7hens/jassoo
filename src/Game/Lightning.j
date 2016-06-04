public struct Lightning {
	private lightning h;
	private delegate Line3 Line3;
	private boolean checkVisibility= false;
	private integer lightningType;
	private Argb color= Argb.White;

	static method create (integer i, Vector3 p, Vector3 q)->Lightning {
		Lightning this= Line3.create();
		this.Line3= this;
		this.Line3.Reset(p, q);
		this.h= AddLightningEx(Lightning.getCodeName(i), false, p.X, p.Y, p.Z, q.X, q.Y, q.Z);
		this.lightningType= i;
		Game.SaveInt(this.HashCode, this);
		return this;
	}
	method destroy () {
		Game.FlushInt(this.HashCode);
		DestroyLightning(this.h);
		this.h= null;
		this.Line3.destroy();
	}

	method operator Handle ()->lightning {return this.h;}
	method operator HashCode ()->integer {return GetHandleId(this.h);}
	method operator Color ()->Argb {return this.color;}
	method operator Color= (Argb value) {
		this.color= value;
		SetLightningColor(this.h, value.R, value.G, value.B, value.A);
	}
	method operator CheckVisibility ()->boolean {return this.checkVisibility;}
	method operator CheckVisibility= (boolean value) {
		this.checkVisibility= value;
		this.BindLine();
	}
	method operator LightningType ()->integer {return this.lightningType;}
	method operator LightningType= (integer value) {
		Vector3 p= this.Line3.Start;
		Vector3 q= this.Line3.End;
		Argb color= this.color;
		if (this.lightningType== value) return;
		this.lightningType= value;
		Game.FlushInt(this.HashCode);
		DestroyLightning(this.h);
		this.h= AddLightningEx(Lightning.getCodeName(value), this.checkVisibility, p.X, p.Y, p.Z, q.X, q.Y, q.Z);
		Game.SaveInt(this.HashCode, this);
		SetLightningColor(this.h, color.R, color.G, color.B, color.A);
	}

	method BindLine ()->Line3 {
		Vector3 start= this.Line3.Start;
		Vector3 end= this.Line3.End;
		MoveLightningEx(this.h, this.checkVisibility, start.X, start.Y, start.Z, end.X, end.Y, end.Z);
		return this.Line3;
	}
	method MoveTo (Vector3 start, Vector3 end)->Lightning {
		this.Line3.Reset(start, end);
		this.BindLine();
		return this;
	}

	private static method getCodeName (integer i)->string {
		if (i== 0) return "CLPB"; 		//闪电链-主
		else if (i== 1) return "CLSB";  //闪电链-次
		else if (i== 2) return "DRAB";  //汲取
		else if (i== 3) return "DRAL";  //生命汲取
		else if (i== 4) return "DRAM";  //魔法汲取
		else if (i== 5) return "AFOD";  //死亡之指
		else if (i== 6) return "FORK";  //叉状闪电
		else if (i== 7) return "HWPB";  //医疗波-主
		else if (i== 8) return "HWSB";  //医疗波-次
		else if (i== 9) return "CHIM";  //闪电攻击
		else if (i== 10) return "LEAS"; //魔法镣铐
		else if (i== 11) return "MBUR"; //法力燃烧
		else if (i== 12) return "MFPB"; //魔力之焰
		else if (i== 13) return "SPLK"; //灵魂锁链
		Console.Error("[Lightning.getCodeName] the given lightningType("+ I2S(i)+ ") must be in [0, 13].");
		return "";
	}
}
