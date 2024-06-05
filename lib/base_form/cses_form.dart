import 'package:flutter/material.dart';

class CSESForm extends StatefulWidget {
  final Widget child;
  final VoidCallback? onChanged;
  final void Function(bool)? onPopInvoked;
  final bool? canPop;
  final AutovalidateMode? autovalidateMode;
  final Map<String, dynamic> initialValue;
  final bool skipDisabled;

  final bool enabled;

  final bool clearValueOnUnregister;

  const CSESForm({
    super.key,
    required this.child,
    this.onChanged,
    this.autovalidateMode,
    this.onPopInvoked,
    this.initialValue = const <String, dynamic>{},
    this.skipDisabled = false,
    this.enabled = true,
    this.clearValueOnUnregister = false,
    this.canPop,
  });

  static CSESFormState? of(BuildContext context) => context.findAncestorStateOfType<CSESFormState>();

  @override
  State<CSESForm> createState() => CSESFormState();
}

typedef CSESFormFields = Map<String, CSESFormFieldState<CSESFormField<dynamic>, dynamic>>;

class CSESFormState extends State<CSESForm> {
  final Map<String, dynamic> _instantValue = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CSESFormFields _fields = {};
  final Map<String, dynamic> _savedValue = {};

  void registerField(String name, CSESFormFieldState field) {
    final oldField = _fields[name];
    assert(() {
      if (oldField != null) {
        debugPrint('Warning! Replacing duplicate Field for $name'
            ' -- this is OK to ignore as long as the field was intentionally replaced');
      }
      return true;
    }());

    _fields[name] = field;
  }

  void unregisterField(String name, CSESFormFieldState field) {
    assert(
      _fields.containsKey(name),
      'Failed to unregister a field. Make sure that all field names in a form are unique.',
    );
    if (field == _fields[name]) {
      _fields.remove(name);
      if (widget.clearValueOnUnregister) {
        _instantValue.remove(name);
      }
    } else {
      assert(() {
        // This is OK to ignore when you are intentionally replacing a field
        // with another field using the same name.
        debugPrint('Warning! Ignoring Field unregistration for $name'
            ' -- this is OK to ignore as long as the field was intentionally replaced');
        return true;
      }());
    }
  }

//设置字段保存值
  void setInternalFieldValue<T>(String name, T? value) {
    _instantValue[name] = value;
    widget.onChanged?.call();
  }

  //删除字段保存值
  void removeInternalFieldValue(String name) {
    _instantValue.remove(name);
  }

  void save() {
    _formKey.currentState!.save();
    // Copy values from instant to saved
    _savedValue.clear();
    _savedValue.addAll(_instantValue);
  }
//得到表单字段的值
  Map<String, dynamic> get value =>
      Map<String, dynamic>.unmodifiable(_savedValue.map((key, value) => MapEntry(key, value)));

  void submit() {
    save();
    _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: widget.autovalidateMode,
      onPopInvoked: widget.onPopInvoked,
      canPop: widget.canPop,
      child: _CSESFormScope(
        formState: this,
        child: FocusTraversalGroup(
          policy: WidgetOrderTraversalPolicy(),
          child: widget.child,
        ),
      ),
    );
  }
}

class _CSESFormScope extends InheritedWidget {
  const _CSESFormScope({
    required super.child,
    required CSESFormState formState,
  }) : _formState = formState;

  final CSESFormState _formState;

  /// The [Form] associated with this widget.
  CSESForm get form => _formState.widget;

  @override
  bool updateShouldNotify(_CSESFormScope oldWidget) => oldWidget._formState != _formState;
}

class CSESFormField<T> extends FormField<T> {
  final String name;
  final FocusNode? focusNode;
  final bool readOnly;

  const CSESFormField({
    super.key,
    super.onSaved,
    super.initialValue,
    super.autovalidateMode,
    super.enabled = true,
    super.validator,
    super.restorationId,
    required this.name,
    required super.builder,
    this.focusNode,
    this.readOnly = false,
  });

  @override
  CSESFormFieldState<CSESFormField<T>, T> createState() => CSESFormFieldState<CSESFormField<T>, T>();
}

class CSESFormFieldState<F extends CSESFormField<T>, T> extends FormFieldState<T> {
  CSESFormState? _formState;
  late FocusNode effectiveFocusNode;
  bool _touched = false;

  //拿到表单的状态

  CSESFormState? get formState => _formState;
  FocusAttachment? focusAttachment;

  bool get isTouched => _touched;

  @override
  F get widget => super.widget as F;

  @override
  void initState() {
    _formState = CSESForm.of(context);
    // Set the initial value
    _formState?.registerField(widget.name, this);
    effectiveFocusNode = widget.focusNode ?? FocusNode(debugLabel: widget.name);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CSESFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.name != oldWidget.name) {
      _formState?.unregisterField(oldWidget.name, this);
      _formState?.registerField(widget.name, this);
    }
    if (widget.focusNode != oldWidget.focusNode) {
      focusAttachment?.detach();
      effectiveFocusNode.removeListener(_touchedHandler);
      effectiveFocusNode = widget.focusNode ?? FocusNode();
      effectiveFocusNode.addListener(_touchedHandler);
      focusAttachment = effectiveFocusNode.attach(context);
    }
  }

//焦点触摸时的回调
  void _touchedHandler() {
    if (effectiveFocusNode.hasFocus && _touched == false) {
      setState(() => _touched = true);
    }
  }

//给保存的设置值
  void _informFormForFieldChange() {
    if (_formState != null) {
      if (widget.readOnly) {
        _formState!.setInternalFieldValue<T>(widget.name, value);
        return;
      }
      _formState!.removeInternalFieldValue(widget.name);
    }
  }

  @override
  void dispose() {
    effectiveFocusNode.removeListener(_touchedHandler);
    if (widget.focusNode == null) {
      effectiveFocusNode.dispose();
    }
    _formState?.unregisterField(widget.name, this);
    super.dispose();
  }
}
