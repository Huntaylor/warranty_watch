import 'package:gap/gap.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/new_warranties/presentation/widgets/image_bottom_sheet.dart';
import 'package:warranty_watch/app/widgets/save_box.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/app/widgets/warranty_image_widget.dart';
import 'package:warranty_watch/modules/cubit/warranties/warranties_cubit.dart';
import 'package:warranty_watch/modules/cubit/warranty/warranty_cubit.dart';

class NewWarrantyView extends StatelessWidget {
  const NewWarrantyView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<WarrantiesCubit>().dataRepository;

    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => WarrantyCubit(repo),
      child: BlocBuilder<WarrantyCubit, WarrantyState>(
        buildWhen: (_, state) {
          return state.isReady;
        },
        builder: (providerContext, state) {
          return BackButtonListener(
            onBackButtonPressed: () async {
              return true;
            },
            child: WarrantyBaseView(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () async {
                    await showAdaptiveDialog<bool>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => SaveBox(
                        continueEdits: () {
                          context.pop();
                        },
                        discard: () {
                          context.push(Paths.home.path);
                        },
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                centerTitle: true,
                title: Text(
                  /*    (state.warrantyState == WarrantyState.editing)
                         ? l10n.editWarrantyTitle :  */
                  l10n.addWarrantyTitle.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                  ),
                ),
              ),
              children: [
                const Gap(20),
                const Text(
                  'Add Product Image',
                  textAlign: TextAlign.center,
                ),
                WarrantyImage(
                  image: state.asReady.warrantyInfo.image,
                  onTap: () {
                    showModalBottomSheet<Widget>(
                      isDismissible: false,
                      enableDrag: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                            25,
                          ),
                        ),
                      ),
                      context: providerContext,
                      builder: (_) {
                        return ImageBottomSheet(
                          onPrimary: () async {
                            await providerContext
                                .read<WarrantyCubit>()
                                .changeProductPhotos();
                          },
                          onSecondary: () async {
                            await providerContext
                                .read<WarrantyCubit>()
                                .changeProductCamera();
                          },
                        );
                      },
                    );
                  },
                  text: l10n.addReceipt,
                  icon: const Icon(
                    Icons.list_alt_outlined,
                  ),
                ),
                const Gap(20),
                const Text(
                  'Add Reciept Image',
                  textAlign: TextAlign.center,
                ),
                WarrantyImage(
                  image: state.asReady.warrantyInfo.receiptImage,
                  onTap: () {
                    showModalBottomSheet<Widget>(
                      enableDrag: false,
                      isDismissible: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                            25,
                          ),
                        ),
                      ),
                      context: providerContext,
                      builder: (_) {
                        return ImageBottomSheet(
                          onPrimary: () async {
                            await providerContext
                                .read<WarrantyCubit>()
                                .changeReceiptPhotos();
                          },
                          onSecondary: () async {
                            await providerContext
                                .read<WarrantyCubit>()
                                .changeReceiptCamera();
                          },
                        );
                      },
                    );
                  },
                  text: l10n.addPhoto,
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
                const Gap(20),
                WarrantyTextField.general(
                  textFieldName: 'Product Name*',
                  currentLength: (state.asReady.warrantyInfo.name != null)
                      ? state.asReady.warrantyInfo.name!.length
                      : 0,
                  maxLength: 25,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  initialValue: state.asReady.warrantyInfo.name ?? '',
                  onChanged:
                      providerContext.read<WarrantyCubit>().changeProductName,
                  hintText: l10n.typeHere,
                ),
                WarrantyTextField.webSite(
                  textFieldName: 'Warranty Website',
                  initialValue:
                      state.asReady.warrantyInfo.warrantyWebsite ?? '',
                  onChanged:
                      providerContext.read<WarrantyCubit>().changeWebsiteName,
                  hintText: l10n.typeHere,
                  helperText: state.asReady.warrantyInfo.warrantyWebsite != null
                      ? 'https://${state.asReady.warrantyInfo.warrantyWebsite}'
                      : null,
                ),
                const Center(
                  child: Text(
                    'Date Purchased',
                  ),
                ),
                const Gap(5),
                GestureDetector(
                  onTap: () async {},
                  child: DateCard(
                    date: state.asReady.warrantyInfo.purchaseDate,
                    child: const Center(
                      child: Text('Select'),
                    ),
                  ),
                ),
                const Gap(15),
                const Center(
                  child: Text(
                    'Warranty Duration*',
                  ),
                ),
                const Gap(5),
                BlocBuilder<WarrantyCubit, WarrantyState>(
                  buildWhen: (_, state) {
                    return state.isReady;
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () async {
                        await showModalBottomSheet<Widget>(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                25,
                              ),
                            ),
                          ),
                          context: providerContext,
                          builder: (_) {
                            return DateBottomSheet(
                              dateChips: state.asReady.dateChips,
                              stateValue: state.asReady.selectedChip,
                              onPress: (index) {
                                providerContext
                                    .read<WarrantyCubit>()
                                    .changeEndDateChips(index: index);
                                context.pop();
                              },
                            );
                          },
                        );
                      },
                      child: DateCard(
                        date: state.asReady.warrantyInfo.endOfWarranty,
                        child: Visibility(
                          visible: state.asReady.selectedChip != 3,
                          replacement: Align(
                            child: Text(
                              'Lifetime Warranty',
                              style: context.textTheme.titleMedium,
                            ),
                          ),
                          child: const Center(
                            child: Text('Select'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Gap(15),
                if (state.asReady.warrantyInfo.lifetime ||
                    state.asReady.warrantyInfo.endOfWarranty == null)
                  const SizedBox()
                else
                  Row(
                    children: [
                      Switch(
                        value: state.asReady.warrantyInfo.wantsReminders,
                        onChanged: (value) => providerContext
                            .read<WarrantyCubit>()
                            .toggleWantsReminders(value: value),
                      ),
                      const Text('Reminder before expiration'),
                    ],
                  ),
                AnimatedSwitcher(
                  transitionBuilder: (child, animation) {
                    late final offsetAnimation = Tween<Offset>(
                      begin: const Offset(1.5, 0),
                      end: Offset.zero,
                    ).animate(animation);
                    return SizeTransition(
                      sizeFactor: animation,
                      child: SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      ),
                    );
                  },
                  duration: const Duration(milliseconds: 150),
                  child: (state.asReady.warrantyInfo.wantsReminders)
                      ? WarrantyTextField.date(
                          textFieldName: 'When should we remind you?',
                          initialValue: dateFormat(
                            state.asReady.warrantyInfo.reminderDate!,
                          ),
                          isLifetime: state.asReady.warrantyInfo.lifetime,
                          endDateTime: state.asReady.warrantyInfo.endOfWarranty,
                          initialDateTime:
                              state.asReady.warrantyInfo.reminderDate,
                          startDateTime: DateTime.now(),
                          onChanged: providerContext
                              .read<WarrantyCubit>()
                              .changeReminderDate,
                          hintText: 'Reminder Date',
                        )
                      : const SizedBox(),
                ),
                WarrantyTextField.form(
                  textFieldName: 'Product or Service Description',
                  currentLength: (state.asReady.warrantyInfo.details != null)
                      ? state.asReady.warrantyInfo.details!.length
                      : 0,
                  initialValue: state.asReady.warrantyInfo.details ?? '',
                  onChanged: providerContext
                      .read<WarrantyCubit>()
                      .changeAddtionalDetails,
                  hintText: l10n.typeHere,
                ),
                const Gap(4),
                const Text(
                  '* Required fields',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 15),
                  child: WarrantyElevatedButton.loading(
                    isLoading:
                        providerContext.watch<WarrantyCubit>().state.isLoading,
                    isEnabled:
                        providerContext.watch<WarrantyCubit>().verifyWarranty(),
                    onPressed: () async {
                      await providerContext
                          .read<WarrantyCubit>()
                          .submitWarranty()
                          .whenComplete(
                            () => context.pop(),
                          );
                    },
                    text: /*  (state.warrantyState == WarrantyState.editing)
                                 ? l10n.editProductBtn :  */
                        l10n.addproductButton,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DateCard extends StatelessWidget {
  const DateCard({
    required this.child,
    required this.date,
    super.key,
  });

  final Widget? child;
  final DateTime? date;

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
          ? Align(
              child: Text(
                dateFormat(
                  date ?? DateTime.now(),
                ),
                style: context.textTheme.titleMedium,
              ),
            )
          : child,
    );
  }
}
