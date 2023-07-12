// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FutureStore<T> on FutureBase<T>, Store {
  Computed<FutureState>? _$futureStateComputed;

  @override
  FutureState get futureState =>
      (_$futureStateComputed ??= Computed<FutureState>(() => super.futureState,
              name: 'FutureBase.futureState'))
          .value;

  late final _$errorMessageAtom =
      Atom(name: 'FutureBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$futureAtom = Atom(name: 'FutureBase.future', context: context);

  @override
  ObservableFuture<dynamic>? get future {
    _$futureAtom.reportRead();
    return super.future;
  }

  @override
  set future(ObservableFuture<dynamic>? value) {
    _$futureAtom.reportWrite(value, super.future, () {
      super.future = value;
    });
  }

  late final _$dataAtom = Atom(name: 'FutureBase.data', context: context);

  @override
  T? get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(T? value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$FutureBaseActionController =
      ActionController(name: 'FutureBase', context: context);

  @override
  void reset() {
    final _$actionInfo =
        _$FutureBaseActionController.startAction(name: 'FutureBase.reset');
    try {
      return super.reset();
    } finally {
      _$FutureBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
future: ${future},
data: ${data},
futureState: ${futureState}
    ''';
  }
}
