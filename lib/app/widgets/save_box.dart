import 'package:warranty_watch/app/app_library.dart';

class SaveBox extends StatelessWidget {
  const SaveBox({
    required this.discard,
    required this.continueEdits,
    super.key,
  });

  final void Function() discard;
  final void Function() continueEdits;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      icon: Icon(
        Icons.warning,
        color: context.colorScheme.error,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      title: const Text('Leave without saving?'),
      actions: <Widget>[
        TextButton(
          onPressed: continueEdits,
          child: const Text('Continue editing'),
        ),
        TextButton(
          onPressed: discard,
          child: const Text('Discard'),
        ),
      ],
    );
  }
}

class NotificationBox extends StatelessWidget {
  const NotificationBox({
    required this.cancel,
    required this.enableNotifications,
    super.key,
  });

  final void Function() cancel;
  final void Function() enableNotifications;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      icon: Icon(
        Icons.notifications,
        color: context.colorScheme.primary,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      title: const Text('Change notification preferences in Settings'),
      actions: <Widget>[
        TextButton(
          onPressed: cancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: enableNotifications,
          child: const Text('Open Settings'),
        ),
      ],
    );
  }
}
