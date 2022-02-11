import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/bloc/cubit/current_warranties_cubit.dart';
import 'package:warranty_keeper/modules/bloc/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warrenty_info.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';
import 'package:warranty_keeper/widgets/warranty_checkbox.dart';
import 'package:warranty_keeper/widgets/warranty_image.dart';
import 'package:warranty_keeper/widgets/warranty_textfield.dart';

class NewWarrantyView extends StatelessWidget {
  static const routeName = '/newWarrantyView';
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
              (state.isEditing)
                  ? appLocalizations.editWarrantyTitle
                  : appLocalizations.addWarrantyTitle,
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
    final navCubit = context.read<NavCubit>();
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
                      initialValue: newWarrantyCubit.state.name ?? '',
                      isRequired: true,
                      onChanged: newWarrantyCubit.changeProductName,
                      hintText: appLocalizations.productName,
                    ),
                    WarrantyTextField.date(
                      initialValue: newWarrantyCubit.state.purchaseDate != null
                          ? '${_dateFormat(newWarrantyCubit.state.purchaseDate!)}'
                          : '${_dateFormat(DateTime.now())}',
                      isRequired: true,
                      isLifeTime: false,
                      endDateTime: DateTime(2050),
                      initialDateTime: DateTime.now(),
                      startDateTime: DateTime(2000),
                      onChanged: newWarrantyCubit.changePurchaseDate,
                      hintText: appLocalizations.purchaseDate,
                    ),
                    WarrantyTextField.webSite(
                      initialValue: newWarrantyCubit.state.warrWebsite ?? '',
                      isRequired: true,
                      onChanged: newWarrantyCubit.changeWebsiteName,
                      hintText: appLocalizations.companyWebsite,
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      buildWhen: (previous, current) =>
                          previous.lifeTime != current.lifeTime,
                      builder: (context, state) {
                        return WarrantyTextField.date(
                          initialValue: newWarrantyCubit.state.endOfWarr != null
                              ? '${_dateFormat(newWarrantyCubit.state.endOfWarr!)}'
                              : '',
                          isRequired: true,
                          isLifeTime: state.lifeTime,
                          endDateTime: DateTime(2050),
                          initialDateTime: DateTime.now(),
                          startDateTime: DateTime.now(),
                          onChanged: newWarrantyCubit.changeEndDate,
                          hintText: appLocalizations.expirationDate,
                        );
                      },
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      buildWhen: (previous, current) =>
                          previous.lifeTime != current.lifeTime,
                      builder: (context, state) {
                        return WarrantyCheckBox(
                          isChecked: state.lifeTime,
                          text: appLocalizations.lifeTime,
                          onTap: newWarrantyCubit.toggleLifeTime,
                        );
                      },
                    ),
                    WarrantyTextField.form(
                      initialValue: newWarrantyCubit.state.details ?? '',
                      onChanged: newWarrantyCubit.changeAddtionalDetails,
                      hintText: appLocalizations.additionalDetails,
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      buildWhen: (previous, current) =>
                          previous.receiptImage != current.receiptImage,
                      builder: (context, state) {
                        return WarrantyImage(
                          file: state.receiptImage,
                          onTap: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                    25,
                                  ),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text('Cancel'),
                                            Text('Add Item'),
                                            SizedBox(
                                              width: 40,
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 24,
                                          thickness: 2,
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: newWarrantyCubit
                                                    .changePhotosreceipt,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.photo_outlined,
                                                      color: Colors.orange[400],
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    const Text('Photos'),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              GestureDetector(
                                                onTap: newWarrantyCubit
                                                    .changeImagereceipt,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: Colors.green[400],
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    const Text('Camera'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            // newWarrantyCubit.changeImagereceipt();
                          },
                          text: appLocalizations.addReceipt,
                          icon: const Icon(
                            Icons.list_alt_outlined,
                          ),
                        );
                      },
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      buildWhen: (previous, current) =>
                          previous.image != current.image,
                      builder: (context, state) {
                        return WarrantyImage(
                          file: state.image,
                          onTap: () {
                            newWarrantyCubit.changeCameraImage();
                          },
                          text:
                              '${appLocalizations.addPhoto} ${appLocalizations.required}',
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
                  child: WarrantyElevatedButton(
                    isEnabled: newWarrantyCubit.verifyWarranty(),
                    onPressed: () async {
                      if (newWarrantyCubit.verifyWarranty()) {
                        newWarrantyCubit.changeEditing();
                        currWarrantyCubit.addOrEditWarranty(state);
                        newWarrantyCubit.clear();
                        navCubit.appNavigator.pop();
                      }
                    },
                    text: (state.isEditing)
                        ? appLocalizations.editProductBtn
                        : appLocalizations.addproductButton,
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
