library Common {
	//! import "src/System/Common/Basic.j"
	//! import "src/System/Common/Math.j"
	//! import "src/System/Common/StringUtil.j"
	//! import "src/System/Common/Convert.j"
	//! import "src/System/Common/Argb.j"
	//! import "src/System/Common/Vector2.j"
	//! import "src/System/Common/Vector3.j"
	//! import "src/System/Common/Line2.j"
	//! import "src/System/Common/Line3.j"
}

library Collections requires Common {
	//! import "src/System/Collections/Node.j"
	//! import "src/System/Collections/List.j"
	//! import "src/System/Collections/Tree.j"
	//! import "src/System/Collections/Table.j"
}

library Wrapper requires Common {
	//! import "src/System/Wrapper/Bool.j"
	//! import "src/System/Wrapper/Real.j"
	//! import "src/System/Wrapper/String.j"
}

library Game requires Collections {
	//! import "src/System/Game/Console.j"
	//! import "src/System/Game/Timer.j"
	//! import "src/System/Game/Event.j"
	//! import "src/System/Game/Region.j"
	//! import "src/System/Game/Game.j"
	//! import "src/System/Game/Point.j"
	//! import "src/System/Game/Group.j"
	//! import "src/System/Game/GamePlayer.j"
	//! import "src/System/Game/Lightning.j"
	//! import "src/System/Game/TextTag.j"
	//! import "src/System/Game/Quest.j"
	//! import "src/System/Game/Dialog.j"
	//! import "src/System/Game/Multiboard.j"
	//! import "src/System/Game/Camera.j"
	//! import "src/System/Game/Image.j"
	//! import "src/System/Game/Sound.j"
	//! import "src/System/Game/IWidget.j"
	//! import "src/System/Game/Destruct.j"
	//! import "src/System/Game/Item.j"
	//! import "src/System/Game/Unit.j"
}

library Test requires Wrapper {
	//! import "src/System/Test/Test.j"
	//! import "src/System/Test/Zinc.j"
}
