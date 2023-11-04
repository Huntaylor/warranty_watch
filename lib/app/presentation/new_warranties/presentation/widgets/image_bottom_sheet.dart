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
                Text(context.l10n.addItem),
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
          Flexible(
            child: /*  state.warrantyState == WarrantyState.loadingImage
                ? const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                :  */
                Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    onPrimary();
                    context.pop();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo_outlined,
                        color: Colors.orange[400],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(context.l10n.photos),
                    ],
                  ),
                ),
                const Gap(
                  16,
                ),
                GestureDetector(
                  onTap: () {
                    onSecondary();
                    context.pop();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.green[400],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(context.l10n.camera),
                    ],
                  ),
                ),
              ],
            ),
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
    required this.duration,
    this.onSelected,
    super.key,
  });
  final String name;
  final DateTime duration;
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dateChips = [
      {
        String: '30 Days',
        int: 30,
      },
      {
        String: '1 Year',
      },
      {
        String: '5 Years',
      },
      {
        String: 'Lifetime',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: dateChips.length,
            itemBuilder: (context, index) {
              return DateChip(
                name: dateChips[index][String]! as String,
                isSelected: false,
                duration: DateTime.now(),
              );
            },
          ),
          WarrantyElevatedButton.general(
            isEnabled: true,
            onPressed: () {},
            text: 'Custom Date',
          ),
        ],
      ),
    );
  }
}
