import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/warranty/warranty_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/widgets/image_bottom_sheet.dart';
import 'package:warranty_keeper/widgets/warranty_checkbox.dart';
import 'package:warranty_keeper/widgets/warranty_image_widget.dart';

class NewWarrantyView extends StatelessWidget {
  const NewWarrantyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return BlocBuilder<WarrantyCubit, WarrantyInfo>(
      builder: (context, state) {
        return Scaffold(
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
          body: _Content(
            state: state,
          ),
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  final WarrantyInfo state;
  const _Content({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;

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
                          (state.name != null) ? state.name!.length : 0,
                      maxLength: 25,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      initialValue: state.name ?? '',
                      isRequired: true,
                      onChanged:
                          context.read<WarrantyCubit>().changeProductName,
                      hintText: appLocalizations.productName,
                    ),
                    WarrantyTextField.date(
                      initialValue: state.purchaseDate != null
                          ? _dateFormat(state.purchaseDate!)
                          : _dateFormat(
                              DateTime.now(),
                            ),
                      isRequired: false,
                      isLifeTime: false,
                      endDateTime: DateTime.now(),
                      initialDateTime: state.purchaseDate,
                      startDateTime: DateTime(2000),
                      onChanged:
                          context.read<WarrantyCubit>().changePurchaseDate,
                      hintText: appLocalizations.purchaseDate,
                    ),
                    WarrantyTextField.webSite(
                      isRequired: false,
                      initialValue: state.warrantyWebsite ?? 'https://',
                      onChanged:
                          context.read<WarrantyCubit>().changeWebsiteName,
                      hintText: appLocalizations.companyWebsite,
                    ),
                    WarrantyTextField.date(
                      initialValue: state.endOfWarranty != null
                          ? _dateFormat(state.endOfWarranty!)
                          : '',
                      isRequired: true,
                      isLifeTime: state.lifeTime,
                      endDateTime: DateTime(2050),
                      initialDateTime: state.endOfWarranty,
                      startDateTime: DateTime.now(),
                      onChanged: context.read<WarrantyCubit>().changeEndDate,
                      hintText: appLocalizations.expirationDate,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WarrantyCheckBox(
                          isChecked: state.lifeTime,
                          text: appLocalizations.lifeTime,
                          onTap: context.read<WarrantyCubit>().toggleLifeTime,
                        ),
                      ],
                    ),
                    (state.lifeTime || state.endOfWarranty == null)
                        ? const SizedBox()
                        : Column(
                            children: [
                              Row(
                                children: [
                                  Switch(
                                    value: state.wantsReminders,
                                    onChanged: (value) {
                                      context
                                          .read<WarrantyCubit>()
                                          .toggleWantsReminders(value);
                                    },
                                  ),
                                  const Text('Reminder before expiration'),
                                ],
                              ),
                              if (state.wantsReminders)
                                WarrantyTextField.date(
                                  initialValue:
                                      _dateFormat(state.reminderDate!),
                                  isRequired: true,
                                  isLifeTime: state.lifeTime,
                                  endDateTime: state.endOfWarranty,
                                  initialDateTime: state.reminderDate,
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
                          (state.details != null) ? state.details!.length : 0,
                      maxLength: 100,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      initialValue: state.details ?? '',
                      onChanged:
                          context.read<WarrantyCubit>().changeAddtionalDetails,
                      hintText: appLocalizations.additionalDetails,
                    ),
                    WarrantyImage(
                      image: state.receiptImage,
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
                          context: context,
                          builder: (context) {
                            return ImageBottomSheet(
                              onReceiptPhotoTap: () async {
                                print('ON TAP');
                                await context
                                    .read<WarrantyCubit>()
                                    .changeReceiptPhotos();
                                context.pop();
                              },
                              onReceiptCameraTap: () async {
                                print('ON TAP');
                                await context
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
                      image: state.image,
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
                          context: context,
                          builder: (context) {
                            return ImageBottomSheet(
                              onReceiptPhotoTap: () async {
                                print('ON TAP');
                                await context
                                    .read<WarrantyCubit>()
                                    .changeProductPhotos();
                                context.pop();
                              },
                              onReceiptCameraTap: () async {
                                print('ON TAP');
                                await context
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
                isLoading: false,
                // isLoading: state.warrantyState == WarrantyState.loading,
                isEnabled: context.watch<WarrantyCubit>().verifyWarranty(),
                onPressed: () async {
                  try {
                    await context
                        .read<WarrantyCubit>()
                        .submitWarranty()
                        .whenComplete(
                          () => context.pop(),
                        );
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
  }
}

_dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
