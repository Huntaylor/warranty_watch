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
              //TODO change for edit warranty
              appLocalizations.addWarrantyTitle,
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
    final cubitRead = context.read<NewWarrantyCubit>();
    final currentRead = context.read<CurrentWarrantiesCubit>();
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
                      initialValue: cubitRead.state.name ?? '',
                      isRequired: true,
                      onChanged: cubitRead.changeProductName,
                      hintText: appLocalizations.productName,
                    ),
                    WarrantyTextField.date(
                      initialValue: cubitRead.state.purchaseDate != null
                          ? '${_dateFormat(cubitRead.state.purchaseDate!)}'
                          : '${_dateFormat(DateTime.now())}',
                      isRequired: true,
                      isLifeTime: false,
                      endDateTime: DateTime(2050),
                      initialDateTime: DateTime.now(),
                      startDateTime: DateTime(2000),
                      onChanged: cubitRead.changePurchaseDate,
                      hintText: appLocalizations.purchaseDate,
                    ),
                    WarrantyTextField.webSite(
                      initialValue: cubitRead.state.warrWebsite ?? '',
                      isRequired: true,
                      onChanged: cubitRead.changeWebsiteName,
                      hintText: appLocalizations.companyWebsite,
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      buildWhen: (previous, current) =>
                          previous.lifeTime != current.lifeTime,
                      builder: (context, state) {
                        return WarrantyTextField.date(
                          initialValue: cubitRead.state.endOfWarr != null
                              ? '${_dateFormat(cubitRead.state.endOfWarr!)}'
                              : '',
                          isRequired: true,
                          isLifeTime: state.lifeTime,
                          endDateTime: DateTime(2050),
                          initialDateTime: DateTime.now(),
                          startDateTime: DateTime.now(),
                          onChanged: cubitRead.changeEndDate,
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
                          onTap: cubitRead.toggleLifeTime,
                        );
                      },
                    ),
                    WarrantyTextField.form(
                      initialValue: cubitRead.state.details ?? '',
                      onChanged: cubitRead.changeAddtionalDetails,
                      hintText: appLocalizations.additionalDetails,
                    ),
                    BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
                      buildWhen: (previous, current) =>
                          previous.receiptImage != current.receiptImage,
                      builder: (context, state) {
                        return WarrantyImage(
                          file: state.receiptImage,
                          onTap: cubitRead.changeImagereceipt,
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
                          onTap: cubitRead.changeImage,
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
                    isEnabled: cubitRead.addWarranty(),
                    onPressed: () {
                      if (cubitRead.addWarranty()) {
                        navCubit.appNavigator.pop();
                        //TODO change for edit warranty
                        currentRead.addWarranty(state);
                        currentRead.saveEdits(state);
                        context.read<NewWarrantyCubit>().clear();
                      }
                    },
                    //TODO change for edit warranty
                    text: appLocalizations.addproductButton,
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
