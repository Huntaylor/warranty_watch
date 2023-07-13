import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/widgets/image_bottom_sheet.dart';
import 'package:warranty_keeper/widgets/warranty_checkbox.dart';
import 'package:warranty_keeper/widgets/warranty_image_widget.dart';

class NewWarrantyView extends StatelessWidget {
  const NewWarrantyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: true,
            title: Text(
              (state.warrantyState == WarrantyState.editing) ? appLocalizations.editWarrantyTitle : appLocalizations.addWarrantyTitle,
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
                      currentLength: (state.name != null) ? state.name!.length : 0,
                      maxLength: 25,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      initialValue: state.name ?? '',
                      isRequired: true,
                      onChanged: context.read<NewWarrantyCubit>().changeProductName,
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
                      onChanged: context.read<NewWarrantyCubit>().changePurchaseDate,
                      hintText: appLocalizations.purchaseDate,
                    ),
                    WarrantyTextField.webSite(
                      isRequired: false,
                      initialValue: state.warrantyWebsite ?? 'https://',
                      onChanged: context.read<NewWarrantyCubit>().changeWebsiteName,
                      hintText: appLocalizations.companyWebsite,
                    ),
                    WarrantyTextField.date(
                      initialValue: state.endOfWarranty != null ? _dateFormat(state.endOfWarranty!) : '',
                      isRequired: true,
                      isLifeTime: state.lifeTime,
                      endDateTime: DateTime(2050),
                      initialDateTime: state.endOfWarranty,
                      startDateTime: DateTime.now(),
                      onChanged: context.read<NewWarrantyCubit>().changeEndDate,
                      hintText: appLocalizations.expirationDate,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WarrantyCheckBox(
                          isChecked: state.lifeTime,
                          text: appLocalizations.lifeTime,
                          onTap: context.read<NewWarrantyCubit>().toggleLifeTime,
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
                                      context.read<NewWarrantyCubit>().toggleWantsReminders(value);
                                    },
                                  ),
                                  const Text('Reminder before expiration'),
                                ],
                              ),
                              if (state.wantsReminders)
                                WarrantyTextField.date(
                                  initialValue: _dateFormat(state.reminderDate!),
                                  isRequired: true,
                                  isLifeTime: state.lifeTime,
                                  endDateTime: state.endOfWarranty,
                                  initialDateTime: state.reminderDate,
                                  startDateTime: DateTime.now(),
                                  onChanged: context.read<NewWarrantyCubit>().changeEndDate,
                                  hintText: 'Reminder Date',
                                ),
                            ],
                          ),
                    WarrantyTextField.form(
                      currentLength: (state.details != null) ? state.details!.length : 0,
                      maxLength: 100,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      initialValue: state.details ?? '',
                      onChanged: context.read<NewWarrantyCubit>().changeAddtionalDetails,
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
                                await context.read<NewWarrantyCubit>().changeReceiptPhotos();
                                context.pop();
                              },
                              onReceiptCameraTap: () async {
                                print('ON TAP');
                                await context.read<NewWarrantyCubit>().changeReceiptCamera();
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
                                await context.read<NewWarrantyCubit>().changeProductPhotos();
                                context.pop();
                              },
                              onReceiptCameraTap: () async {
                                print('ON TAP');
                                await context.read<NewWarrantyCubit>().changeProductCamera();
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
                isLoading: state.warrantyState == WarrantyState.loading,
                isEnabled: context.watch<NewWarrantyCubit>().verifyWarranty(),
                onPressed: () async {
                  try {
                    await context.read<NewWarrantyCubit>().submitWarranty().whenComplete(
                          () => context.pop(),
                        );
                  } catch (e) {
                    debugPrint('$e');
                  }
                },
                text: (state.warrantyState == WarrantyState.editing) ? appLocalizations.editProductBtn : appLocalizations.addproductButton,
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
