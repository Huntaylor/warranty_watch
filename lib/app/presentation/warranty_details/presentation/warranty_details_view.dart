import 'package:jiffy/jiffy.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/warranty_details/widgets/details_image_card.dart';
import 'package:warranty_watch/app/presentation/warranty_details/widgets/individual_detail.dart';
import 'package:warranty_watch/modules/cubit/warranty_details/warranty_details_cubit.dart';

class WarrantyDetailsView extends StatelessWidget {
  const WarrantyDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<WarrantyDetailsCubit>();
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Visibility(
                  visible: isUrlValid(
                    detailsCubit.state.imageUrl,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: Text(l10n.back),
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
  const _Content();

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.watch<WarrantyDetailsCubit>();
    final l10n = context.l10n;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          if (detailsCubit.state.lifeTime)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(l10n.lifeTime),
            )
          else
            warrantyText(
              detailsCubit,
              l10n,
              context,
            ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: (detailsCubit.state.wantsReminders)
                ? Text(
                    l10n.remindsOn(
                      _countDown(
                        detailsCubit.state.reminderDate!,
                      ),
                      _dateFormat(
                        detailsCubit.state.reminderDate!,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    l10n.noReminderSet,
                  ),
          ),
          if (detailsCubit.state.purchaseDate != null)
            Padding(
              padding: EdgeInsets.zero,
              child: IndividualDetailWidget.general(
                detailType: l10n.purchasedOn,
                detailContent: Text(
                  _dateFormat(detailsCubit.state.purchaseDate!),
                ),
              ),
            ),
          if (detailsCubit.state.details != null &&
              detailsCubit.state.details!.isNotEmpty)
            IndividualDetailWidget.general(
              detailType: l10n.details,
              detailContent: Text(detailsCubit.state.details ?? ''),
            ),
          IndividualDetailWidget.general(
            detailType: l10n.productWebsite,
            detailContent: GestureDetector(
              onTap: () => context.read<WarrantyDetailsCubit>().launch(
                    detailsCubit.state.warrantyWebsite!,
                  ),
              child: Text(
                detailsCubit.state.warrantyWebsite!,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          if (isUrlValid(detailsCubit.state.receiptImageUrl))
            IndividualDetailWidget.general(
              detailContent: DetailsImageCard(
                url: detailsCubit.state.receiptImageUrl!,
              ),
              detailType: l10n.receiptPhoto,
            ),
        ],
      ),
    );
  }

  Widget warrantyText(
    WarrantyDetailsCubit detailsCubit,
    AppLocalizations l10n,
    BuildContext context,
  ) {
    return Align(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          (_isExpired(detailsCubit.state.endOfWarranty!))
              ? 'Warranty expired ${_expired(
                  detailsCubit.state.endOfWarranty!,
                )}'
              : l10n.expiresOn(
                  _countDown(
                    detailsCubit.state.endOfWarranty!,
                  ),
                  _dateFormat(
                    detailsCubit.state.endOfWarranty!,
                  ),
                ),
          style: TextStyle(
            color: _dateDiff(detailsCubit.state.endOfWarranty!)
                ? context.themeData.colorScheme.error
                : null,
          ),
        ),
      ),
    );
  }
}

String _countDown(DateTime expirationDate) {
  final expireTime = Jiffy.parseFromDateTime(expirationDate).fromNow();

  return expireTime;
}

String _expired(DateTime expirationDate) {
  final jiffyExpirationDate = Jiffy.parseFromDateTime(expirationDate);
  final expireTime = Jiffy.now().from(jiffyExpirationDate);

  return expireTime;
}

bool _isExpired(DateTime expirationDate) =>
    _countDown(expirationDate).endsWith('ago');

bool isUrlValid(String? url) {
  if (url == null) return false;
  return Uri.parse(url).isAbsolute;
}

String _dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}

bool _dateDiff(DateTime date) {
  if (date.difference(DateTime.now()).inDays < 7) {
    return true;
  } else {
    return false;
  }
}
