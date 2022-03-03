import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/settings/settings_cubit.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';

class SettingsView extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('settings view'),
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 15),
              child: WarrantyElevatedButton(
                isEnabled: true,
                onPressed: () {},
                text: 'Logout',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
