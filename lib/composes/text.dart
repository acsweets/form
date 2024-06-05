import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form/form.dart';

import '../base_form/form_component.dart';
import '../base_form/form_render_scope.dart';
import '../entities/conponent_model.dart';

class FormTextComponent extends FormFieldComponent<String> {
  final ComponentModel component;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  FormTextComponent({this.controller, this.onChanged, required this.component, super.key})
      : super(
            initialValue: component.defaultValue ?? "",
            enabled: true,
            // 为false 不会验证此字段。
            formValidationMode: FormValidationMode.auto,
            builder: (field) {
      ///在字段改变时调用didChange来告知字段值发生改变
              void onChangedHandler(String value) {
                field.didChange(value);
                onChanged?.call(value);
              }

              BuildContext context = field.context;
              return Container(
                  margin: EdgeInsets.only(top: 16.w),
                  padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(component.label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                          Visibility(
                              visible: component.validateConfig.required ?? false,
                              child: Text(" *",
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.red))),
                        ],
                      ),
                      TextField(
                        readOnly: component.readOnly,
                        decoration: InputDecoration(
                            hintText: component.placeholder ?? '',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                            border: InputBorder.none),
                        maxLines: component.composeType == ComposeType.textArea ? 4 : 1,
                        onChanged: onChangedHandler,
                      ),
                      // Text(field.errorText??"",style: TextStyle(fontSize: 12.sp,color: Colors.red),)
                    ],
                  ));
            },
            validator: (value) {
              if (value!.isEmpty) return component.validateConfig.requiredMessage;
            });

  @override
  FormFieldComponentState<String> createState() => _FormTextComponentState();
}

class _FormTextComponentState extends FormFieldComponentState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController => _formTextComponent.controller ?? _controller!.value;

  FormTextComponent get _formTextComponent => super.widget as FormTextComponent;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (_formTextComponent.controller == null) {
      _createLocalController(widget.initialValue != null ? TextEditingValue(text: widget.initialValue!) : null);
    } else {
      _formTextComponent.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(FormTextComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_formTextComponent.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _formTextComponent.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _formTextComponent.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_formTextComponent.controller != null) {
        setValue(_formTextComponent.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _formTextComponent.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    // validate();
    print("======didChange=================$errorText");
    FormRenderScope.of(context)
        .addParam(_formTextComponent.component.key, value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
    _formTextComponent.onChanged?.call(_effectiveController.text);
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
