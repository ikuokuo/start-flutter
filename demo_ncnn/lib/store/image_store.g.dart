// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ImageStore on ImageBase, Store {
  late final _$loadFutureAtom =
      Atom(name: 'ImageBase.loadFuture', context: context);

  @override
  FutureStore<ImageData> get loadFuture {
    _$loadFutureAtom.reportRead();
    return super.loadFuture;
  }

  @override
  set loadFuture(FutureStore<ImageData> value) {
    _$loadFutureAtom.reportWrite(value, super.loadFuture, () {
      super.loadFuture = value;
    });
  }

  late final _$loadAsyncAction =
      AsyncAction('ImageBase.load', context: context);

  @override
  Future<dynamic> load({String? imagePath}) {
    return _$loadAsyncAction.run(() => super.load(imagePath: imagePath));
  }

  @override
  String toString() {
    return '''
loadFuture: ${loadFuture}
    ''';
  }
}
