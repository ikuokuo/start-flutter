// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OptionStore on OptionBase, Store {
  late final _$bboxesVisibleAtom =
      Atom(name: 'OptionBase.bboxesVisible', context: context);

  @override
  bool get bboxesVisible {
    _$bboxesVisibleAtom.reportRead();
    return super.bboxesVisible;
  }

  @override
  set bboxesVisible(bool value) {
    _$bboxesVisibleAtom.reportWrite(value, super.bboxesVisible, () {
      super.bboxesVisible = value;
    });
  }

  late final _$OptionBaseActionController =
      ActionController(name: 'OptionBase', context: context);

  @override
  void setBboxesVisible(bool visible) {
    final _$actionInfo = _$OptionBaseActionController.startAction(
        name: 'OptionBase.setBboxesVisible');
    try {
      return super.setBboxesVisible(visible);
    } finally {
      _$OptionBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showBboxes() {
    final _$actionInfo =
        _$OptionBaseActionController.startAction(name: 'OptionBase.showBboxes');
    try {
      return super.showBboxes();
    } finally {
      _$OptionBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void hideBboxes() {
    final _$actionInfo =
        _$OptionBaseActionController.startAction(name: 'OptionBase.hideBboxes');
    try {
      return super.hideBboxes();
    } finally {
      _$OptionBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bboxesVisible: ${bboxesVisible}
    ''';
  }
}
