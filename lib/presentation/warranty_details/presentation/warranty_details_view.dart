import 'package:jiffy/jiffy.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';
import 'package:warranty_keeper/presentation/warranty_details/widgets/details_image_card.dart';
import 'package:warranty_keeper/presentation/warranty_details/widgets/individual_detail.dart';

class WarrantyDetailsView extends StatelessWidget {
  static const routeName = '/warrantyDetails';
  const WarrantyDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<WarrantyDetailsCubit>();
    final navCubit = context.read<NavCubit>();
    final appLocalizations = context.appLocalizations;
    return Scaffold(
      /* appBar: AppBar(
        centerTitle: true,
        title: Text(context.appLocalizations.details),
      ), */
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .4,
                  width: double.infinity,
                  child: Image.file(
                    detailsCubit.state.image!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () => navCubit.pop(),
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
                      color: Colors.white70,
                    ),
                    child: Text(
                      detailsCubit.state.name!,
                    ),
                  ),
                ),
              ],
            ),
            const Content(),
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<WarrantyDetailsCubit>();
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
                      appLocalizations.expiresOn(
                        _countDown(detailsCubit.state.endOfWarr!),
                        _dateFormat(detailsCubit.state.endOfWarr!),
                      ),
                      style: TextStyle(
                        color: _dateDiff(detailsCubit.state.endOfWarr!)
                            ? Colors.red
                            : null,
                      ),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: (detailsCubit.state.wantsReminders)
                ? Text(
                    appLocalizations.remindsOn(
                      _countDown(detailsCubit.state.reminderDate!),
                      _dateFormat(detailsCubit.state.reminderDate!),
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    appLocalizations.noReminderSet,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: .0),
            child: IndividualDetailWidget.general(
              detailType: appLocalizations.purchasedOn,
              detailContent: Text(
                _dateFormat(detailsCubit.state.purchaseDate!),
              ),
            ),
          ),
          (detailsCubit.state.details == null ||
                  detailsCubit.state.details!.isEmpty)
              ? const SizedBox()
              : IndividualDetailWidget.general(
                  detailType: appLocalizations.details,
                  detailContent: Text(detailsCubit.state.details!),
                ),
          IndividualDetailWidget.general(
            detailType: appLocalizations.productWebsite,
            detailContent: GestureDetector(
                onTap: () =>
                    detailsCubit.launch(detailsCubit.state.warrWebsite!),
                child: Text(
                  detailsCubit.state.warrWebsite!,
                  style: const TextStyle(
                    color: Colors.lightBlue,
                    decoration: TextDecoration.underline,
                  ),
                )),
          ),
          if (detailsCubit.state.receiptImage != null)
            IndividualDetailWidget.general(
              detailContent:
                  DetailsImageCard(file: detailsCubit.state.receiptImage!),
              detailType: appLocalizations.receiptPhoto,
            ),
        ],
      ),
    );
  }
}

_countDown(DateTime expirationDate) {
  final _expireTime = Jiffy(expirationDate).fromNow();
  return _expireTime;
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
