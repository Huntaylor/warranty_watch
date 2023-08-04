import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'package:warranty_keeper/app_library.dart';

class WarrantyTextField extends StatefulWidget {
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
  final Function(String)? onChanged;
  final VoidCallback? onObscuredTap;
  const WarrantyTextField({
    Key? key,
    required this.maxLength,
    this.currentLength,
    this.errorText,
    this.inputFormatter,
    required this.maxLengthEnforcement,
    required this.textInputType,
    required this.hintText,
    required this.initialText,
    required this.initialValue,
    required this.isRequired,
    this.maxLines,
    this.onTap,
    required this.isDate,
    required this.isLifeTime,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    required this.onChanged,
    required this.hasAutocorrect,
    required this.isTextObscured,
    required this.isObscuredFunction,
    required this.onObscuredTap,
  }) : super(key: key);

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
    this.onTap,
    key,
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
        hasAutocorrect = false,
        super(key: key);

  WarrantyTextField.dob({
    this.initialDateTime,
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
    required this.isRequired,
    this.onTap,
    key,
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
        ),
        super(key: key);

  const WarrantyTextField.general({
    this.maxLength,
    this.errorText,
    this.maxLengthEnforcement,
    required this.isRequired,
    required this.initialValue,
    this.onTap,
    required this.hintText,
    this.inputFormatter,
    required this.onChanged,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    key,
    this.currentLength,
  })  : initialText = '',
        isDate = false,
        isTextObscured = false,
        onObscuredTap = null,
        isObscuredFunction = false,
        isLifeTime = false,
        maxLines = 1,
        hasAutocorrect = true,
        textInputType = TextInputType.text,
        super(key: key);

  const WarrantyTextField.number({
    this.maxLength,
    this.errorText,
    this.maxLengthEnforcement,
    required this.isRequired,
    required this.initialValue,
    this.onTap,
    required this.hintText,
    required this.onChanged,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    this.inputFormatter,
    key,
    this.currentLength,
  })  : initialText = '',
        isDate = false,
        isTextObscured = false,
        onObscuredTap = null,
        isObscuredFunction = false,
        isLifeTime = false,
        maxLines = 1,
        hasAutocorrect = true,
        textInputType = TextInputType.number,
        super(key: key);

  const WarrantyTextField.email({
    this.maxLength,
    this.errorText,
    this.maxLengthEnforcement,
    required this.isRequired,
    required this.initialValue,
    this.onTap,
    required this.onChanged,
    this.inputFormatter,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    key,
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
        textInputType = TextInputType.emailAddress,
        super(key: key);

  const WarrantyTextField.obscured({
    this.maxLength,
    this.errorText,
    this.maxLengthEnforcement,
    required this.isRequired,
    required this.initialValue,
    this.inputFormatter,
    this.onTap,
    required this.hintText,
    required this.onChanged,
    this.initialDateTime,
    this.startDateTime,
    required this.isObscuredFunction,
    this.endDateTime,
    required this.onObscuredTap,
    key,
    this.currentLength,
  })  : initialText = '',
        isDate = false,
        isTextObscured = true,
        isLifeTime = false,
        maxLines = 1,
        textInputType = TextInputType.text,
        hasAutocorrect = false,
        super(key: key);

  const WarrantyTextField.webSite({
    required this.isRequired,
    required this.initialValue,
    this.onTap,
    this.errorText,
    required this.hintText,
    required this.onChanged,
    this.initialDateTime,
    this.inputFormatter,
    this.startDateTime,
    this.endDateTime,
    key,
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
        textInputType = TextInputType.url,
        super(key: key);

  const WarrantyTextField.form({
    this.onTap,
    this.errorText,
    required this.hintText,
    this.inputFormatter,
    required this.initialValue,
    required this.onChanged,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    key,
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
        hasAutocorrect = true,
        super(key: key);

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
    String _dateToString(DateTime date) {
      final DateFormat formatter = DateFormat('MM/dd/yyyy');
      return formatter.format(date);
    }

    void buildCupertinoDatePicker() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (datePicked) {
                if (datePicked != widget.initialDateTime) {
                  controller.text = _dateToString(datePicked);
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
        initialEntryMode: DatePickerEntryMode.calendar,
      );
      if (datePicked != null && datePicked != widget.initialDateTime) {
        controller.text = _dateToString(datePicked);
        widget.onChanged?.call(controller.text);
      }
    }

    void _selectDate() {
      switch (context.themeData.platform) {
        case TargetPlatform.iOS:
          buildCupertinoDatePicker();
          break;
        case TargetPlatform.android:
        default:
          buildMaterialDatePicker();
          break;
      }
    }

    //Widget
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextFormField(
            autocorrect: widget.hasAutocorrect,
            obscureText: widget.isObscuredFunction,
            maxLength: widget.maxLength,
            maxLengthEnforcement: widget.maxLengthEnforcement,
            keyboardType: widget.textInputType,
            enabled: widget.isLifeTime ? false : true,
            inputFormatters: widget.inputFormatter,
            controller: controller,
            onChanged: widget.onChanged,
            onTap: () {
              widget.isDate ? _selectDate() : widget.onTap;
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
              labelText:
                  '${widget.hintText} ${(widget.isRequired) ? context.appLocalizations.required : ''}',
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
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '/');
    return newValue.copyWith(
      text: text,
      selection: updateCursorPosition(text),
    );
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 3) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
