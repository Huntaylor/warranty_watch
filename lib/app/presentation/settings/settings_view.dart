// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expandable/expandable.dart';

import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/widgets/save_box.dart';
import 'package:warranty_watch/app/widgets/warranty_logo_widget.dart';
import 'package:warranty_watch/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/cubit/settings/settings_cubit.dart';

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
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const WarrantyLogo.small(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Version 1.0.0',
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colorScheme.primary.withValues(alpha: .5),
                    ),
                  ),
                ],
              ),
            ),
            /* Expanded(
              flex: 3,
              child:  */
            ListView(
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
                      onChanged: (value) => showAdaptiveDialog<NotificationBox>(
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
                  titleText: 'Delete Account',
                  buttonText: 'Delete Account',
                  isWarning: true,
                  onPressed: () async => context.read<AuthCubit>().logout(),
                ),
                _SettingsExpandable(
                  titleText: 'Logout',
                  buttonText: 'Logout',
                  onPressed: () async => context.read<AuthCubit>().logout(),
                ),
              ],
            ),
            // ),
            /* Flexible(
              child:  */
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       const WarrantyLogo.small(),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       Text(
            //         'Version 1.0.0',
            //         style: context.textTheme.bodyLarge!.copyWith(
            //          color: context.colorScheme.primary.withValues(alpha:.5),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _SettingsExpandable extends StatefulWidget {
  const _SettingsExpandable({
    required this.titleText,
    required this.buttonText,
    required this.onPressed,
    bool? isWarning,
  }) : _isWarning = isWarning ?? false;

  final String titleText;
  final String buttonText;
  final void Function() onPressed;
  final bool _isWarning;

  @override
  State<_SettingsExpandable> createState() => _SettingsExpandableState();
}

class _SettingsExpandableState extends State<_SettingsExpandable> {
  late ExpandableController controller;
  late bool isDeletingAccount;

  @override
  void initState() {
    isDeletingAccount = false;
    controller = ExpandableController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._isWarning) {
      controller.addListener(
        () {
          if (!controller.expanded) {
            setState(() {
              isDeletingAccount = false;
            });
          }
        },
      );
    }

    return ColoredBox(
      color: context.colorScheme.surface,
      child: ExpandablePanel(
        controller: controller,
        theme: const ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          iconSize: 40,
        ),
        header: Text(
          widget.titleText,
          style: context.textTheme.titleLarge,
        ),
        collapsed: const SizedBox(),
        expanded: Column(
          children: [
            if (widget._isWarning) ...[
              Icon(
                Icons.warning,
                color: context.colorScheme.error,
              ),
              Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'WARNING! \n',
                      style: context.textTheme.headlineSmall!
                          .copyWith(color: context.colorScheme.error),
                    ),
                    TextSpan(
                      text: context.l10n.settingsWarning,
                      style: context.textTheme.labelLarge!
                          .copyWith(color: context.colorScheme.error),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Switch.adaptive(
                    value: isDeletingAccount,
                    onChanged: (isSwitched) {
                      setState(() {
                        isDeletingAccount = isSwitched;
                      });
                    },
                  ),
                  Flexible(
                    child: Text(
                      'Yes, delete my account',
                      style: context.textTheme.labelLarge!
                          .copyWith(color: context.colorScheme.error),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ],
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 15),
              child: WarrantyElevatedButton.general(
                isEnabled: (widget._isWarning) ? isDeletingAccount : true,
                onPressed: widget.onPressed,
                text: widget.buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
