import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/warranties/warranties_cubit.dart';
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
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          appLocalizations.dateFormat,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<WarrantiesCubit, WarrantiesState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const LinearProgressIndicator();
                    } else {
                      return Expanded(
                        child: (state.asReady.expiring.isEmpty)
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
                                itemCount: state.asReady.expiring.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                      vertical: 4,
                                    ),
                                    child: GestureDetector(
                                      onTap: () =>
                                          detailsCubit.selectedWarrantyInitial(
                                        state.asReady.expiring[index],
                                      ),
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
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    state.asReady
                                                        .expiring[index].name!,
                                                  ),
                                                  Text(
                                                    _dateFormat(state
                                                        .asReady
                                                        .expiring[index]
                                                        .endOfWarranty!),
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
                              ),
                      );
                    }
                  },
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
