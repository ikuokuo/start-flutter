import 'package:mobx/mobx.dart';

import '../util/image.dart';
import 'future_store.dart';

part 'image_store.g.dart';

class ImageStore = ImageBase with _$ImageStore;

abstract class ImageBase with Store {
  @observable
  FutureStore<ImageData> loadFuture = FutureStore<ImageData>();

  @action
  Future load({String? imagePath}) async {
    try {
      loadFuture.errorMessage = null;

      loadFuture.future = ObservableFuture(loadImage(imagePath));

      loadFuture.data = await loadFuture.future;
    } catch (e) {
      loadFuture.errorMessage = e.toString();
    }
  }
}
