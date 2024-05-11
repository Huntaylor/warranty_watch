import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/cubit/warranties/warranties_cubit.dart';

class WarrantiesTitle extends StatelessWidget {
  const WarrantiesTitle({
    required this.listTitle,
    required this.warrantiesSelected,
    super.key,
  });
  final String listTitle;
  final WarrantiesViewOption warrantiesSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            listTitle,
            style: context.textTheme.titleLarge!.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          const SizedBox.shrink(),
          Visibility(
            visible: warrantiesSelected != WarrantiesViewOption.expired,
            child: IconButton(
              onPressed: () {
                context
                    .read<WarrantiesCubit>()
                    .onViewWarranties(viewOption: warrantiesSelected);
                context.push(
                  Paths.home.warranties.path,
                );
              },
              icon: const Icon(Icons.menu),
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
