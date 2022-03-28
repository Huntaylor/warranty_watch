import 'package:go_router/go_router.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/settings/settings_cubit.dart';
import 'package:warranty_keeper/routes/paths.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

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
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final settingsCubit = context.read<SettingsCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                            value: state.isNotifications,
                            onChanged: settingsCubit.toggleNotifications,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Something else'),
                          Switch(
                            value: state.isSomething,
                            onChanged: settingsCubit.toggleSomething,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: ((context, state) => state.mapOrNull(
                    notAuthenticated: ((value) => context.go(
                          Paths.login.name,
                        )),
                  )),
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                  child: WarrantyElevatedButton.general(
                    isEnabled: true,
                    onPressed: () => authCubit.logout(),
                    text: 'Logout',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
