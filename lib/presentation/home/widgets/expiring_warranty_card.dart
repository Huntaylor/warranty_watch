import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/current_warranties/current_warranties_cubit.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';

class ExpiringWarrantyCard extends StatelessWidget {
  const ExpiringWarrantyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<WarrantyDetailsCubit>();
    final navCubit = context.read<NavCubit>();

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Expiring soon'),
                      Text('MM/DD/YYYY'),
                    ],
                  ),
                ),
              ),
              BlocBuilder<CurrentWarrantiesCubit, CurrentWarrantiesState>(
                builder: (context, state) {
                  return (state.expiringList.isEmpty)
                      ? const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'No warranties close to expiration',
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.expiringList.length,
                          physics: const ClampingScrollPhysics(),
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
                                  navCubit.detailsNav();
                                },
                                child: Column(
                                  children: [
                                    if (index != 0)
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 4.0),
                                        child: Divider(
                                          height: 0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              state.expiringList[index].name!,
                                            ),
                                            Text(
                                              _dateFormat(state
                                                  .expiringList[index]
                                                  .endOfWarr!),
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
            ],
          ),
        ),
      ),
    );
  }
}

String _dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}