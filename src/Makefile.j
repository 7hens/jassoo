library Common {
	//! import "src/Common/Basic.j"
	//! import "src/Common/Log.j"
	//! import "src/Common/Math.j"
	//! import "src/Common/StringUtil.j"
	//! import "src/Common/Convert.j"
	//! import "src/Common/Argb.j"
	//! import "src/Common/Vector2.j"
	//! import "src/Common/Vector3.j"
	//! import "src/Common/Line2.j"
	//! import "src/Common/Line3.j"
}

library Collections requires Common {
	//! import "src/Collections/Node.j"
	//! import "src/Collections/List.j"
	//! import "src/Collections/Tree.j"
	//! import "src/Collections/HashTable.j"
	//! import "src/Collections/RootTable.j"
	//! import "src/Collections/_Table.j"
}

library Wrapper requires Common {
	//! import "src/Wrapper/Bool.j"
	//! import "src/Wrapper/Real.j"
	//! import "src/Wrapper/String.j"
}

library Game requires Collections {
	//! import "src/Game/Console.j"
	//! import "src/Game/Timer.j"
	//! import "src/Game/Event.j"
	//! import "src/Game/Region.j"
	//! import "src/Game/Game.j"
	//! import "src/Game/Point.j"
	//! import "src/Game/Group.j"
	//! import "src/Game/GamePlayer.j"
	//! import "src/Game/Lightning.j"
	//! import "src/Game/TextTag.j"
	//! import "src/Game/Quest.j"
	//! import "src/Game/Dialog.j"
	//! import "src/Game/Multiboard.j"
	//! import "src/Game/Camera.j"
	//! import "src/Game/Image.j"
	//! import "src/Game/Sound.j"
	//! import "src/Game/IWidget.j"
	//! import "src/Game/Destruct.j"
	//! import "src/Game/Item.j"
	//! import "src/Game/Unit.j"
}

library Test requires Wrapper {
	//! import "src/Test/Test.j"
	//! import "src/Test/Zinc.j"
}
