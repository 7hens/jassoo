public struct Quest {
	private quest h;
	static method create ()->thistype {
		Quest this= Quest.allocate();
		this.h= CreateQuest();
		Game.PutInteger(this.HashCode, this);
		return this;
	}
	method destroy () {
		Game.FlushInteger(this.HashCode);
		DestroyQuest(this.h);
		this.h= null;
		this.deallocate();
	}
	method operator Handle ()->quest {return this.h;}
	method operator HashCode ()->integer {return GetHandleId(this.h);}
	method operator IconPath= (string path) {QuestSetIconPath(this.h, path);}
	method operator Title= (string title) {QuestSetTitle(this.h, title);}
	method operator Text= (string text) {QuestSetDescription(this.h, text);}
	method operator Completed ()->boolean {return IsQuestCompleted(this.h);}
	method operator Completed= (boolean completed) {QuestSetCompleted(this.h, completed);}
	method operator Discovered ()->boolean {return IsQuestDiscovered(this.h);}
	method operator Discovered= (boolean discovered) {QuestSetDiscovered(this.h, discovered);}
	method operator Enabled ()->boolean {return IsQuestEnabled(this.h);}
	method operator Enabled= (boolean enabled) {QuestSetEnabled(this.h, enabled);}
	method operator Failed ()->boolean {return IsQuestFailed(this.h);}
	method operator Failed= (boolean failed) {QuestSetFailed(this.h, failed);}
	method operator Required ()->boolean {return IsQuestRequired(this.h);}
	method operator Required= (boolean required) {QuestSetRequired(this.h, required);}
}
