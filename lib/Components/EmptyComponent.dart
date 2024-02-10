import 'package:flame/components.dart';

class EmptyComponent extends PositionComponent{
    EmptyComponent();

    @override
    Future<void> onLoad() async {
      super.onLoad();
      removeFromParent();

    }


}