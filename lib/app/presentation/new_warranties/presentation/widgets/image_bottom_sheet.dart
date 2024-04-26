// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/new_warranties/presentation/new_warranty_view.dart';

enum DateFieldType {
  endOfWarranty,
  purchaseDate,
  reminderDate,
}

class ImageBottomSheet extends StatelessWidget {
  const ImageBottomSheet({
    required this.onPrimary,
    required this.onSecondary,
    super.key,
  });
  final void Function() onPrimary;
  final Future<void> Function() onSecondary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(context.l10n.cancel),
                ),
                Text(
                  context.l10n.addItem,
                  style: context.textTheme.headlineSmall,
                ),
                const Gap(
                  48,
                ),
              ],
            ),
          ),
          const Divider(
            height: 24,
            thickness: 2,
          ),
          const Gap(
            24,
          ),
          Flexible(
            child: /*  state.warrantyState == WarrantyState.loadingImage
                ? const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                :  */
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    onPrimary();
                    context.pop();
                  },
                  icon: Icon(
                    Icons.photo_outlined,
                    color: Colors.orange[400],
                  ),
                  label: Text(
                    context.l10n.photos,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    onSecondary();
                    context.pop();
                  },
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.green[400],
                  ),
                  label: Text(
                    context.l10n.camera,
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          const Gap(
            24,
          ),
        ],
      ),
    );
  }
}

class DateChip extends StatelessWidget {
  const DateChip({
    required this.name,
    required this.isSelected,
    this.onSelected,
    super.key,
  });
  final String name;
  final bool isSelected;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: isSelected,
      label: Text(name),
      onSelected: onSelected,
    );
  }
}

class DateBottomSheet extends StatelessWidget {
  const DateBottomSheet({
    required this.fieldType,
    required this.displayDate,
    required this.onDateTimeChanged,
    this.initialDateTime,
    this.selectedChip,
    super.key,
  });

  final int? selectedChip;
  final DateFieldType fieldType;
  final DateTime? displayDate;
  final DateTime? initialDateTime;
  final void Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    final lastYear = DateTime.now().year + 100;
    final lastDate = DateTime(lastYear);

    final firstYear = DateTime.now().year - 100;
    final firstDate = DateTime(firstYear);
    void buildCupertinoDatePicker() {
      showModalBottomSheet<Widget>(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: onDateTimeChanged,
              maximumDate: lastDate,
              minimumDate: firstDate,
              initialDateTime: initialDateTime ?? DateTime.now(),
              minimumYear: firstYear,
              maximumYear: lastYear,
            ),
          );
        },
      );
    }

    Future<void> buildMaterialDatePicker() async {
      final datePicked = await showDatePicker(
        keyboardType: TextInputType.text,
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstDate,
        lastDate: lastDate,
      );
      if (datePicked != null && datePicked != DateTime.now()) {
        onDateTimeChanged(datePicked);
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

    Widget selectText() {
      return const Center(
        child: Text('Select'),
      );
    }

    Widget lifetimeField() {
      return Visibility(
        visible: selectedChip != 3,
        replacement: Align(
          child: Text(
            'Lifetime Warranty',
            style: context.textTheme.titleMedium,
          ),
        ),
        child: selectText(),
      );
    }

    return GestureDetector(
      onTap: selectDate,
      child: DateCard(
        date: displayDate,
        child: switch (fieldType) {
          DateFieldType.endOfWarranty => lifetimeField(),
          DateFieldType.purchaseDate => selectText(),
          DateFieldType.reminderDate => selectText(),
        },
      ),
    );
  }
}
