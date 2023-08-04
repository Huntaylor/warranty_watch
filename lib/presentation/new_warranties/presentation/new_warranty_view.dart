import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/warranties/warranties_cubit.dart';
import 'package:warranty_keeper/modules/cubit/warranty/warranty_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/widgets/image_bottom_sheet.dart';
import 'package:warranty_keeper/widgets/warranty_checkbox.dart';
import 'package:warranty_keeper/widgets/warranty_image_widget.dart';

class NewWarrantyView extends StatelessWidget {
  const NewWarrantyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<WarrantiesCubit>().dataRepository;

    final appLocalizations = context.appLocalizations;
    return BlocProvider(
      create: (context) => WarrantyCubit(repo),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text(
            /*    (state.warrantyState == WarrantyState.editing) ? appLocalizations.editWarrantyTitle :  */ appLocalizations
                .addWarrantyTitle,
          ),
        ),
        body: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;

    return BlocBuilder<WarrantyCubit, WarrantyState>(
      buildWhen: (_, state) {
        return state.isReady;
      },
      builder: (providerContext, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        WarrantyTextField.general(
                          currentLength:
                              (state.asReady.warrantyInfo.name != null)
                                  ? state.asReady.warrantyInfo.name!.length
                                  : 0,
                          maxLength: 25,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          initialValue: state.asReady.warrantyInfo.name ?? '',
                          isRequired: true,
                          onChanged:
                              context.read<WarrantyCubit>().changeProductName,
                          hintText: appLocalizations.productName,
                        ),
                        WarrantyTextField.date(
                          initialValue:
                              state.asReady.warrantyInfo.purchaseDate != null
                                  ? _dateFormat(
                                      state.asReady.warrantyInfo.purchaseDate!)
                                  : _dateFormat(
                                      DateTime.now(),
                                    ),
                          isRequired: false,
                          isLifeTime: false,
                          endDateTime: DateTime.now(),
                          initialDateTime:
                              state.asReady.warrantyInfo.purchaseDate,
                          startDateTime: DateTime(2000),
                          onChanged:
                              context.read<WarrantyCubit>().changePurchaseDate,
                          hintText: appLocalizations.purchaseDate,
                        ),
                        WarrantyTextField.webSite(
                          isRequired: false,
                          initialValue:
                              state.asReady.warrantyInfo.warrantyWebsite ??
                                  'https://',
                          onChanged:
                              context.read<WarrantyCubit>().changeWebsiteName,
                          hintText: appLocalizations.companyWebsite,
                        ),
                        WarrantyTextField.date(
                          initialValue:
                              state.asReady.warrantyInfo.endOfWarranty != null
                                  ? _dateFormat(
                                      state.asReady.warrantyInfo.endOfWarranty!)
                                  : '',
                          isRequired: true,
                          isLifeTime: state.asReady.warrantyInfo.lifeTime,
                          endDateTime: DateTime(2050),
                          initialDateTime:
                              state.asReady.warrantyInfo.endOfWarranty,
                          startDateTime: DateTime.now(),
                          onChanged:
                              context.read<WarrantyCubit>().changeEndDate,
                          hintText: appLocalizations.expirationDate,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WarrantyCheckBox(
                              isChecked: state.asReady.warrantyInfo.lifeTime,
                              text: appLocalizations.lifeTime,
                              onTap:
                                  context.read<WarrantyCubit>().toggleLifeTime,
                            ),
                          ],
                        ),
                        (state.asReady.warrantyInfo.lifeTime ||
                                state.asReady.warrantyInfo.endOfWarranty ==
                                    null)
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      Switch(
                                        value: state.asReady.warrantyInfo
                                            .wantsReminders,
                                        onChanged: (value) {
                                          context
                                              .read<WarrantyCubit>()
                                              .toggleWantsReminders(value);
                                        },
                                      ),
                                      const Text('Reminder before expiration'),
                                    ],
                                  ),
                                  if (state.asReady.warrantyInfo.wantsReminders)
                                    WarrantyTextField.date(
                                      initialValue: _dateFormat(state
                                          .asReady.warrantyInfo.reminderDate!),
                                      isRequired: true,
                                      isLifeTime:
                                          state.asReady.warrantyInfo.lifeTime,
                                      endDateTime: state
                                          .asReady.warrantyInfo.endOfWarranty,
                                      initialDateTime: state
                                          .asReady.warrantyInfo.reminderDate,
                                      startDateTime: DateTime.now(),
                                      onChanged: context
                                          .read<WarrantyCubit>()
                                          .changeEndDate,
                                      hintText: 'Reminder Date',
                                    ),
                                ],
                              ),
                        WarrantyTextField.form(
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
                          hintText: appLocalizations.additionalDetails,
                        ),
                        WarrantyImage(
                          image: state.asReady.warrantyInfo.receiptImage,
                          onTap: () {
                            showModalBottomSheet(
                              isDismissible: false,
                              enableDrag: false,
                              isScrollControlled: false,
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
                                    context.pop();
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
                          text: appLocalizations.addReceipt,
                          icon: const Icon(
                            Icons.list_alt_outlined,
                          ),
                        ),
                        WarrantyImage(
                          image: state.asReady.warrantyInfo.image,
                          onTap: () {
                            showModalBottomSheet(
                              enableDrag: false,
                              isScrollControlled: false,
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
                          text: appLocalizations.addPhoto,
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 15),
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
                    text: /*  (state.warrantyState == WarrantyState.editing) ? appLocalizations.editProductBtn :  */
                        appLocalizations.addproductButton,
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

_dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
