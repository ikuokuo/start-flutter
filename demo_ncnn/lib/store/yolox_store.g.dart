// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yolox_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$YoloxStore on YoloxBase, Store {
  late final _$detectFutureAtom =
      Atom(name: 'YoloxBase.detectFuture', context: context);

  @override
  FutureStore<YoloxResult> get detectFuture {
    _$detectFutureAtom.reportRead();
    return super.detectFuture;
  }

  @override
  set detectFuture(FutureStore<YoloxResult> value) {
    _$detectFutureAtom.reportWrite(value, super.detectFuture, () {
      super.detectFuture = value;
    });
  }

  late final _$detectAsyncAction =
      AsyncAction('YoloxBase.detect', context: context);

  @override
  Future<dynamic> detect(ImageData data) {
    return _$detectAsyncAction.run(() => super.detect(data));
  }

  @override
  String toString() {
    return '''
detectFuture: ${detectFuture}
    ''';
  }
}
