public struct Quest {
	private quest h;
    private string iconPath;
    private string title;
    private string description;
    
	static method create (string iconPath, string title, string description)->thistype {
		thistype this = thistype.allocate();
		this.h = CreateQuest();
        this.IconPath = iconPath;
        this.Title = title;
        this.Description = description;
		Utils.PutInteger(this.HandleId, this);
		return this;
	}
    
	method destroy () {
		Utils.FlushInteger(this.HandleId);
		DestroyQuest(this.h);
		this.h = null;
		this.deallocate();
	}
    
	method operator Handle ()->quest { return this.h; }
	method operator HandleId ()->integer { return GetHandleId(this.h); }
    
    method operator IconPath ()->string { return this.iconPath; }
	method operator IconPath= (string path) {
        this.iconPath = path;
        QuestSetIconPath(this.h, path);
    }
    
    method operator Title ()->string { return this.title; }
	method operator Title= (string title) {
        this.title = title;
        QuestSetTitle(this.h, title);
    }
    
    method operator Description ()->string { return this.description; }
	method operator Description= (string description) {
        this.description = description;
        QuestSetDescription(this.h, description);
    }
    
	method operator Completed ()->boolean { return IsQuestCompleted(this.h); }
	method operator Completed= (boolean completed) { QuestSetCompleted(this.h, completed); }
	method operator Discovered ()->boolean { return IsQuestDiscovered(this.h); }
	method operator Discovered= (boolean discovered) { QuestSetDiscovered(this.h, discovered); }
	method operator Enabled ()->boolean { return IsQuestEnabled(this.h); }
	method operator Enabled= (boolean enabled) { QuestSetEnabled(this.h, enabled); }
	method operator Failed ()->boolean { return IsQuestFailed(this.h); }
	method operator Failed= (boolean failed) { QuestSetFailed(this.h, failed); }
	method operator Required ()->boolean { return IsQuestRequired(this.h); }
	method operator Required= (boolean required) { QuestSetRequired(this.h, required); }
}
