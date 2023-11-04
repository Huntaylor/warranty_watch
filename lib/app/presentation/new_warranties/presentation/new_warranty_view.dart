import 'package:gap/gap.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/new_warranties/presentation/widgets/image_bottom_sheet.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
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
      child: BlocBuilder<WarrantyCubit, WarrantyState>(
        buildWhen: (_, state) {
          return state.isReady;
        },
        builder: (providerContext, state) {
          return WarrantyBaseView(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                /*    (state.warrantyState == WarrantyState.editing)
                   ? l10n.editWarrantyTitle :  */
                l10n.addWarrantyTitle,
              ),
            ),
            children: [
              const Gap(20),
              const Text(
                'Add Product Image',
                textAlign: TextAlign.center,
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
                text: l10n.addPhoto,
                icon: const Icon(
                  Icons.camera_alt_outlined,
                ),
              ),
              const Gap(20),
              WarrantyTextField.general(
                textFieldName: 'Product Name',
                currentLength: (state.asReady.warrantyInfo.name != null)
                    ? state.asReady.warrantyInfo.name!.length
                    : 0,
                maxLength: 25,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                initialValue: state.asReady.warrantyInfo.name ?? '',
                onChanged:
                    providerContext.read<WarrantyCubit>().changeProductName,
                hintText: l10n.productName,
              ),
              WarrantyTextField.webSite(
                textFieldName: 'Warranty Website',
                initialValue:
                    state.asReady.warrantyInfo.warrantyWebsite ?? 'https://',
                onChanged:
                    providerContext.read<WarrantyCubit>().changeWebsiteName,
                hintText: l10n.companyWebsite,
              ),
              WarrantyTextField.date(
                textFieldName: 'Date Purchased',
                initialValue: state.asReady.warrantyInfo.purchaseDate != null
                    ? _dateFormat(
                        state.asReady.warrantyInfo.purchaseDate!,
                      )
                    : _dateFormat(
                        DateTime.now(),
                      ),
                isLifeTime: false,
                endDateTime: DateTime.now(),
                initialDateTime: state.asReady.warrantyInfo.purchaseDate,
                startDateTime: DateTime(2000),
                onChanged:
                    providerContext.read<WarrantyCubit>().changePurchaseDate,
                hintText: l10n.purchaseDate,
              ),
              WarrantyTextField.date(
                textFieldName: 'Warranty Duration',
                initialValue: state.asReady.warrantyInfo.endOfWarranty != null
                    ? _dateFormat(
                        state.asReady.warrantyInfo.endOfWarranty!,
                      )
                    : '',
                isLifeTime: state.asReady.warrantyInfo.lifeTime,
                endDateTime: DateTime(2050),
                initialDateTime: state.asReady.warrantyInfo.endOfWarranty,
                startDateTime: DateTime.now(),
                onChanged: providerContext.read<WarrantyCubit>().changeEndDate,
                hintText: l10n.expirationDate,
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
                      return const DateBottomSheet();
                    },
                  );
                },
              ),
              WarrantyCheckBox(
                isChecked: state.asReady.warrantyInfo.lifeTime,
                text: l10n.lifeTime,
                onTap: (value) => providerContext
                    .read<WarrantyCubit>()
                    .toggleLifeTime(value: value),
              ),
              if (state.asReady.warrantyInfo.lifeTime ||
                  state.asReady.warrantyInfo.endOfWarranty == null)
                const SizedBox()
              else
                Row(
                  children: [
                    Switch(
                      value: state.asReady.warrantyInfo.wantsReminders,
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
                  isLifeTime: state.asReady.warrantyInfo.lifeTime,
                  endDateTime: state.asReady.warrantyInfo.endOfWarranty,
                  initialDateTime: state.asReady.warrantyInfo.reminderDate,
                  startDateTime: DateTime.now(),
                  onChanged:
                      providerContext.read<WarrantyCubit>().changeEndDate,
                  hintText: 'Reminder Date',
                ),
              WarrantyTextField.form(
                textFieldName: 'Product or Service Description',
                currentLength: (state.asReady.warrantyInfo.details != null)
                    ? state.asReady.warrantyInfo.details!.length
                    : 0,
                maxLength: 100,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                initialValue: state.asReady.warrantyInfo.details ?? '',
                onChanged: providerContext
                    .read<WarrantyCubit>()
                    .changeAddtionalDetails,
                hintText: l10n.additionalDetails,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 15),
                child: WarrantyElevatedButton.loading(
                  isLoading:
                      providerContext.watch<WarrantyCubit>().state.isLoading,
                  isEnabled:
                      providerContext.watch<WarrantyCubit>().verifyWarranty(),
                  onPressed: () async {
                    providerContext.pop();
                    await providerContext
                        .read<WarrantyCubit>()
                        .submitWarranty();
                  },
                  text: /*  (state.warrantyState == WarrantyState.editing)
                           ? l10n.editProductBtn :  */
                      l10n.addproductButton,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

String _dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
