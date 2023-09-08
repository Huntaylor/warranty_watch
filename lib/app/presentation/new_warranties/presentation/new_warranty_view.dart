import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/new_warranties/presentation/widgets/image_bottom_sheet.dart';
import 'package:warranty_watch/app/widgets/warranty_checkbox.dart';
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
      create: (context) => WarrantyCubit(repo),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            /*    (state.warrantyState == WarrantyState.editing)
             ? l10n.editWarrantyTitle :  */
            l10n.addWarrantyTitle,
          ),
        ),
        body: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<WarrantyCubit, WarrantyState>(
      buildWhen: (_, state) {
        return state.isReady;
      },
      builder: (providerContext, state) {
        // TODO(huntaylor): refactor
        final popView = context;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        WarrantyTextField.general(
                          textFieldName: 'Product Name',
                          currentLength:
                              (state.asReady.warrantyInfo.name != null)
                                  ? state.asReady.warrantyInfo.name!.length
                                  : 0,
                          maxLength: 25,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          initialValue: state.asReady.warrantyInfo.name ?? '',
                          onChanged:
                              context.read<WarrantyCubit>().changeProductName,
                          hintText: l10n.productName,
                        ),
                        WarrantyTextField.date(
                          textFieldName: 'Date Purchased',
                          initialValue:
                              state.asReady.warrantyInfo.purchaseDate != null
                                  ? _dateFormat(
                                      state.asReady.warrantyInfo.purchaseDate!,
                                    )
                                  : _dateFormat(
                                      DateTime.now(),
                                    ),
                          isLifeTime: false,
                          endDateTime: DateTime.now(),
                          initialDateTime:
                              state.asReady.warrantyInfo.purchaseDate,
                          startDateTime: DateTime(2000),
                          onChanged:
                              context.read<WarrantyCubit>().changePurchaseDate,
                          hintText: l10n.purchaseDate,
                        ),
                        WarrantyTextField.webSite(
                          textFieldName: 'Warranty Website',
                          initialValue:
                              state.asReady.warrantyInfo.warrantyWebsite ??
                                  'https://',
                          onChanged:
                              context.read<WarrantyCubit>().changeWebsiteName,
                          hintText: l10n.companyWebsite,
                        ),
                        WarrantyTextField.date(
                          textFieldName: 'Warranty Duration',
                          initialValue:
                              state.asReady.warrantyInfo.endOfWarranty != null
                                  ? _dateFormat(
                                      state.asReady.warrantyInfo.endOfWarranty!,
                                    )
                                  : '',
                          isLifeTime: state.asReady.warrantyInfo.lifeTime,
                          endDateTime: DateTime(2050),
                          initialDateTime:
                              state.asReady.warrantyInfo.endOfWarranty,
                          startDateTime: DateTime.now(),
                          onChanged:
                              context.read<WarrantyCubit>().changeEndDate,
                          hintText: l10n.expirationDate,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WarrantyCheckBox(
                              isChecked: state.asReady.warrantyInfo.lifeTime,
                              text: l10n.lifeTime,
                              onTap:
                                  context.read<WarrantyCubit>().toggleLifeTime,
                            ),
                          ],
                        ),
                        if (state.asReady.warrantyInfo.lifeTime ||
                            state.asReady.warrantyInfo.endOfWarranty == null)
                          const SizedBox()
                        else
                          Column(
                            children: [
                              Row(
                                children: [
                                  Switch(
                                    value: state
                                        .asReady.warrantyInfo.wantsReminders,
                                    onChanged: (value) => context
                                        .read<WarrantyCubit>()
                                        .toggleWantsReminders(value: value),
                                  ),
                                  const Text('Reminder before expiration'),
                                ],
                              ),
                              if (state.asReady.warrantyInfo.wantsReminders)
                                WarrantyTextField.date(
                                  textFieldName: 'When should we remind you?',
                                  initialValue: _dateFormat(
                                    state.asReady.warrantyInfo.reminderDate!,
                                  ),
                                  isLifeTime:
                                      state.asReady.warrantyInfo.lifeTime,
                                  endDateTime:
                                      state.asReady.warrantyInfo.endOfWarranty,
                                  initialDateTime:
                                      state.asReady.warrantyInfo.reminderDate,
                                  startDateTime: DateTime.now(),
                                  onChanged: context
                                      .read<WarrantyCubit>()
                                      .changeEndDate,
                                  hintText: 'Reminder Date',
                                ),
                            ],
                          ),
                        WarrantyTextField.form(
                          textFieldName: 'Product or Service Description',
                          currentLength:
                              (state.asReady.warrantyInfo.details != null)
                                  ? state.asReady.warrantyInfo.details!.length
                                  : 0,
                          maxLength: 100,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          initialValue:
                              state.asReady.warrantyInfo.details ?? '',
                          onChanged: context
                              .read<WarrantyCubit>()
                              .changeAddtionalDetails,
                          hintText: l10n.additionalDetails,
                        ),
                        WarrantyImage(
                          image: state.asReady.warrantyInfo.receiptImage,
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
                                  onReceiptPhotoTap: () async {
                                    await providerContext
                                        .read<WarrantyCubit>()
                                        .changeReceiptPhotos();
                                    popView.pop();
                                  },
                                  onReceiptCameraTap: () async {
                                    await providerContext
                                        .read<WarrantyCubit>()
                                        .changeReceiptCamera();
                                    context.pop();
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
                        WarrantyImage(
                          image: state.asReady.warrantyInfo.image,
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
                                  onReceiptPhotoTap: () async {
                                    await providerContext
                                        .read<WarrantyCubit>()
                                        .changeProductPhotos();
                                    context.pop();
                                  },
                                  onReceiptCameraTap: () async {
                                    await providerContext
                                        .read<WarrantyCubit>()
                                        .changeProductCamera();
                                    context.pop();
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 15),
                  child: WarrantyElevatedButton.loading(
                    isLoading:
                        providerContext.watch<WarrantyCubit>().state.isLoading,
                    isEnabled:
                        providerContext.watch<WarrantyCubit>().verifyWarranty(),
                    onPressed: () async {
                      try {
                        await context.read<WarrantyCubit>().submitWarranty();
                        context.pop();
                      } catch (e) {
                        debugPrint('$e');
                      }
                    },
                    text: /*  (state.warrantyState == WarrantyState.editing)
                     ? l10n.editProductBtn :  */
                        l10n.addproductButton,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String _dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
