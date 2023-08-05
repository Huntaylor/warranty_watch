import 'package:jiffy/jiffy.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';
import 'package:warranty_keeper/presentation/warranty_details/widgets/details_image_card.dart';
import 'package:warranty_keeper/presentation/warranty_details/widgets/individual_detail.dart';

class WarrantyDetailsView extends StatelessWidget {
  const WarrantyDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<WarrantyDetailsCubit>();
    final appLocalizations = context.appLocalizations;
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Visibility(
                  visible: _isUrlValid(detailsCubit.state.imageUrl),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * .4,
                    width: double.infinity,
                    child: Image.network(
                      detailsCubit.state.imageUrl!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  replacement: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            context.colorScheme.secondaryContainer,
                            context.colorScheme.primaryContainer,
                            context.colorScheme.primary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height * .1,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: Text(appLocalizations.back),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 50,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: context.themeData.dialogBackgroundColor,
                    ),
                    child: Text(
                      detailsCubit.state.name!,
                    ),
                  ),
                ),
              ],
            ),
            const _Content(),
          ],
        ),
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
    final detailsCubit = context.watch<WarrantyDetailsCubit>();
    final appLocalizations = context.appLocalizations;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          (detailsCubit.state.lifeTime)
              ? Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(appLocalizations.lifeTime),
                )
              : Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      (_isExpired(detailsCubit.state.endOfWarranty!))
                          ? 'Warranty expired ${_expired(detailsCubit.state.endOfWarranty!)}'
                          : appLocalizations.expiresOn(
                              _countDown(detailsCubit.state.endOfWarranty!),
                              _dateFormat(detailsCubit.state.endOfWarranty!),
                            ),
                      style: TextStyle(
                        color: _dateDiff(detailsCubit.state.endOfWarranty!)
                            ? context.themeData.colorScheme.error
                            : null,
                      ),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: (detailsCubit.state.wantsReminders)
                ? Text(
                    appLocalizations.noReminderSet,
                  )
                : Text(
                    appLocalizations.remindsOn(
                      _countDown(detailsCubit.state.reminderDate!),
                      _dateFormat(detailsCubit.state.reminderDate!),
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
          if (detailsCubit.state.purchaseDate != null)
            Padding(
              padding: const EdgeInsets.only(top: .0),
              child: IndividualDetailWidget.general(
                detailType: appLocalizations.purchasedOn,
                detailContent: Text(
                  _dateFormat(detailsCubit.state.purchaseDate!),
                ),
              ),
            ),
          if (detailsCubit.state.details != null ||
              detailsCubit.state.details!.isNotEmpty)
            IndividualDetailWidget.general(
              detailType: appLocalizations.details,
              detailContent: Text(detailsCubit.state.details ?? ''),
            ),
          IndividualDetailWidget.general(
            detailType: appLocalizations.productWebsite,
            detailContent: GestureDetector(
              onTap: () => context
                  .read<WarrantyDetailsCubit>()
                  .launch(detailsCubit.state.warrantyWebsite!),
              child: Text(
                detailsCubit.state.warrantyWebsite!,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Visibility(
            replacement: const SizedBox.shrink(),
            visible: _isUrlValid(detailsCubit.state.receiptImageUrl),
            child: IndividualDetailWidget.general(
              detailContent: DetailsImageCard(
                url: detailsCubit.state.receiptImageUrl!,
              ),
              detailType: appLocalizations.receiptPhoto,
            ),
          ),
        ],
      ),
    );
  }
}

_countDown(DateTime expirationDate) {
  final expireTime = Jiffy.parseFromDateTime(expirationDate).fromNow();

  return expireTime;
}

_expired(DateTime expirationDate) {
  final jiffyExpirationDate = Jiffy.parseFromDateTime(expirationDate);
  final expireTime = Jiffy.now().from(jiffyExpirationDate);

  return expireTime;
}

bool _isExpired(DateTime expirationDate) =>
    _countDown(expirationDate).endsWith('ago');

bool _isUrlValid(String? url) {
  if (url == null) return false;
  return Uri.parse(url).isAbsolute;
}

_dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}

_dateDiff(DateTime date) {
  if (date.difference(DateTime.now()).inDays < 7) {
    return true;
  } else {
    return false;
  }
}
