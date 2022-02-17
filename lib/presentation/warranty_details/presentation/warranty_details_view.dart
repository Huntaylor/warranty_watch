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
        title: const Text('Details'),
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
            Container(
              padding: const EdgeInsets.all(2),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.blue[400],
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[400]!),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Image.file(
                  detailsCubit.state.image!,
                  height: MediaQuery.of(context).size.height * .3,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IndividualDetailWidget.general(
                    detailType: 'Purchased on',
                    detailTitle: _dateFormat(detailsCubit.state.purchaseDate!),
                  )
                  /* SizedBox(
                  width: MediaQuery.of(context).size.width * .3,
                  child: Column(
                    children: [
                      const Text(
                        'Purchase Date',
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 4,
                        thickness: 1,
                        // endIndent: 96,
                        // indent: 96,
                      ),
                      Text(
                        _dateFormat(detailsCubit.state.purchaseDate!),
                      ),
                    ],
                  ),
                ), */
                  ),
            ),
            (detailsCubit.state.details == null ||
                    detailsCubit.state.details!.isEmpty)
                ? const SizedBox()
                : /* Flexible(
                  child: */
                IndividualDetailWidget(
                    detailType: 'Details',
                    detailTitle: detailsCubit.state.details!,
                  ),
            /*   ), */

            (detailsCubit.state.lifeTime)
                ? const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text('Lifetime warranty'),
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    // child: Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Expires ${_countDown(detailsCubit.state.endOfWarr!)} on ${_dateFormat(detailsCubit.state.endOfWarr!)}',
                      ),
                      // ),
                    ),
                  ),
            Row(
              children: [
                const Text('Product Website:'),
                TextButton(
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () =>
                      detailsCubit.launch(detailsCubit.state.warrWebsite!),
                  child: Text(
                    detailsCubit.state.warrWebsite!,
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            if (detailsCubit.state.receiptImage != null)
              DetailsImageCard(file: detailsCubit.state.receiptImage!),
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
