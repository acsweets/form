import 'package:flutter/material.dart';

import '../../test/conmposes/base_compose.dart';
import '../../test/conmposes/compose_state.dart';

class Input extends BaseCompose {
  const Input({super.key,  required super.label, required super.required});

  @override
  Widget compose(BuildContext context) {
    return
      Expanded(
          child: TextField(
              controller:  ComposeScope.of(context).contentController,
              // style: TextStyle(
              //     fontSize: 16.sp,
              //     fontWeight: FontWeight.w500,
              //     color: Provider.of<ThemeModel>(context).textColor),
              // textAlign: TextAlign.end,
              // keyboardType: widget.map['mode'] == "number" || widget.map['mode'] == "price"
              //     ? TextInputType.number
              //     : widget.map['mode'] == "email"
              //     ? TextInputType.emailAddress
              //     : widget.map['mode'] == "contact-mobile"
              //     ? TextInputType.phone
              //     : widget.map['mode'] == "password"
              //     ? TextInputType.visiblePassword
              //     : TextInputType.text,
              // obscureText: widget.map['mode'] == "password",
              // inputFormatters: widget.map['mode'] == "contact-mobile"
              //     ? [phoneInputFormatter(), LengthLimitingTextInputFormatter(13)]
              //     : widget.map['mode'] == "id"
              //     ? [LengthLimitingTextInputFormatter(18)]
              //     : widget.map['mode'] == "price"
              //     ? [priceInputFormatter()]
              //     : [],
              // decoration: InputDecoration(
              //     hintText: widget.map['placeholder'] ?? '',
              //     hintStyle: TextStyle(color: ColorUtil.color_999999, fontSize: 16.sp),
              //     border: InputBorder.none),
              // onChanged: (value) {
              //   eventBus.fire(WidgetValueChangedEvent(widget.map['id'],
              //       value: value, type: widget.map['type'], mode: widget.map['mode']));
              // }));
          ));
  }
}


