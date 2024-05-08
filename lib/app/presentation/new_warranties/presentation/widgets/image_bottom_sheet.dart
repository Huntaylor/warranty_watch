// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

import 'package:warranty_watch/app/app_library.dart';

enum DateFieldType {
  endOfWarranty,
  purchaseDate,
  reminderDate,
}

class ImageBottomSheet extends StatelessWidget {
  const ImageBottomSheet({
    required this.onRemove,
    required this.onPrimary,
    required this.onSecondary,
    required this.hasImage,
    super.key,
  });

  final bool hasImage;
  final Future<void> Function() onPrimary;
  final void Function() onRemove;
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
                Flexible(
                  fit: FlexFit.tight,
                  child: TextButton(
                    onPressed: context.pop,
                    child: Text(context.l10n.cancel),
                  ),
                ),
                Text(
                  context.l10n.addItem.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                  ),
                ),
                const Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {
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
          if (hasImage)
            Center(
              child: TextButton.icon(
                label: const Text('Remove Image'),
                onPressed: () {
                  onRemove();
                  context.pop();
                },
                icon: Icon(
                  Icons.highlight_remove_rounded,
                  color: context.colorScheme.error,
                ),
              ),
            )
          else
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
    required this.onClearDate,
    this.initialDateTime,
    this.firstInitialDate,
    this.lastDate,
    this.selectedChip,
    super.key,
  });

  final int? selectedChip;
  final DateFieldType fieldType;
  final DateTime? displayDate;
  final DateTime? firstInitialDate;
  final DateTime? initialDateTime;
  final DateTime? lastDate;
  final void Function(DateTime) onDateTimeChanged;
  final void Function() onClearDate;

  @override
  Widget build(BuildContext context) {
    final lastYear = DateTime.now().year + 100;
    final lastDateDefault = DateTime(lastYear);

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
              maximumDate: lastDate ?? lastDateDefault,
              minimumDate: firstInitialDate ?? firstDate,
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
        initialDate: firstInitialDate ?? DateTime.now(),
        firstDate: firstInitialDate ?? firstDate,
        lastDate: lastDate ?? lastDateDefault,
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
        onPressed: onClearDate,
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

class DateCard extends StatelessWidget {
  const DateCard({
    required this.child,
    required this.date,
    required this.onPressed,
    super.key,
  });

  final Widget? child;
  final DateTime? date;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      height: 65,
      child: date != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(),
                ),
                Align(
                  child: Text(
                    dateFormat(
                      date ?? DateTime.now(),
                    ),
                    style: context.textTheme.titleMedium,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.remove_circle_outline_outlined,
                        color: context.colorScheme.error,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : child,
    );
  }
}
