import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/modules/cubit/settings/settings_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isNotAuthenticated) {
            GoRouter.of(context).refresh();
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Notifications'),
                              Switch(
                                value: state.asSet.isNotifications,
                                onChanged: (value) => context
                                    .read<SettingsCubit>()
                                    .toggleNotifications,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Something else'),
                              Switch(
                                value: state.asSet.isSomething,
                                onChanged: (value) => context
                                    .read<SettingsCubit>()
                                    .toggleSomething,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
