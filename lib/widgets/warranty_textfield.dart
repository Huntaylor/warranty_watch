import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:warranty_keeper/app_library.dart';

class WarrantyTextField extends StatefulWidget {
  final TextInputType textInputType;
  final String hintText;
  final String initialText;
  final String initialValue;
  final bool isRequired;
  final int? maxLines;
  final VoidCallback? onTap;
  final bool isDate;
  final bool isLifeTime;
  final DateTime? initialDateTime;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final Function(String)? onChanged;
  const WarrantyTextField({
    Key? key,
    required this.hintText,
    required this.initialValue,
    required this.textInputType,
    required this.initialText,
    required this.isRequired,
    this.maxLines,
    this.onTap,
    required this.isDate,
    required this.isLifeTime,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    required this.onChanged,
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
  })  : initialText = initialDateTime != null
            ? DateFormat('MM/dd/yyyy').format(initialDateTime)
            : '',
        textInputType = TextInputType.none,
        isDate = true,
        maxLines = 1,
        super(key: key);

  const WarrantyTextField.general({
    required this.isRequired,
    required this.initialValue,
    this.onTap,
    required this.hintText,
    required this.onChanged,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    key,
  })  : initialText = '',
        isDate = false,
        isLifeTime = false,
        maxLines = 1,
        textInputType = TextInputType.text,
        super(key: key);

  const WarrantyTextField.webSite({
    required this.isRequired,
    required this.initialValue,
    this.onTap,
    required this.hintText,
    required this.onChanged,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    key,
  })  : initialText = '',
        isDate = false,
        isLifeTime = false,
        maxLines = 1,
        textInputType = TextInputType.url,
        super(key: key);

  const WarrantyTextField.form({
    this.onTap,
    required this.hintText,
    required this.initialValue,
    required this.onChanged,
    this.initialDateTime,
    this.startDateTime,
    this.endDateTime,
    key,
  })  : initialText = '',
        textInputType = TextInputType.text,
        isDate = false,
        isLifeTime = false,
        maxLines = 3,
        isRequired = false,
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
        context: context,
        initialDate: widget.initialDateTime ?? DateTime.now(),
        firstDate: widget.startDateTime ?? DateTime(2000),
        lastDate: widget.endDateTime ?? DateTime(2050),
        initialEntryMode: DatePickerEntryMode.input,
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
            keyboardType: widget.textInputType,
            enabled: widget.isLifeTime ? false : true,
            inputFormatters: [
              if (widget.isDate) DateTextFormatter(),
            ],
            controller: controller,
            onChanged: widget.onChanged,
            onTap: () {
              widget.isDate ? _selectDate() : widget.onTap;
            },
            maxLines: widget.maxLines ?? 1,
            decoration: InputDecoration(
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
