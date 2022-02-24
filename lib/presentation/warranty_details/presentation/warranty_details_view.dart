import 'package:jiffy/jiffy.dart';
import 'package:warranty_keeper/app_library.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.appLocalizations.details),
      ),
      body: const Content(),
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

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Center(
                child: Text(
                  detailsCubit.state.name!,
                ),
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                // borderRadius: BorderRadius.circular(25.0),
              ),

              // padding: const EdgeInsets.all(2),
              clipBehavior: Clip.antiAlias,
              // decoration: BoxDecoration(
              //   color: Colors.blue[400],
              //   border: Border.all(color: Colors.black),
              //   borderRadius: BorderRadius.circular(25),
              // ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue[400]!,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Image.file(
                  detailsCubit.state.image!,
                  height: MediaQuery.of(context).size.height * .3,
                ),
              ),
            ),
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
