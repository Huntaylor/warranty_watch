// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expandable/expandable.dart';

import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/widgets/save_box.dart';
import 'package:warranty_watch/app/widgets/warranty_logo_widget.dart';
import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/modules/cubit/settings/settings_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (_, state) => state.isSetSettings,
      builder: (context, state) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.isNotAuthenticated) {
              GoRouter.of(context).refresh();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: _Context(
              state: state,
            ),
          ),
        );
      },
    );
  }
}

class _Context extends StatelessWidget {
  const _Context({
    required this.state,
  });
  final SettingsState state;
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications',
                        style: context.textTheme.titleLarge,
                      ),
                      Switch.adaptive(
                        value: state.asSet.isNotificationAllowed,
                        onChanged: (value) =>
                            showAdaptiveDialog<NotificationBox>(
                          context: context,
                          builder: (context) {
                            return NotificationBox(
                              enableNotifications: () => context
                                ..pop()
                                ..read<SettingsCubit>().toggleNotifications(
                                  value: value,
                                ),
                              cancel: () => context.pop(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  _SettingsExpandable(
                    titleText: 'Leave a Review',
                    buttonText: 'Leave a Review',
                    onPressed: () {},
                  ),
                  _SettingsExpandable(
                    titleText: 'Report an issue',
                    buttonText: 'Report an issue',
                    onPressed: () {},
                  ),
                  _SettingsExpandable(
                    titleText: 'Logout',
                    buttonText: 'Logout',
                    onPressed: () async => context.read<AuthCubit>().logout(),
                  ),
                  _SettingsExpandable(
                    titleText: 'Delete Account',
                    buttonText: 'Delete Account',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  const WarrantyLogo.small(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Version 1.0.0',
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colorScheme.primary.withOpacity(.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsExpandable extends StatelessWidget {
  const _SettingsExpandable({
    required this.titleText,
    required this.buttonText,
    required this.onPressed,
  }) : super();

  final String titleText;
  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      theme: const ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        iconSize: 40,
      ),
      header: Text(
        titleText,
        style: context.textTheme.titleLarge,
      ),
      collapsed: const SizedBox(),
      expanded: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 15),
        child: WarrantyElevatedButton.general(
          isEnabled: true,
          onPressed: onPressed,
          text: buttonText,
        ),
      ),
    );
  }
}
