import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///表单验证方式
enum FormValidationMode {
  /// 不启用验证
  disabled,

  /// 自动验证
  auto,

  /// 用户交互时验证
  onUserInteraction,
}

class FormComponent extends StatefulWidget {
  /// 表单的小部件
  final Widget child;

  final bool? canPop;

  final PopInvokedCallback? onPopInvoked;

  /// 当其中一个表单字段更改时调用
  final VoidCallback? onChanged;

  /// 用于启用、禁用表单字段自动验证并更新其错误文本
  final FormValidationMode formValidationMode;

  const FormComponent({
    super.key,
    required this.child,
    this.canPop,
    this.onPopInvoked,
    this.onChanged,
    FormValidationMode? formValidationMode,
  }) : formValidationMode = formValidationMode ?? FormValidationMode.disabled;

  @override
  State<FormComponent> createState() => FormComponentState();

  static FormComponentState? maybeOf(BuildContext context) {
    final _FormComponentScope? scope = context.dependOnInheritedWidgetOfExactType<_FormComponentScope>();
    return scope?._formComponentState;
  }
}

class FormComponentState extends State<FormComponent> {
  bool _hasInteractedByUser = false;

  int _generation = 0;

  @override
  Widget build(BuildContext context) {
    ///根据表单验证模式判断是否调用验证方法
    switch (widget.formValidationMode) {
      case FormValidationMode.auto:
        _validate();
      case FormValidationMode.onUserInteraction:

        ///用户交互时调用验证方法
        if (_hasInteractedByUser) {
          _validate();
        }
      case FormValidationMode.disabled:
        break;
    }
    return _FormComponentScope(
      formComponentState: this,
      generation: _generation,
      child: widget.child,
    );
  }

  final Set<FormFieldComponentState<dynamic>> _fields = <FormFieldComponentState<dynamic>>{};

  // 当表单字段发生更改
  void _fieldDidChange() {
    widget.onChanged?.call();
    _hasInteractedByUser = _fields.any((FormFieldComponentState<dynamic> field) => field._hasInteractedByUser.value);
    _forceRebuild();
  }

  /// 重建
  void _forceRebuild() {
    setState(() {
      ++_generation;
    });
  }

  ///登记，向[_fields]添加字段组价的状态
  void _register(FormFieldComponentState<dynamic> field) {
    _fields.add(field);
  }

  ///卸载，向[_fields]移除字段组价的状态，证明表单不在管理这个字段组件的状态，在组件销毁前调用这个移除
  void _unregister(FormFieldComponentState<dynamic> field) {
    _fields.remove(field);
  }

  /// 保存子
  void save() {
    for (final FormFieldComponentState<dynamic> field in _fields) {
      field.save();
    }
  }

  /// 子重置
  void reset() {
    for (final FormFieldComponentState<dynamic> field in _fields) {
      field.reset();
    }
    _hasInteractedByUser = false;
    _fieldDidChange();
  }

  bool validate() {
    _hasInteractedByUser = true;
    _forceRebuild();
    return _validate();
  }

  Set<FormFieldComponentState<Object?>> validateGranularly() {
    final Set<FormFieldComponentState<Object?>> invalidFields = <FormFieldComponentState<Object?>>{};
    _hasInteractedByUser = true;
    _forceRebuild();
    _validate(invalidFields);
    return invalidFields;
  }

  ///表单验证方法
  ///[invalidFields]无效字段
  bool _validate([Set<FormFieldComponentState<Object?>>? invalidFields]) {
    bool hasError = false;
    String errorMessage = '';

    ///主要通过循环调用字段的[validate]验证方法   判断是否有错误
    for (final FormFieldComponentState<dynamic> field in _fields) {
      final bool isFieldValid = field.validate();
      hasError = !isFieldValid || hasError;
      errorMessage += field.errorText ?? '';
      if (invalidFields != null && !isFieldValid) {
        invalidFields.add(field);
      }
    }

    if (errorMessage.isNotEmpty) {
      final TextDirection directionality = Directionality.of(context);
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        unawaited(Future<void>(() async {
          await Future<void>.delayed(Duration(milliseconds: 500));
          SemanticsService.announce(errorMessage, directionality, assertiveness: Assertiveness.assertive);
        }));
      } else {
        SemanticsService.announce(errorMessage, directionality, assertiveness: Assertiveness.assertive);
      }
    }
    return !hasError;
  }
}

class _FormComponentScope extends InheritedWidget {
  const _FormComponentScope({
    required super.child,
    required FormComponentState formComponentState,
    required int generation,
  })  : _formComponentState = formComponentState,
        _generation = generation;

  final FormComponentState _formComponentState;

  /// 每次更改表单字段时递增。这让我们知道何时重建表单。
  final int _generation;

  /// 与此小部件关联的[Form]。
  FormComponent get form => _formComponentState.widget;

  ///[_generation]值改变就更新通知
  @override
  bool updateShouldNotify(_FormComponentScope old) => _generation != old._generation;
}

typedef FormFieldComponentValidator<T> = String? Function(T? value);

typedef FormFieldComponentSetter<T> = void Function(T? newValue);

typedef FormFieldComponentBuilder<T> = Widget Function(FormFieldComponentState<T> field);

//主要是改变值和设置值
class FormFieldComponent<T> extends StatefulWidget {
  const FormFieldComponent({
    super.key,
    required this.builder,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.enabled = true,
    FormValidationMode? formValidationMode,
    this.restorationId,
  }) : formValidationMode = formValidationMode ?? FormValidationMode.disabled;

  final FormFieldComponentSetter<T>? onSaved;

  final FormFieldComponentValidator<T>? validator;

  final FormFieldComponentBuilder<T> builder;

  final T? initialValue;

  final bool enabled;

  final FormValidationMode formValidationMode;

  final String? restorationId;

  @override
  State<FormFieldComponent<T>> createState() => FormFieldComponentState<T>();
}

class FormFieldComponentState<T> extends State<FormFieldComponent<T>> with RestorationMixin {
  late T? _value = widget.initialValue;

  final RestorableStringN _errorText = RestorableStringN(null);
  final RestorableBool _hasInteractedByUser = RestorableBool(false);

  T? get value => _value;

  String? get errorText => _errorText.value;

  bool get hasError => _errorText.value != null;

  bool get hasInteractedByUser => _hasInteractedByUser.value;

  void save() {
    widget.onSaved?.call(value);
  }

  void reset() {
    setState(() {
      _value = widget.initialValue;
      _hasInteractedByUser.value = false;
      _errorText.value = null;
    });
    FormComponent.maybeOf(context)?._fieldDidChange();
  }

  bool validate() {
    setState(() {
      _validate();
    });
    return !hasError;
  }

  void _validate() {
    if (widget.validator != null) {
      _errorText.value = widget.validator!(_value);
    } else {
      _errorText.value = null;
    }
  }


  void didChange(T? value) {
    setState(() {
      _value = value;
      _hasInteractedByUser.value = true;
    });
    FormComponent.maybeOf(context)?._fieldDidChange();
  }

  @protected
  void setValue(T? value) {
    _value = value;
  }


  @override
  String? get restorationId => widget.restorationId;

  ///因为混入[RestorationMixin] 覆写 对存储的值进行注册
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
// 注册储存的 [变量] 值和 id
    registerForRestoration(_errorText, 'error_text');
    registerForRestoration(_hasInteractedByUser, 'has_interacted_by_user');
  }

  @override
  void deactivate() {
    FormComponent.maybeOf(context)?._unregister(this);
    super.deactivate();
  }

  @override
  void dispose() {
    _errorText.dispose();
    _hasInteractedByUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enabled) {
      switch (widget.formValidationMode) {
        case FormValidationMode.auto:
          _validate();
        case FormValidationMode.onUserInteraction:
          if (_hasInteractedByUser.value) {
            _validate();
          }
        case FormValidationMode.disabled:
          break;
      }
    }
    FormComponent.maybeOf(context)?._register(this);
    return widget.builder(this);
  }
}
