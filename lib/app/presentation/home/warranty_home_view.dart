import 'package:gap/gap.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/data/repositories/auth_repository.dart';
import 'package:warranty_watch/app/data/repositories/warranty_repository.dart';
import 'package:warranty_watch/app/presentation/home/widgets/warranties_title.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/app/widgets/warranty_display_card.dart';
import 'package:warranty_watch/app/widgets/warranty_list_card.dart';
import 'package:warranty_watch/cubit/warranties/warranties_cubit.dart';

class WarrantyHomeView extends StatelessWidget {
  const WarrantyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (context) => WarrantiesCubit(
        dataRepository: DataRepository(),
        authRepository: FirebaseAuthRepository(),
      ),
      child: BlocListener<WarrantiesCubit, WarrantiesState>(
        listenWhen: (previous, current) {
          return current.isReady;
        },
        listener: (context, state) {},
        child: WarrantyBaseView(
          floatingActionButton: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: .3),
                  blurRadius: 25,
                  spreadRadius: 100,
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: FloatingActionButton(
              onPressed: () {
                context.push(Paths.home.newWarranty.path);
              },
              child: const Icon(Icons.add),
            ),
          ),
          appBar: AppBar(
            leading: const SizedBox(),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: const Icon(
                    Icons.settings,
                  ),
                  onPressed: () {
                    context.push(Paths.home.settings.path);
                  },
                ),
              ),
            ],
            centerTitle: true,
            title: Center(
              child: Text(
                l10n.mainTitle.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          children: [
            const WarrantiesTitle(
              listTitle: 'About to Expire',
              warrantiesSelected: WarrantiesViewOption.expiring,
            ),
            BlocBuilder<WarrantiesCubit, WarrantiesState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const LinearProgressIndicator();
                }
                return _WarrantiesCardListBuilder(
                  title: 'No warranties expiring',
                  warranties: state.asReady.expiring,
                );
              },
            ),
            const WarrantiesTitle(
              listTitle: 'Your Warranties',
              warrantiesSelected: WarrantiesViewOption.current,
            ),

            BlocBuilder<WarrantiesCubit, WarrantiesState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const LinearProgressIndicator();
                }
                return _WarrantiesCardListBuilder(
                  title: 'No warranties found',
                  warranties: state.asReady.sortedWarranties,
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            const WarrantiesTitle(
              listTitle: 'Already Expired',
              warrantiesSelected: WarrantiesViewOption.expired,
            ),
            BlocBuilder<WarrantiesCubit, WarrantiesState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const LinearProgressIndicator();
                }
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.asReady.expired.length,
                  itemBuilder: (context, index) {
                    return WarrantyListCard(
                      warrantyInfo: state.asReady.expired[index],
                    );
                  },
                );
              },
            ),

            //Space for the Floating action button for users to look behind it
            const Gap(75),
          ],
        ),
      ),
    );
  }
}

class _WarrantiesCardListBuilder extends StatelessWidget {
  const _WarrantiesCardListBuilder({
    required this.title,
    required this.warranties,
  });

  final String title;
  final List<WarrantyInfo> warranties;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: warranties.isNotEmpty,
      replacement: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          title,
          style: context.textTheme.titleMedium!
              .copyWith(color: context.colorScheme.primary),
        ),
      ),
      child: SizedBox(
        height: 215,
        child: ListView.builder(
          clipBehavior: Clip.none,
          physics: const ClampingScrollPhysics(),
          itemCount: warranties.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return WarrantyDisplayCard(
              warrantyInfo: warranties[index],
              onSelect: () => onWarrantyTap(
                warrantyInfo: warranties[index],
                context: context,
              ),
            );
          },
        ),
      ),
    );
  }
}
