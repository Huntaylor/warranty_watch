import 'package:jiffy/jiffy.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
            (detailsCubit.state.details == null ||
                    detailsCubit.state.details!.isEmpty)
                ? const SizedBox()
                : Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Details: ${detailsCubit.state.details!}'),
                    ),
                  ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    const Text(
                      'Purchase Date',
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 4,
                      thickness: 1,
                      endIndent: 96,
                      indent: 96,
                    ),
                    Text(
                      _dateFormat(detailsCubit.state.purchaseDate!),
                    ),
                  ],
                ),
              ),
            ),
            (detailsCubit.state.lifeTime)
                ? const Text('Lifetime warranty')
                : Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                          'Expires ${_countDown(detailsCubit.state.endOfWarr!)} on ${_dateFormat(detailsCubit.state.endOfWarr!)}'),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

_countDown(DateTime expirationDate) {
  final _expireTime = Jiffy(expirationDate).fromNow();
  // final days = Jiffy(expirationDate).diff(
  //     Jiffy(
  //       DateTime.now(),
  //     ),
  //     Units.DAY);
  // final weeks = Jiffy(expirationDate).diff(
  //     Jiffy(
  //       DateTime.now(),
  //     ),
  //     Units.WEEK);
  // final months = Jiffy(expirationDate).diff(
  //     Jiffy(
  //       DateTime.now(),
  //     ),
  //     Units.MONTH);
  // final years = Jiffy(expirationDate).diff(
  //     Jiffy(
  //       DateTime.now(),
  //     ),
  //     Units.YEAR);

  // String yearCount = '';
  // if (years == 0) {
  //   yearCount = '';
  // } else {
  //   yearCount = years.toString() + ' Year(s) ';
  // }
  // String monthCount = '';
  // if (months >= 12 || months == 0) {
  //   monthCount = '';
  // } else {
  //   monthCount = months.toString() + ' Month(s) ';
  // }
  // String weekCount = '';
  // if (weeks >= 52 || weeks == 0) {
  //   weekCount = '';
  // } else {
  //   weekCount = weeks.toString() + ' Week(s) ';
  // }
  // String dayCount = '';
  // if (days >= 365 || days == 0) {
  //   dayCount = '';
  // } else {
  //   dayCount = days.toString() + ' Day(s) ';
  // }
  // // final _expireTime = yearCount + monthCount + weekCount + dayCount;
  return _expireTime;
}

_dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
