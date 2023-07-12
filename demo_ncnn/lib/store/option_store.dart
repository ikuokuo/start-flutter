import 'package:mobx/mobx.dart';

part 'option_store.g.dart';

class OptionStore = OptionBase with _$OptionStore;

abstract class OptionBase with Store {
  @observable
  bool bboxesVisible = true;

  @action
  void setBboxesVisible(bool visible) {
    bboxesVisible = visible;
  }

  @action
  void showBboxes() {
    bboxesVisible = true;
  }

  @action
  void hideBboxes() {
    bboxesVisible = false;
  }
}
