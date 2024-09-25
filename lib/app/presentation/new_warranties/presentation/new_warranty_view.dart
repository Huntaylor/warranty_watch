import 'package:gap/gap.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/data/repositories/warranty_repository.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_watch/app/presentation/new_warranties/presentation/widgets/image_bottom_sheet.dart';
import 'package:warranty_watch/app/widgets/save_box.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/app/widgets/warranty_image_widget.dart';
import 'package:warranty_watch/cubit/warranties/warranties_cubit.dart';
import 'package:warranty_watch/cubit/warranty/warranty_cubit.dart';

class NewWarrantyView extends StatelessWidget {
  const NewWarrantyView({super.key, this.warrantyInfo});

  final WarrantyInfo? warrantyInfo;

  @override
  Widget build(BuildContext context) {
    var isEditting = false;
    if (warrantyInfo != null) {
      isEditting = true;
    }
    final repo = context.watch<WarrantiesCubit>().dataRepository;

    final l10n = context.l10n;
    return RepositoryProvider<DataRepository>(
      create: (context) => DataRepository(),
      child: BlocProvider(
        create: (_) => WarrantyCubit(repo, warrantyInfo: warrantyInfo),
        child: BlocListener<WarrantyCubit, WarrantyState>(
          listener: (context, state) {
            if (state.isSuccessful) {
              context.pop();
            }
            if (state.isReady) {
              if (!state.asReady.isNotificationEnabled &&
                  state.asReady.warrantyInfo.reminderDate != null &&
                  !state.asReady.askedNotification) {
                context.read<WarrantyCubit>().askedNotifications();
                showAdaptiveDialog<NotificationBox>(
                  context: context,
                  builder: (_) {
                    return NotificationBox(
                      enableNotifications: () {
                        context
                          ..pop()
                          ..read<WarrantyCubit>().toggleNotifications();
                      },
                      cancel: () => context.pop(),
                    );
                  },
                );
              }

              final readyState = state.asReady;
              final firebaseError = readyState.firebaseError;

              if (firebaseError ?? false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    showCloseIcon: true,
                    backgroundColor: context.colorScheme.error,
                    content: Text(
                      'There was an issue with your submission.',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                );
                context.read<WarrantyCubit>().closeError();
              } else if (readyState.hasError ?? false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    showCloseIcon: true,
                    backgroundColor: context.colorScheme.error,
                    content: Text(
                      'There was an issue getting your image. Please try again or use a different image.',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                );
                context.read<WarrantyCubit>().closeError();
              }
            }
          },
          child: BlocBuilder<WarrantyCubit, WarrantyState>(
            buildWhen: (_, state) => state.isReady,
            builder: (providerContext, state) {
              final warrantyDurationChips = state.asReady.warrantyDurationChips;
              final reminderChips = state.asReady.reminderChips;
              final warrantyDateChip = state.asReady.selectedWarrantyDateChip;
              final reminderDateChip = state.asReady.selectedReminderDateChip;

              return BackButtonListener(
                onBackButtonPressed: () async => true,
                child: WarrantyBaseView(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () async => showAdaptiveDialog<bool>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) => SaveBox(
                          continueEdits: context.pop,
                          discard: () => context.push(Paths.home.path),
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    centerTitle: true,
                    title: Text(
                      isEditting
                          ? l10n.editWarrantyTitle
                          : l10n.addWarrantyTitle.toUpperCase(),
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
                      onTap: () => showModalBottomSheet<Widget>(
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
                            hasImage: state.asReady.warrantyInfo.image != null,
                            onRemove: providerContext
                                .read<WarrantyCubit>()
                                .removeProductImage,
                            onPrimary: () async => providerContext
                                .read<WarrantyCubit>()
                                .changeFile(fileTarget: FileTarget.product),
                            onSecondary: () async => providerContext
                                .read<WarrantyCubit>()
                                .changeImage(fileTarget: FileTarget.product),
                          );
                        },
                      ),
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
                      onTap: () => showModalBottomSheet<Widget>(
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
                        builder: (_) => ImageBottomSheet(
                          hasImage:
                              state.asReady.warrantyInfo.receiptImage != null,
                          onRemove: () => providerContext
                              .read<WarrantyCubit>()
                              .removeRecieptImage(),
                          onPrimary: () async => providerContext
                              .read<WarrantyCubit>()
                              .changeFile(fileTarget: FileTarget.receipt),
                          onSecondary: () async => providerContext
                              .read<WarrantyCubit>()
                              .changeImage(fileTarget: FileTarget.receipt),
                        ),
                      ),
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
                      maxLength: 50,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      initialValue: state.asReady.warrantyInfo.name ?? '',
                      onChanged: providerContext
                          .read<WarrantyCubit>()
                          .changeProductName,
                      hintText: l10n.typeHere,
                    ),
                    WarrantyTextField.webSite(
                      textFieldName: 'Warranty Website',
                      initialValue:
                          state.asReady.warrantyInfo.warrantyWebsite ?? '',
                      onChanged: providerContext
                          .read<WarrantyCubit>()
                          .changeWebsiteName,
                      hintText: l10n.typeHere,
                      helperText: state.asReady.warrantyInfo.warrantyWebsite !=
                              null
                          ? 'https://${state.asReady.warrantyInfo.warrantyWebsite}'
                          : null,
                    ),
                    const Center(
                      child: Text(
                        'Date Purchased',
                      ),
                    ),
                    const Gap(5),
                    BlocBuilder<WarrantyCubit, WarrantyState>(
                      buildWhen: (_, state) => state.isReady,
                      builder: (context, state) => DateBottomSheet(
                        lastDate: DateTime.now(),
                        onClearDate: providerContext
                            .read<WarrantyCubit>()
                            .clearPurchaseDate,
                        fieldType: DateFieldType.purchaseDate,
                        displayDate: state.asReady.warrantyInfo.purchaseDate,
                        onDateTimeChanged: providerContext
                            .read<WarrantyCubit>()
                            .changePurchaseDate,
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
                      buildWhen: (_, state) => state.isReady,
                      builder: (context, state) => DateBottomSheet(
                        onClearDate: providerContext
                            .read<WarrantyCubit>()
                            .clearEndOfWarrantyDate,
                        firstInitialDate:
                            state.asReady.warrantyInfo.purchaseDate,
                        fieldType: DateFieldType.endOfWarranty,
                        selectedChip: state.asReady.selectedWarrantyDateChip,
                        displayDate: state.asReady.warrantyInfo.endOfWarranty,
                        onDateTimeChanged: providerContext
                            .read<WarrantyCubit>()
                            .changeEndOfWarrantyDate,
                      ),
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 2,
                      ),
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: warrantyDurationChips.length,
                      itemBuilder: (context, index) {
                        final isSelected = warrantyDateChip == index || false;
                        return DateChip(
                          name: warrantyDurationChips[index]['duration']!,
                          isSelected: isSelected,
                          onSelected: (value) => providerContext
                              .read<WarrantyCubit>()
                              .changeEndDateChips(index: index),
                        );
                      },
                    ),
                    const Gap(15),
                    _ReminderWidget(
                      chipIndex: reminderDateChip,
                      reminderChips: reminderChips,
                    ),
                    WarrantyTextField.form(
                      textFieldName: 'Product or Service Description',
                      currentLength:
                          (state.asReady.warrantyInfo.details != null)
                              ? state.asReady.warrantyInfo.details!.length
                              : 0,
                      initialValue: state.asReady.warrantyInfo.details ?? '',
                      onChanged: providerContext
                          .read<WarrantyCubit>()
                          .changeAddtionalDetails,
                      hintText: l10n.typeHere,
                    ),
                    const Gap(4),
                    Text(
                      '* Required fields',
                      style: context.textTheme.bodySmall!
                          .copyWith(color: context.colorScheme.error),
                    ),
                    BlocBuilder<WarrantyCubit, WarrantyState>(
                      buildWhen: (_, state) => state.isReady,
                      builder: (context, state) {
                        final isEnabled = state.asReady.canSubmit ?? false;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 15),
                          child: WarrantyElevatedButton.loading(
                            isLoading: state.asReady.isLoading ?? false,
                            isEnabled: isEnabled,
                            onPressed: () async => providerContext
                                .read<WarrantyCubit>()
                                .submitWarranty(),
                            text: isEditting
                                ? l10n.editProductBtn
                                : l10n.addproductButton,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ReminderWidget extends StatelessWidget {
  const _ReminderWidget({
    required this.chipIndex,
    required this.reminderChips,
  });

  final List<Map<String, String>> reminderChips;
  final int? chipIndex;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WarrantyCubit, WarrantyState>(
        buildWhen: (_, state) => state.isReady,
        builder: (context, state) => AnimatedSwitcher(
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
          child: (!state.asReady.warrantyInfo.lifetime &&
                  state.asReady.warrantyInfo.endOfWarranty != null)
              ? Column(
                  children: [
                    const Center(
                      child: Text(
                        'When should we remind you?',
                      ),
                    ),
                    const Gap(5),
                    DateBottomSheet(
                      onClearDate:
                          context.read<WarrantyCubit>().clearReminderDate,
                      firstInitialDate: DateTime.now().add(
                        const Duration(days: 1),
                      ),
                      fieldType: DateFieldType.reminderDate,
                      selectedChip: state.asReady.selectedReminderDateChip,
                      displayDate: state.asReady.warrantyInfo.reminderDate,
                      onDateTimeChanged: (date) =>
                          context.read<WarrantyCubit>().changeReminderDate(
                                date,
                                withChips: false,
                              ),
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 2,
                      ),
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reminderChips.length,
                      itemBuilder: (context, index) {
                        final isSelected = chipIndex == index || false;
                        return DateChip(
                          name: reminderChips[index]['duration']!,
                          isSelected: isSelected,
                          onSelected: (value) => context
                              .read<WarrantyCubit>()
                              .changeReminderChips(index: index),
                        );
                      },
                    ),
                    const Gap(15),
                  ],
                )
              : const SizedBox(),
        ),
      );
}
