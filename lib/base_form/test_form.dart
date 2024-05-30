import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../utils/enum.dart';

class Form extends StatefulWidget {
  /// 为表单字段创建容器.
  const Form({
    super.key,
    required this.child,
    this.canPop,
    this.onPopInvoked,
    this.onChanged,
    FormValidationMode? formValidationMode,
  }) : formValidationMode = formValidationMode ?? FormValidationMode.disabled;

  ///返回包含给定上下文的最近[Form]小部件的[FormState]，如果未找到，则返回null。典型用法如下：``dart FormState？form=form.maybeOf（上下文）；
  ///类型拯救调用此方法将创建对[context]中最近的[Form]的依赖项（如果有）。另请参阅：[Form.of]，它与此方法类似，但如果没有找到[Form]祖先则断言。
  ///
  static FormState? maybeOf(BuildContext context) {
    final _FormScope? scope = context.dependOnInheritedWidgetOfExactType<_FormScope>();
    return scope?._formState;
  }

  ///返回包含给定上下文的最近[Form]小部件的[FormState]。典型用法如下：``dart-FormState form=form.of（context）；form.save（）；
  ///```如果没有找到[Form]祖先，这将在调试模式下断言，并在发布模式下引发异常。调用此方法将创建对[context]中最近的[Form]的依赖项。
  ///另请参阅：[Form.maybeOf]，它与此方法类似，但如果找不到[Form]祖先，则返回null。
  static FormState of(BuildContext context) {
    final FormState? formState = maybeOf(context);
    assert(() {
      if (formState == null) {
        throw FlutterError(
          'Form.of() was called with a context that does not contain a Form widget.\n'
              'No Form widget ancestor could be found starting from the context that '
              'was passed to Form.of(). This can happen because you are using a widget '
              'that looks for a Form ancestor, but no such ancestor exists.\n'
              'The context used was:\n'
              '  $context',
        );
      }
      return true;
    }());
    return formState!;
  }

  /// 树中此小部件下方的小部件。这是包含此表单的小部件层次结构的根
  final Widget child;

  /// 当导航弹出会导致表单数据丢失
  final bool? canPop;

  /// [canPop]，它也来自[PopScope]，经常与此参数一起使用。[PopScope.onPopInvoked]，这是[Form]内部委托的内容。
  final PopInvokedCallback? onPopInvoked;

  /// 当其中一个表单字段更改时调用。除了调用此回调之外，所有表单字段本身都将重新生成。
  final VoidCallback? onChanged;

  /// 用于启用、禁用表单字段自动验证并更新其错误文本
  final FormValidationMode formValidationMode;

  @override
  FormState createState() => FormState();
}

/// 与[Form]小部件关联的状态。[FormState]对象可用于[保存]、[重置]和[验证]作为关联[Form]子代的每个[FormField]。通常通过[Form.of]获得。
/// [FormState]表单状态是被[_FormScope]所管理的
class FormState extends State<Form> {
  /// 每次更改表单字段时递增。这让我们知道何时重建表单
  int _generation = 0;

  ///用户是否交互了
  bool _hasInteractedByUser = false;

  ///Set 是一种无序且不允许重复元素的集合数据类型

  final Set<FormFieldState<dynamic>> _fields = <FormFieldState<dynamic>>{};

  // 当表单字段发生更改时调用。这将导致所有表单字段重新生成，如果表单字段具有相互依存关系，这将非常有用。
  void _fieldDidChange() {
    widget.onChanged?.call();

    ///[any]检查集合中是否至少有一个元素满足给定的条件。如果有[就是用户已交互的]
    ///是否存在子组件的[_hasInteractedByUser]为true 如果存在[FormState]的 _hasInteractedByUser为true
    _hasInteractedByUser = _fields.any((FormFieldState<dynamic> field) => field._hasInteractedByUser.value);
    _forceRebuild();
  }

  /// 强制重建并修改[_generation]值,[_generation]值的改变会导致 _FormScope 去重新通知刷新所有的表单字段
  void _forceRebuild() {
    setState(() {
      ++_generation;
    });
  }

  ///登记，向[_fields]添加字段组价的状态
  void _register(FormFieldState<dynamic> field) {
    _fields.add(field);
  }
  ///卸载，向[_fields]移除字段组价的状态，证明表单不在管理这个字段组件的状态，在组件销毁前调用这个移除
  void _unregister(FormFieldState<dynamic> field) {
    _fields.remove(field);
  }

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

    if (widget.canPop != null || widget.onPopInvoked != null) {
      return PopScope(
        canPop: widget.canPop ?? true,
        onPopInvoked: widget.onPopInvoked,
        child: _FormScope(
          formState: this,
          generation: _generation,
          child: widget.child,
        ),
      );
    }

    ///为什么用widget.因为状态类持有widget
    return _FormScope(
      formState: this,
      generation: _generation,
      child: widget.child,
    );
  }

  /// 保存此[Form]的子代的每个[FormField]。
  void save() {
    for (final FormFieldState<dynamic> field in _fields) {
      field.save();
    }
  }

  /// 将此[Form]的子代[FormField]重置回其[FormField.initialValue]。
  /// 将调用[Form.onChanged]回调。如果表单的[form.autovalidateMode]属性为[autovalidateMode.allways]，则重置后将重新验证所有字段。
  void reset() {
    for (final FormFieldState<dynamic> field in _fields) {
      field.reset();
    }
    _hasInteractedByUser = false;
    _fieldDidChange();
  }

  /// 验证此[Form]的子代的每个[FormField]，如果没有错误，则返回true。表单将重新生成以报告结果。
  /// 另请参阅：[validateGranularly]，它也验证子代[FormField]，但返回一个有错误的字段[Set]。
  bool validate() {
    _hasInteractedByUser = true;
    _forceRebuild();
    return _validate();
  }

  /// 验证作为此[Form]的子代的每个[FormField]，并仅返回无效字段的[FormFieldState]的[Set]（如果有的话）。
  /// 此方法可用于突出显示有错误的字段。表单将重新生成以报告结果。另请参阅：[validate]，它还验证子代[FormField]，如果没有错误，则返回true。
  Set<FormFieldState<Object?>> validateGranularly() {
    final Set<FormFieldState<Object?>> invalidFields = <FormFieldState<Object?>>{};
    _hasInteractedByUser = true;
    _forceRebuild();
    _validate(invalidFields);
    return invalidFields;
  }

  ///表单验证方法
  ///[invalidFields]无效字段
  bool _validate([Set<FormFieldState<Object?>>? invalidFields]) {

    bool hasError = false;
    String errorMessage = '';
    ///主要通过循环调用字段的[validate]验证方法   判断是否有错误
    for (final FormFieldState<dynamic> field in _fields) {
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


///
/// [_FormScope] 持有表单中状态和表单 widget， 根据传入的[_generation]值去通知更新订阅的组件
class _FormScope extends InheritedWidget {
  const _FormScope({
    required super.child,
    required FormState formState,
    required int generation,
  })  : _formState = formState,
        _generation = generation;

  final FormState _formState;

  /// 每次更改表单字段时递增。这让我们知道何时重建表单。
  final int _generation;

  /// 与此小部件关联的[Form]。
  Form get form => _formState.widget;

  ///[_generation]值改变就更新通知
  @override
  bool updateShouldNotify(_FormScope old) => _generation != old._generation;
}

/// 用于验证表单字段的签名。如果输入无效，则返回要显示的错误字符串，否则返回null。由[FormField.validator]使用。
typedef FormFieldValidator<T> = String? Function(T? value);

/// 用于在表单字段更改值时收到通知的签名。由[FormField.onSaved]使用。
typedef FormFieldSetter<T> = void Function(T? newValue);

/// 用于构建表示表单字段的小部件的签名。由[FormField.builder]使用。
typedef FormFieldBuilder<T> = Widget Function(FormFieldState<T> field);

/// 单个表单字段。此小部件维护表单字段的当前状态，以便在UI中直观地反映更新和验证错误。
/// 在[Form]内部使用时，可以使用[FormState]上的方法来查询或操作整个表单数据。
/// 例如，调用[FormState.save]将依次调用每个[FormField]的[onSaved]回调。如果要检索其当前状态，
/// 例如，如果希望一个表单字段依赖于另一个，请将[GlobalKey]与[FormField]一起使用。不需要[Form]祖先。
/// [Form]允许一次保存、重置或验证多个字段。若要在不带[Form]的情况下使用，请将[GlobalKey]传递给构造函数，
/// 然后使用[GlobalKey.currentState]保存或重置表单字段。另请参阅：[Form]，它是聚合表单字段的小部件。[TextField]，这是一个常用的用于输入文本的表单字段。
/// [T]是提交表单字段的值
class FormField<T> extends StatefulWidget {
  /// Creates a single form field.
  const FormField({
    super.key,
    required this.builder,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.enabled = true,
    AutovalidateMode? autovalidateMode,
    this.restorationId,
  }) : autovalidateMode = autovalidateMode ?? AutovalidateMode.disabled;

  /// 通过保存表单时使用最终值调用的可选方法
  /// [FormState.save].
  final FormFieldSetter<T>? onSaved;

  /// 验证输入的可选方法。如果输入无效，则返回要显示的错误字符串，否则返回null。返回的值由[FormFieldState.errorText]属性公开。
  /// [TextFormField]使用它来覆盖[InputDecoration.errorText]值。如果没有在字段上设置其他子文本装饰，
  /// 则错误状态和正常状态之间的交替可能会导致[TextFormField]的高度发生变化。要创建一个无论是否显示错误都是固定高度的字段，
  /// 请将[TextFormField]封装在固定高度的父级中，如[SizedBox]，或将[InputDecoration.helperText]参数设置为空格。
  final FormFieldValidator<T>? validator;

  /// 函数，返回表示此表单字段的小部件。它被传递表单字段状态作为输入，包含该字段的当前值和验证状态。
  final FormFieldBuilder<T> builder;

  /// 将表单字段初始化为的可选值，否则为null。这在[DropdownButtonFormField]构造函数中被称为“value”，以与[DropdownButton]一致。
  final T? initialValue;

  /// 表单是否能够接收用户输入。默认为true。如果[autovalidateMode]不是[autovalidateMode.disabled]，
  /// 则该字段将自动验证。同样，如果此字段为false，则无论[autovalidateMode]如何，都不会验证小部件。
  final bool enabled;

  /// 用于启用或禁用此表单字段的自动验证并更新其错误文本。｛@template-flutter.widgets.FormField.autovalidateMode｝
  /// 如果[autovalidateMode.onUserInteraction]，此FormField将仅在其内容更改后自动验证。如果[AutovalidateMode.always]，即使没有用户交互，
  /// 它也会自动验证。如果[AutovalidateMode.disabled]，自动验证将被禁用。默认为[AutovalidateMode.disabled]。｛@endtemplate
  final AutovalidateMode autovalidateMode;

  ///restorationId 可以存储临时状态
  ///[RestorationMixin] 首先混入 RestorationMixin ，然后覆写 restorationId 和 restoreState 方法。 FormField拥有 恢复状态的特性。
  ///
  /// Restoration ID，用于保存和恢复表单字段的状态。将恢复ID设置为非null值将决定表单字段验证是否持续。
  /// 此小部件的状态使用所提供的恢复ID持久保存在[RestorationBucket]中，
  /// 并从周围的[RestoratationScope]中声明。另请参阅：[restoration Manager]，它解释了状态恢复在Flutter中的工作方式。
  final String? restorationId;

  @override
  FormFieldState<T> createState() => FormFieldState<T>();
}

/// [FormField]的当前状态。传递给[FormFieldBuilder]方法，用于构造表单字段的小部件。
class FormFieldState<T> extends State<FormField<T>> with RestorationMixin {
  late T? _value = widget.initialValue;

  ///这两个数据可以被储存，被恢复
  /// 可以通过拓展 RestorableProperty<T> 来自定义 RestorableXXX 完成需求。
  /// 错误文本
  final RestorableStringN _errorText = RestorableStringN(null);
  /// 用户是否交互
  final RestorableBool _hasInteractedByUser = RestorableBool(false);

  /// 表单字段的当前值。
  T? get value => _value;

  /// [FormField.validator]回调返回的当前验证错误，如果未触发错误，则返回null。这仅在调用[validate]时更新。
  String? get errorText => _errorText.value;

  /// 如果此字段有任何验证错误，则为True。
  bool get hasError => _errorText.value != null;

  /// 如果用户修改了此字段的值，则返回true。这只会在调用[diChange]后更新为true，在调用[reset]时重置为false。
  bool get hasInteractedByUser => _hasInteractedByUser.value;

  /// 如果当前值有效，则为True。这不会设置[errorText]或[hasError]，也不会更新错误显示。另请参阅：[validate]，它可能会更新[errorText]和[hasError]。

  /// 使用当前值调用[FormField]的onSaved方法。
  void save() {
    widget.onSaved?.call(value);
  }

  /// 将字段重置为其初始值。
  void reset() {
    setState(() {
      _value = widget.initialValue;
      _hasInteractedByUser.value = false;
      _errorText.value = null;
    });
    Form.maybeOf(context)?._fieldDidChange();
  }

  ///调用[FormField.validator]来设置[errorText]。如果没有错误，则返回true。另请参阅：[isValid]，它在不设置[errorText]或[hasError]的情况下被动获取有效性。
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

  ///将此字段的状态更新为新值。用于响应子窗口小部件更改，例如[Slider]的[Slider.onChanged]参数。触发[Form.onChanged]回调，
  ///如果[Form.autovalidateMode]为[autovalidateMode.allways]或[AutovalidationMode.onUserInteraction]，则重新验证表单的所有字段。
  void didChange(T? value) {
    setState(() {
      _value = value;
      _hasInteractedByUser.value = true;
    });
    Form.maybeOf(context)?._fieldDidChange();
  }

  /// 设置与此表单字段关联的值。当禁止调用“setState”时，由于小部件构建阶段识别的状态更改，
  /// 需要更新表单字段值的子类只应调用此方法。在所有其他情况下，应通过调用[diChange]来设置该值，这样可以确保调用“setState”。
  @protected
  // ignore: use_setters_to_change_properties, (API predates enforcing the lint)
  void setValue(T? value) {
    _value = value;
  }

  /// 因为混入[RestorationMixin] 覆写 restorationId 提供 id
  @override
  String? get restorationId => widget.restorationId;

  ///因为混入[RestorationMixin] 覆写 对存储的值进行注册
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
// 注册储存的 [变量] 值和 id
    registerForRestoration(_errorText, 'error_text');
    registerForRestoration(_hasInteractedByUser, 'has_interacted_by_user');
  }

  //如果小部件被从树中永久移除，调用它
  @override
  void deactivate() {
    //作用字段移除的话 通知表单
    Form.maybeOf(context)?._unregister(this);
    super.deactivate();
  }

  ///deactivate 首先被调用
  // 然后是 dispose
  //
  // 这是因为当一个 State 对象从渲染树中被移除时,会首先调用 deactivate 方法,之后再调用 dispose 方法来永久销毁该 State 对象。
  @override
  void dispose() {
    _errorText.dispose();
    _hasInteractedByUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enabled) {
      switch (widget.autovalidateMode) {
        case AutovalidateMode.always:
          _validate();
        case AutovalidateMode.onUserInteraction:
          if (_hasInteractedByUser.value) {
            _validate();
          }
        case AutovalidateMode.disabled:
          break;
      }
    }

    ///构建时将自己放进状态类里，让表单持有
    Form.maybeOf(context)?._register(this);
    return widget.builder(this);
  }
}
