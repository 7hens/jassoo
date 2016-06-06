public interface IWidget {
	method operator HandleId ()->integer= 0;
    method operator TypeId ()->integer= 0;
    method operator Visible ()->boolean= false;
    method operator Visible= (boolean visible)= null;
    method operator Invulnerable ()->boolean= false;
    method operator Invulnerable= (boolean invulnerable)= null;
	method operator UserData ()->integer= 0;
	method operator UserData= (integer userData)= null;
    method operator Level ()->integer= 0;
    method operator Level= (integer level)= null;
    method operator Alive ()->boolean= false;
    method operator HP ()->real= 0;
    method operator HP= (real hp)= null;
    method operator MaxHP ()->real= 0;
    method operator MaxHP= (real maxHp)= null;
    method operator Name ()->string= "";
    method operator X ()->real= 0;
    method operator X= (real x)= null;
    method operator Y ()->real= 0;
    method operator Y= (real y)= null;
    method operator Z ()->real= 0;
    method operator Z= (real z)= null;
    method operator FlyHeight ()->real= 0;
    method operator FlyHeight= (real height)= null;
    method operator Face ()->real= 0;
    method operator Face= (real face)= null;
    method operator Player ()->GamePlayer= 0;
    method operator Player= (GamePlayer plr)= null;
	method SetColor (Argb color)= null;
	method SetPosition (Point pos)= null;
	method ResetXY (real x, real y)->Point= 0;
	method ResetPoint ()->Point= 0;
	method BindPoint ()->Point= 0;
    method GetShiftedPoint (Point offset, boolean relative)->Point= 0;
	method Animate (string animation)= null;
	method AnimateLater (string animation)= null;
    method AddEffect (string path, string attachPoint, real duration)->Timer= 0;
}
private module widgetModule {
	method operator HandleId ()->integer {return GetHandleId(this.h);}
    method operator X ()->real {return GetWidgetX(this.h);}
    method operator Y ()->real {return GetWidgetY(this.h);}
    method operator Z ()->real {return this.FlyHeight+ this.TerrainZ;}
    method operator HP ()->real {return GetWidgetLife(this.h);}
    method operator HP= (real value) {SetWidgetLife(this.h, value);}
    method operator Alive ()->boolean {return GetWidgetLife(this.h)> 0.0;}
    method SetColor (Argb color) { AddIndicator(this.h, color.R, color.G, color.B, color.A);}

    method GetShiftedPoint (Point offsetPoint, boolean relative)->Point {
        Point pos= Point.create();
        real face= this.Face;
        real x= offsetPoint.X;
        real y= offsetPoint.Y;
        if (!relative)
            return pos.Reset(this.X+ x, this.Y+ y);
        return pos.Reset(x*Cos(face)- y*Sin(face)+ this.X, x*Sin(face)+ y*Cos(face)+ this.Y);
    }
	method ResetXY (real x, real y)->Point {this.Point.Reset(x, y); return this.BindPoint();}
	method ResetPoint ()->Point {return this.Point.Reset(GetWidgetX(this.h), GetWidgetY(this.h));}
	method SetPosition (Point pos) {this.Point.Copy(pos); this.BindPoint();}

    method AddEffect (string path ,string attachPoint ,real duration)->Timer {
        return Game.TimedEffect(AddSpecialEffectTarget(path ,this.h ,attachPoint), duration);
    }
}
