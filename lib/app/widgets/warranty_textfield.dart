import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'package:warranty_watch/app/app_library.dart';

class WarrantyTextField extends StatefulWidget {
  const WarrantyTextField({
    required this.maxLength,
    required this.maxLengthEnforcement,
    required this.textInputType,
    required this.hintText,
    required this.initialText,
    required this.initialValue,
    required this.isRequired,
    required this.isDate,
    required this.isLifeTime,
    required this.onChanged,
    required this.hasAutocorrect,
    required this.isTextObscured,
    required this.isObscuredFunction,
    required this.onObscuredTap,
    super.key,
    this.currentLength,
    this.errorText,
    this.inputFormatter,
    this.maxLines,
    this.onTap,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
  });

  // const factory WarrantyTextField.date() = LimitedWarrantyTextField;

  WarrantyTextField.date({
    required this.initialValue,
    required this.isLifeTime,
    required this.hintText,
    required this.onChanged,
    required this.initialDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.isRequired,
    super.key,
    this.onTap,
    this.maxLength,
    this.maxLengthEnforcement,
    this.currentLength,
    this.errorText,
  })  : initialText = initialDateTime != null
            ? DateFormat('MM/dd/yyyy').format(initialDateTime)
            : '',
        inputFormatter = [],
        textInputType = TextInputType.none,
        isDate = true,
        maxLines = 1,
        isTextObscured = false,
        onObscuredTap = null,
        isObscuredFunction = false,
        hasAutocorrect = false;

  WarrantyTextField.dob({
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
    required this.isRequired,
    super.key,
    this.initialDateTime,
    this.onTap,
    this.maxLength,
    this.maxLengthEnforcement,
    this.currentLength,
    this.errorText,
  })  : initialText = initialDateTime != null
            ? DateFormat('MM/dd/yyyy').format(initialDateTime)
            : '',
        textInputType = TextInputType.none,
        isDate = true,
        inputFormatter = [],
        maxLines = 1,
        isTextObscured = false,
        onObscuredTap = null,
        isObscuredFunction = false,
        hasAutocorrect = false,
        isLifeTime = false,
        startDateTime = DateTime(1920),
        endDateTime = DateTime.now().subtract(
          const Duration(
            days: 4748,
          ),
        );

  const WarrantyTextField.general({
    required this.isRequired,
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
    super.key,
    this.maxLength,
    this.errorText,
    this.maxLengthEnforcement,
    this.onTap,
    this.inputFormatter,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    this.currentLength,
  })  : initialText = '',
        isDate = false,
        isTextObscured = false,
        onObscuredTap = null,
        isObscuredFunction = false,
        isLifeTime = false,
        maxLines = 1,
        hasAutocorrect = true,
        textInputType = TextInputType.text;

  const WarrantyTextField.number({
    required this.isRequired,
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
    super.key,
    this.maxLength,
    this.errorText,
    this.maxLengthEnforcement,
    this.onTap,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    this.inputFormatter,
    this.currentLength,
  })  : initialText = '',
        isDate = false,
        isTextObscured = false,
        onObscuredTap = null,
        isObscuredFunction = false,
        isLifeTime = false,
        maxLines = 1,
        hasAutocorrect = true,
        textInputType = TextInputType.number;

  const WarrantyTextField.email({
    required this.isRequired,
    required this.initialValue,
    required this.onChanged,
    super.key,
    this.maxLength,
    this.errorText,
    this.maxLengthEnforcement,
    this.onTap,
    this.inputFormatter,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    this.currentLength,
  })  : initialText = '',
        hintText = 'Email',
        isDate = false,
        isTextObscured = false,
        onObscuredTap = null,
        isObscuredFunction = false,
        isLifeTime = false,
        maxLines = 1,
        hasAutocorrect = false,
        textInputType = TextInputType.emailAddress;

  const WarrantyTextField.obscured({
    required this.isRequired,
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
    required this.isObscuredFunction,
    required this.onObscuredTap,
    super.key,
    this.maxLength,
    this.errorText,
    this.maxLengthEnforcement,
    this.inputFormatter,
    this.onTap,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    this.currentLength,
  })  : initialText = '',
        isDate = false,
        isTextObscured = true,
        isLifeTime = false,
        maxLines = 1,
        textInputType = TextInputType.text,
        hasAutocorrect = false;

  const WarrantyTextField.webSite({
    required this.isRequired,
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
    super.key,
    this.onTap,
    this.errorText,
    this.initialDateTime,
    this.inputFormatter,
    this.startDateTime,
    this.endDateTime,
    this.maxLength,
    this.maxLengthEnforcement,
    this.currentLength,
  })  : initialText = '',
        isDate = false,
        isLifeTime = false,
        maxLines = 1,
        onObscuredTap = null,
        isTextObscured = false,
        isObscuredFunction = false,
        hasAutocorrect = false,
        textInputType = TextInputType.url;

  const WarrantyTextField.form({
    required this.hintText,
    required this.initialValue,
    required this.onChanged,
    super.key,
    this.onTap,
    this.errorText,
    this.inputFormatter,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    this.maxLength,
    this.maxLengthEnforcement,
    this.currentLength,
  })  : initialText = '',
        textInputType = TextInputType.text,
        isDate = false,
        isLifeTime = false,
        onObscuredTap = null,
        maxLines = 3,
        isObscuredFunction = false,
        isTextObscured = false,
        isRequired = false,
        hasAutocorrect = true;
  final int? maxLength;
  final int? currentLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final TextInputType? textInputType;
  final String hintText;
  final String initialText;
  final String initialValue;
  final String? errorText;
  final bool isRequired;
  final bool hasAutocorrect;
  final bool isTextObscured;
  final bool isObscuredFunction;
  final int? maxLines;
  final VoidCallback? onTap;
  final bool isDate;
  final bool isLifeTime;
  final DateTime? initialDateTime;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final List<TextInputFormatter>? inputFormatter;
  final void Function(String)? onChanged;
  final VoidCallback? onObscuredTap;

  @override
  State<WarrantyTextField> createState() => _WarrantyTextFieldState();
}

class _WarrantyTextFieldState extends State<WarrantyTextField> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    controller.text = widget.initialValue;
    super.initState();
  }

  //? const WarrantyTextField.tay() : this.morg(); redirect constructor

  @override
  Widget build(BuildContext context) {
    //Used for Date Picker
    String dateToString(DateTime date) {
      final formatter = DateFormat('MM/dd/yyyy');
      return formatter.format(date);
    }

    void buildCupertinoDatePicker() {
      showModalBottomSheet<Widget>(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (datePicked) {
                if (datePicked != widget.initialDateTime) {
                  controller.text = dateToString(datePicked);
                  widget.onChanged?.call(controller.text);
                }
              },
              maximumDate: widget.endDateTime,
              minimumDate: widget.startDateTime,
              initialDateTime: widget.initialDateTime,
              minimumYear: 2000,
              maximumYear: 2050,
            ),
          );
        },
      );
    }

    Future<void> buildMaterialDatePicker() async {
      final datePicked = await showDatePicker(
        keyboardType: TextInputType.text,
        context: context,
        initialDate: widget.initialDateTime ?? DateTime.now(),
        firstDate: widget.startDateTime ?? DateTime(2000),
        lastDate: widget.endDateTime ?? DateTime(2050),
      );
      if (datePicked != null && datePicked != widget.initialDateTime) {
        controller.text = dateToString(datePicked);
        widget.onChanged?.call(controller.text);
      }
    }

    void selectDate() {
      switch (context.themeData.platform) {
        case TargetPlatform.macOS:
        case TargetPlatform.iOS:
          buildCupertinoDatePicker();
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          buildMaterialDatePicker();
      }
    }

    final requiredText = (widget.isRequired) ? context.l10n.requiredText : '';
    final labelText = '${widget.hintText} $requiredText';

    //Widget
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextFormField(
            autocorrect: widget.hasAutocorrect,
            obscureText: widget.isObscuredFunction,
            maxLength: widget.maxLength,
            maxLengthEnforcement: widget.maxLengthEnforcement,
            keyboardType: widget.textInputType,
            enabled: !widget.isLifeTime,
            inputFormatters: widget.inputFormatter,
            controller: controller,
            onChanged: widget.onChanged,
            onTap: () {
              widget.isDate ? selectDate() : widget.onTap;
            },
            maxLines: widget.maxLines ?? 1,
            decoration: InputDecoration(
              errorText: widget.errorText,
              suffixIcon: widget.isTextObscured
                  ? GestureDetector(
                      onTap: widget.onObscuredTap,
                      child: Icon(
                        !widget.isObscuredFunction
                            ? Icons.remove_red_eye
                            : Icons.visibility_off,
                      ),
                    )
                  : null,
              counterText: '',
              suffixText: (widget.maxLength != null)
                  ? '${widget.currentLength}/${widget.maxLength}'
                  : null,
              alignLabelWithHint: true,
              labelText: labelText,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = _format(newValue.text, '/');
    return newValue.copyWith(
      text: text,
      selection: updateCursorPosition(text),
    );
  }

  String _format(String value, String seperator) {
    final newValue = value.replaceAll(seperator, '');
    var newString = '';

    for (var i = 0; i < min(newValue.length, _maxChars); i++) {
      newString += newValue[i];
      if ((i == 1 || i == 3) && i != newValue.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
