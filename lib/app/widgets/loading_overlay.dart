import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/widgets/warranty_logo_widget.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    required this.child,
    required this.isLoading,
    super.key,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) const _OverLay(),
      ],
    );
  }
}

class _OverLay extends StatelessWidget {
  const _OverLay();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const WarrantyLogo(),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              'Never miss a warranty expiration again!',
              style: context.textTheme.titleLarge!.copyWith(
                color: context.colorScheme.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
