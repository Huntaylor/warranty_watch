// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gap/gap.dart';

import 'package:warranty_watch/app/app_library.dart';

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
    required this.stateValue,
    required this.onPress,
    required this.dateChips,
    super.key,
  });

  final List<Map<String, String>> dateChips;
  final int? stateValue;
  final void Function(int index) onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Center(
            child: Text(
              'Select an option',
              style: context.textTheme.titleMedium,
            ),
          ),
          const Divider(thickness: 2),
          const Gap(8),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 5,
            ),
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: dateChips.length,
            itemBuilder: (context, index) {
              final isSelected = stateValue == index || false;
              return DateChip(
                name: dateChips[index]['duration']!,
                isSelected: isSelected,
                onSelected: (value) {
                  onPress(index);
                },
              );
            },
          ),
          const Divider(thickness: 2),
          // const NumberWidget(),
          DatePickerDialog(
            firstDate: DateTime(1950),
            lastDate: DateTime(2050),
          ),
          const Gap(8),
          // const Divider(
          //   thickness: 2,
          //   endIndent: 50,
          //   indent: 50,
          // ),
          // const Gap(8),
          // WarrantyElevatedButton.general(
          //   isEnabled: true,
          //   onPressed: () {},
          //   text: 'Custom Date',
          // ),
        ],
      ),
    );
  }
}
