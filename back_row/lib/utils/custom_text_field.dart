import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/font_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String label;
  final int validateLength;
  final Function(String) save;
  final bool isObscure;
  final int maxLength;
  final TextEditingController controller;
  final int maxLines;
  final String initialValue;
  final TextInputType keyboard;
  final Function(String) validator;
  final bool readOnly;
  final bool enabled;
  final bool isBorderless;
  final bool withLabelOnTop;
  final bool fillBorderWithColor;
  final String labelTopText;
  final bool fromChangePassword;

  const CustomTextField(
      {Key key,
      this.hint = "",
      this.enabled = true,
      @required this.label,
      this.validateLength,
      this.save,
      this.isObscure = false,
      this.maxLength,
      this.controller,
      this.maxLines,
      this.initialValue,
      this.keyboard,
      this.readOnly = false,
      this.isBorderless = false,
      this.fillBorderWithColor = false,
      this.withLabelOnTop = false,
      this.labelTopText,
      this.fromChangePassword = false,
      this.validator})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure, isValidated;
  String currentText;

  @override
  void initState() {
    isObscure = widget.isObscure;
    isValidated = false;
    if (widget.controller != null) {
      isValidated = validate(widget.controller.text) == null;
      currentText =
          widget.controller.text.isNotEmpty ? widget.controller.text : null;
      widget.controller.addListener(() {
        setState(() {
          if (widget.controller.text.isNotEmpty) {
            isValidated = validate(widget.controller.text) == null;
          }
          currentText = widget.controller.text;
        });
      });
    }
    super.initState();
  }

  String validate(String text) {
    String Function(String) validateFn = widget.validator ??
        (value) {
          if (widget.validateLength == 0 || widget.validateLength == null)
            return null;
          if (value == null) return "Invalid input";
          if (value.length < widget.validateLength)
            return "${widget.label ?? "Input"} mindestens ${widget.validateLength} zeichen lang";
          return null;
        };
    return validateFn(text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.withLabelOnTop
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 8.0),
                  child: Text(
                    widget.labelTopText,
                    style: FontStyle.inputTopLabelTextStyle,
                  ),
                )
              : Container(),
          TextFormField(
            autovalidate: currentText != null && currentText.isNotEmpty,
            readOnly: widget.readOnly,
            controller: widget.controller,
            validator: validate,
            toolbarOptions: ToolbarOptions(
                copy: true, cut: true, paste: true, selectAll: true),
            obscureText: isObscure,
            onSaved: widget.save,
            maxLines: widget.maxLines ?? 1,
            enabled: widget.enabled,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboard,

            initialValue: widget.initialValue,
            cursorColor: Colors.black,
            style: FontStyle.inputTextStyle
                .copyWith(color: Colors.black, fontSize: 14),
            decoration: InputDecoration(
              suffixIcon: widget.isObscure &&
                      (currentText != null && currentText.isNotEmpty)
                  ? IconButton(
                      icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off,
                        color: ColorConstant.customBtnGradient1,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      })
                  : (currentText != null && currentText.trim().isNotEmpty) &&
                          isValidated
                      ? Icon(
                          Icons.check_circle,
                          color: ColorConstant.customBtnGradient1,
                        )
                      : null,
              enabledBorder: widget.fillBorderWithColor
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: ColorConstant.black, width: 0.5))
                  : null,
              focusedBorder: widget.isBorderless
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: ColorConstant.black, width: 1.5)),
              border: widget.isBorderless
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
              contentPadding: widget.isBorderless
                  ? null
                  : EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              filled: widget.isBorderless ? false : true,
              fillColor: widget.isBorderless
                  ? null
                  : widget.fromChangePassword
                      ? ColorConstant.yellow.withAlpha(35)
                      : ColorConstant.textFieldBorderColor,
              hintText: widget.withLabelOnTop ? widget.label : null,
              hintStyle: FontStyle.labelTextStyle,
              labelText: widget.withLabelOnTop ? null : widget.label ?? '',
              labelStyle: widget.withLabelOnTop
                  ? null
                  : FontStyle.labelTextStyle.copyWith(
                      color: widget.fromChangePassword
                          ? Colors.black.withOpacity(0.9)
                          : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class ConstantTextField extends StatelessWidget {
  final String initialValue, label;

  const ConstantTextField(
      {Key key, @required this.initialValue, @required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: TextFormField(
        enabled: false,
        initialValue: initialValue ?? "",
        decoration: InputDecoration(
          fillColor: Colors.black,
          filled: true,
          alignLabelWithHint: true,
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
