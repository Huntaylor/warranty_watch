import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/modules/cubit/warranties/warranties_cubit.dart';
import 'package:warranty_watch/modules/cubit/warranty_details/warranty_details_cubit.dart';

class ExpiringWarrantyCard extends StatelessWidget {
  const ExpiringWarrantyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.only(top: 5),
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
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.expiringSoon,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        l10n.dateFormat,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const IndividualWarranties(),
            ],
          ),
        ),
      ),
    );
  }
}

class IndividualWarranties extends StatelessWidget {
  const IndividualWarranties({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<WarrantyDetailsCubit>();
    final l10n = context.l10n;

    return BlocBuilder<WarrantiesCubit, WarrantiesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const LinearProgressIndicator();
        } else if (state.isError) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              l10n.expiringError,
            ),
          );
        } else if (state.asReady.expiring.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              l10n.noneExpiring,
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.asReady.expiring.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
                child: GestureDetector(
                  onTap: () => detailsCubit.selectedWarrantyInitial(
                    state.asReady.expiring[index],
                  ),
                  child: Column(
                    children: [
                      if (index != 0)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                        ),
                      ColoredBox(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.asReady.expiring[index].name!,
                              ),
                              Text(
                                dateFormat(
                                  state.asReady.expiring[index].endOfWarranty!,
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
          ),
        );
      },
    );
  }
}

String dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
