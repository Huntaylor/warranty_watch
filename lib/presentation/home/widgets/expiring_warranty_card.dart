import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/current_warranties/current_warranties_cubit.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';

class ExpiringWarrantyCard extends StatelessWidget {
  const ExpiringWarrantyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<WarrantyDetailsCubit>();
    final appLocalizations = context.appLocalizations;

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizations.expiringSoon,
                          style: context.textTheme.subtitle1?.copyWith(
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          appLocalizations.dateFormat,
                          style: context.textTheme.subtitle1?.copyWith(
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<CurrentWarrantiesCubit,
                      CurrentWarrantiesState>(
                    builder: (context, state) {
                      return (state.expiringList.isEmpty)
                          ? Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                appLocalizations.noneExpiring,
                              ),
                            )
                          : ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              addAutomaticKeepAlives: true,
                              shrinkWrap: true,
                              itemCount: state.expiringList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                    vertical: 4,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      detailsCubit.selectedWarrantyInitial(
                                        state.expiringList[index],
                                      );
                                      //TODO: change to go_router
                                      // navCubit.detailsNav();
                                    },
                                    child: Column(
                                      children: [
                                        if (index != 0)
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 4.0),
                                            child: Divider(
                                              height: 2,
                                              color: Colors.black,
                                            ),
                                          ),
                                        Container(
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  state.expiringList[index]
                                                      .name!,
                                                ),
                                                Text(
                                                  _dateFormat(
                                                    state.expiringList[index]
                                                        .endOfWarr!,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
