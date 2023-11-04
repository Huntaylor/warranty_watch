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
    required this.isDate,
    required this.isLifeTime,
    required this.onChanged,
    required this.hasAutocorrect,
    required this.isTextObscured,
    required this.isObscuredFunction,
    required this.onObscuredTap,
    required this.textFieldName,
    this.textInputAction,
    this.autofillHints,
    this.textCapitalization,
    this.secondHintText,
    this.onSecondChanged,
    this.isDouble,
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
    required this.isLifeTime,
    required this.hintText,
    required this.onChanged,
    required this.initialDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.textFieldName,
    this.textInputAction,
    this.initialValue = '',
    super.key,
    this.onTap,
    this.autofillHints,
    this.maxLength,
    this.maxLengthEnforcement,
    this.currentLength,
    this.errorText,
  })  : initialText = initialDateTime != null
            ? DateFormat('MM/dd/yyyy').format(initialDateTime)
            : '',
        inputFormatter = const [],
        textInputType = TextInputType.none,
        isDate = true,
        maxLines = null,
        isTextObscured = false,
        onObscuredTap = null,
        isDouble = false,
        onSecondChanged = null,
        secondHintText = null,
        textCapitalization = TextCapitalization.none,
        isObscuredFunction = false,
        hasAutocorrect = false;

  const WarrantyTextField.general({
    required this.hintText,
    required this.onChanged,
    required this.textFieldName,
    this.initialValue = '',
    super.key,
    this.maxLength,
    this.errorText,
    this.maxLengthEnforcement,
    this.onTap,
    this.autofillHints,
    this.inputFormatter,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    this.currentLength,
    this.textInputAction,
  })  : initialText = '',
        isDate = false,
        isTextObscured = false,
        onObscuredTap = null,
        isObscuredFunction = false,
        isLifeTime = false,
        isDouble = false,
        textCapitalization = TextCapitalization.sentences,
        onSecondChanged = null,
        secondHintText = null,
        maxLines = null,
        hasAutocorrect = true,
        textInputType = TextInputType.text;

  const WarrantyTextField.doubleField({
    required this.hintText,
    required this.onChanged,
    required this.onSecondChanged,
    required this.textFieldName,
    required this.secondHintText,
    super.key,
    this.initialValue = '',
    this.maxLength,
    this.errorText,
    this.autofillHints,
    this.maxLengthEnforcement,
    this.onTap,
    this.inputFormatter,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    this.currentLength,
    this.textInputAction,
  })  : initialText = '',
        isDate = false,
        isTextObscured = false,
        onObscuredTap = null,
        textCapitalization = TextCapitalization.words,
        isObscuredFunction = false,
        isLifeTime = false,
        isDouble = true,
        maxLines = null,
        hasAutocorrect = true,
        textInputType = TextInputType.text;

  const WarrantyTextField.number({
    required this.hintText,
    required this.onChanged,
    required this.textFieldName,
    super.key,
    this.maxLength,
    this.errorText,
    this.maxLengthEnforcement,
    this.autofillHints,
    this.initialValue = '',
    this.onTap,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    this.inputFormatter,
    this.currentLength,
    this.textInputAction,
  })  : initialText = '',
        isDate = false,
        isTextObscured = false,
        onObscuredTap = null,
        isObscuredFunction = false,
        isLifeTime = false,
        textCapitalization = TextCapitalization.none,
        isDouble = false,
        onSecondChanged = null,
        secondHintText = null,
        maxLines = null,
        hasAutocorrect = true,
        textInputType = TextInputType.number;

  const WarrantyTextField.email({
    required this.onChanged,
    required this.textFieldName,
    super.key,
    this.maxLength,
    this.initialValue = '',
    this.errorText,
    this.maxLengthEnforcement,
    this.onTap,
    this.inputFormatter,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    this.textInputAction,
    this.currentLength,
  })  : initialText = '',
        hintText = 'Email',
        isDate = false,
        isTextObscured = false,
        autofillHints = const [AutofillHints.email],
        onObscuredTap = null,
        isObscuredFunction = false,
        textCapitalization = TextCapitalization.none,
        isLifeTime = false,
        isDouble = false,
        onSecondChanged = null,
        secondHintText = null,
        maxLines = null,
        hasAutocorrect = false,
        textInputType = TextInputType.emailAddress;

  const WarrantyTextField.obscured({
    required this.hintText,
    required this.onChanged,
    required this.isObscuredFunction,
    required this.onObscuredTap,
    required this.textFieldName,
    super.key,
    this.initialValue = '',
    this.maxLength,
    this.errorText,
    this.maxLengthEnforcement,
    this.inputFormatter,
    this.onTap,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    this.currentLength,
    this.textInputAction,
  })  : initialText = '',
        isDate = false,
        textCapitalization = TextCapitalization.none,
        isTextObscured = true,
        isLifeTime = false,
        autofillHints = const [AutofillHints.password],
        isDouble = false,
        onSecondChanged = null,
        secondHintText = null,
        maxLines = 1,
        textInputType = TextInputType.text,
        hasAutocorrect = false;

  const WarrantyTextField.webSite({
    required this.hintText,
    required this.onChanged,
    required this.textFieldName,
    super.key,
    this.onTap,
    this.errorText,
    this.initialDateTime,
    this.inputFormatter,
    this.initialValue = '',
    this.startDateTime,
    this.endDateTime,
    this.maxLength,
    this.maxLengthEnforcement,
    this.currentLength,
    this.textInputAction,
  })  : initialText = '',
        isDate = false,
        isLifeTime = false,
        isDouble = false,
        autofillHints = const [AutofillHints.url],
        textCapitalization = TextCapitalization.none,
        onSecondChanged = null,
        secondHintText = null,
        maxLines = null,
        onObscuredTap = null,
        isTextObscured = false,
        isObscuredFunction = false,
        hasAutocorrect = false,
        textInputType = TextInputType.url;

  const WarrantyTextField.form({
    required this.hintText,
    required this.onChanged,
    required this.textFieldName,
    super.key,
    this.onTap,
    this.errorText,
    this.inputFormatter,
    this.initialDateTime,
    this.initialValue = '',
    this.startDateTime,
    this.endDateTime,
    this.maxLength,
    this.maxLengthEnforcement,
    this.currentLength,
    this.textInputAction,
  })  : initialText = '',
        textInputType = TextInputType.text,
        isDate = false,
        isLifeTime = false,
        autofillHints = null,
        isDouble = false,
        onSecondChanged = null,
        textCapitalization = TextCapitalization.sentences,
        secondHintText = null,
        onObscuredTap = null,
        maxLines = 3,
        isObscuredFunction = false,
        isTextObscured = false,
        hasAutocorrect = true;

  final TextCapitalization? textCapitalization;
  final Iterable<String>? autofillHints;
  final String textFieldName;
  final int? maxLength;
  final int? currentLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final TextInputType? textInputType;
  final String hintText;
  final String? secondHintText;
  final bool? isDouble;
  final String initialText;
  final String initialValue;
  final String? errorText;
  final bool hasAutocorrect;
  final bool isTextObscured;
  final bool isObscuredFunction;
  final int? maxLines;
  final VoidCallback? onTap;
  final bool isDate;
  final bool isLifeTime;
  final TextInputAction? textInputAction;
  final DateTime? initialDateTime;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final List<TextInputFormatter>? inputFormatter;
  final void Function(String)? onChanged;
  final void Function(String)? onSecondChanged;
  final VoidCallback? onObscuredTap;

  @override
  State<WarrantyTextField> createState() => _WarrantyTextFieldState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('hasAutocorrect', hasAutocorrect));
  }
}

class _WarrantyTextFieldState extends State<WarrantyTextField> {
  late TextEditingController controller;
  late TextEditingController secondController;
  @override
  void initState() {
    controller = TextEditingController();
    controller.text = widget.initialValue;
    secondController = TextEditingController();
    secondController.text = widget.initialValue;
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
              minimumYear: DateTime.now().year - 50,
              maximumYear: 2150,
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

    //Widget
    Widget textFormField({required bool isDouble}) {
      return TextFormField(
        textInputAction: widget.textInputAction,
        autofillHints: widget.autofillHints,
        autocorrect: widget.hasAutocorrect,
        obscureText: widget.isObscuredFunction,
        // maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        keyboardType: widget.textInputType,
        enabled: !widget.isLifeTime,
        inputFormatters: widget.inputFormatter,
        controller: isDouble ? secondController : controller,
        onChanged: isDouble ? widget.onSecondChanged : widget.onChanged,
        // onTap: widget.isDate ? selectDate : widget.onTap,
        onTap: widget.onTap,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          fillColor: context.colorScheme.surfaceVariant,
          floatingLabelBehavior: FloatingLabelBehavior.never,
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
          suffixText: (widget.maxLength != null)
              ? '${widget.currentLength}/${widget.maxLength}'
              : null,
          label: Padding(
            padding: widget.isTextObscured
                ? const EdgeInsets.only(left: 48)
                : EdgeInsets.zero,
            child: Center(
              child: Text(
                isDouble
                    ? widget.secondHintText ?? widget.hintText
                    : widget.hintText,
              ),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(widget.textFieldName),
        ),
        Visibility(
          visible: widget.isDouble ?? false,
          replacement: textFormField(isDouble: false),
          child: Row(
            children: [
              Flexible(
                child: textFormField(
                  isDouble: false,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: textFormField(
                  isDouble: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
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
