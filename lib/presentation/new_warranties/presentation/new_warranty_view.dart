import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/current_warranties/current_warranties_cubit.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
          builder: (context, state) {
            return Text(
              (state.warrantyState == WarrantyState.editing) ? appLocalizations.editWarrantyTitle : appLocalizations.addWarrantyTitle,
            );
          },
        ),
      ),
      body: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newWarrantyCubit = context.read<NewWarrantyCubit>();
    final currWarrantyCubit = context.read<CurrentWarrantiesCubit>();
    final authCubit = context.read<AuthCubit>();
    final appLocalizations = context.appLocalizations;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    WarrantyTextField.general(
                      currentLength: (newWarrantyCubit.state.name != null) ? newWarrantyCubit.state.name!.length : 0,
                      maxLength: 25,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      initialValue: newWarrantyCubit.state.name ?? '',
                      isRequired: true,
                      onChanged: newWarrantyCubit.changeProductName,
                      hintText: appLocalizations.productName,
                    ),
                    WarrantyTextField.date(
                      initialValue: newWarrantyCubit.state.purchaseDate != null
                          ? _dateFormat(newWarrantyCubit.state.purchaseDate!)
                          : _dateFormat(
                              DateTime.now(),
                            ),
                      isRequired: true,
                      isLifeTime: false,
                      endDateTime: DateTime.now(),
                      initialDateTime: newWarrantyCubit.state.purchaseDate,
                      startDateTime: DateTime(2000),
                      onChanged: newWarrantyCubit.changePurchaseDate,
                      hintText: appLocalizations.purchaseDate,
                    ),
                    WarrantyTextField.webSite(
                      initialValue: newWarrantyCubit.state.warrantyWebsite ?? 'https://',
                      isRequired: true,
                      onChanged: newWarrantyCubit.changeWebsiteName,
                      hintText: appLocalizations.companyWebsite,
                    ),
                    WarrantyTextField.date(
                      initialValue: newWarrantyCubit.state.endOfWarranty != null ? _dateFormat(newWarrantyCubit.state.endOfWarranty!) : '',
                      isRequired: true,
                      isLifeTime: newWarrantyCubit.state.lifeTime,
                      endDateTime: DateTime(2050),
                      initialDateTime: newWarrantyCubit.state.endOfWarranty,
                      startDateTime: DateTime.now(),
                      onChanged: newWarrantyCubit.changeEndDate,
                      hintText: appLocalizations.expirationDate,
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WarrantyCheckBox(
                              isChecked: state.lifeTime,
                              text: appLocalizations.lifeTime,
                              onTap: newWarrantyCubit.toggleLifeTime,
                            ),
                          ],
                        );
                      },
                    ),
                    (newWarrantyCubit.state.lifeTime || newWarrantyCubit.state.endOfWarranty == null)
                        ? const SizedBox()
                        : Column(
                            children: [
                              Row(
                                children: [
                                  Switch(
                                    value: newWarrantyCubit.state.wantsReminders,
                                    onChanged: (value) {
                                      newWarrantyCubit.toggleWantsReminders(value);
                                    },
                                  ),
                                  const Text('Reminder before expiration'),
                                ],
                              ),
                              if (newWarrantyCubit.state.wantsReminders)
                                WarrantyTextField.date(
                                  initialValue: _dateFormat(newWarrantyCubit.state.reminderDate!),
                                  isRequired: true,
                                  isLifeTime: newWarrantyCubit.state.lifeTime,
                                  endDateTime: newWarrantyCubit.state.endOfWarranty,
                                  initialDateTime: newWarrantyCubit.state.reminderDate,
                                  startDateTime: DateTime.now(),
                                  onChanged: newWarrantyCubit.changeEndDate,
                                  hintText: 'Reminder Date',
                                ),
                            ],
                          ),
                    WarrantyTextField.form(
                      currentLength: (newWarrantyCubit.state.details != null) ? newWarrantyCubit.state.details!.length : 0,
                      maxLength: 100,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      initialValue: newWarrantyCubit.state.details ?? '',
                      onChanged: newWarrantyCubit.changeAddtionalDetails,
                      hintText: appLocalizations.additionalDetails,
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      // buildWhen: (previous, current) {
                      //   return previous.receiptImage != current.receiptImage ||
                      //       previous.isLoading != current.isLoading;
                      // },
                      builder: (context, state) {
                        return WarrantyImage(
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
                                    // await newWarrantyCubit.loadingImage();
                                    await newWarrantyCubit.changeReceiptPhotos();
                                    Navigator.pop(context);
                                    await newWarrantyCubit.loadingImage();
                                  },
                                  onReceiptCameraTap: () async {
                                    await newWarrantyCubit.changeReceiptCamera();
                                    Navigator.pop(context);
                                    await newWarrantyCubit.loadingImage();
                                  },
                                );
                              },
                            );
                          },
                          text: appLocalizations.addReceipt,
                          icon: const Icon(
                            Icons.list_alt_outlined,
                          ),
                        );
                      },
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      // buildWhen: (previous, current) =>
                      //     previous.image != current.image,
                      builder: (context, state) {
                        return WarrantyImage(
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
                                    await newWarrantyCubit.changeProductPhotos();
                                    context.pop();
                                    await newWarrantyCubit.loadingImage();
                                  },
                                  onReceiptCameraTap: () async {
                                    await newWarrantyCubit.changeProductCamera();
                                    context.pop();
                                    await newWarrantyCubit.loadingImage();
                                  },
                                );
                              },
                            );
                          },
                          text: '${appLocalizations.addPhoto} ${appLocalizations.required}',
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                  child: WarrantyElevatedButton.loading(
                    isLoading: state.warrantyState == WarrantyState.loading,
                    isEnabled: newWarrantyCubit.verifyWarranty(),
                    onPressed: () async {
                      if (newWarrantyCubit.verifyWarranty()) {
                        try {
                          await newWarrantyCubit.changeEditing(WarrantyState.loading);
                          currWarrantyCubit.addOrEditWarranty(warrantyInfo: state, user: authCubit.state.asAuthenticated.user);
                          context.pop();
                          await newWarrantyCubit.changeEditing(WarrantyState.submitted);
                        } catch (e) {
                          debugPrint('$e');
                        }
                      }
                    },
                    text: (state.warrantyState == WarrantyState.editing) ? appLocalizations.editProductBtn : appLocalizations.addproductButton,
                  ),
                );
              },
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
