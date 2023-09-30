import 'package:expandable/expandable.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/modules/cubit/settings/settings_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.isNotAuthenticated) {
              GoRouter.of(context).refresh();
            }
          },
          child: WarrantyBaseView(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Notifications'),
                  Switch.adaptive(
                    value: state.asSet.isNotifications,
                    onChanged: (value) =>
                        context.read<SettingsCubit>().toggleNotifications(
                              value: value,
                            ),
                  ),
                ],
              ),
              ExpandablePanel(
                header: const Text('Leave a Review'),
                collapsed: const SizedBox(),
                expanded: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 15),
                  child: WarrantyElevatedButton.general(
                    isEnabled: true,
                    onPressed: () {},
                    text: 'Leave a Review',
                  ),
                ),
              ),
              ExpandablePanel(
                header: const Text('Report an issue'),
                collapsed: const SizedBox(),
                expanded: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 15),
                  child: WarrantyElevatedButton.general(
                    isEnabled: true,
                    onPressed: () {},
                    text: 'Report an issue',
                  ),
                ),
              ),
              ExpandablePanel(
                header: const Text('Logout'),
                collapsed: const SizedBox(),
                expanded: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 15),
                  child: WarrantyElevatedButton(
                    isLoading: context.watch<AuthCubit>().state.isLoading,
                    isEnabled: true,
                    onPressed: () async {
                      await context.read<AuthCubit>().logout();
                    },
                    text: 'Logout',
                  ),
                ),
              ),
              ExpandablePanel(
                header: const Text('Delete Account'),
                collapsed: const SizedBox(),
                expanded: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 15),
                  child: WarrantyElevatedButton.general(
                    isEnabled: true,
                    onPressed: () {},
                    text: 'Delete Account',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
