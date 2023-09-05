import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/widgets/loading_overlay.dart';

class WarrantyBaseView extends StatelessWidget {
  const WarrantyBaseView({
    required this.children,
    this.appBar,
    this.isLoading,
    this.floatingActionButton,
    super.key,
  });
  final List<Widget> children;
  final AppBar? appBar;
  final bool? isLoading;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: appBar,
      backgroundColor: context.colorScheme.surface,
      body: LoadingOverlay(
        isLoading: isLoading ?? false,
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: children,
          ),
        ),
      ),
    );
  }
}
