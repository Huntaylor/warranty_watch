import 'package:warranty_watch/app/app_library.dart';

class WarrantyBaseView extends StatelessWidget {
  const WarrantyBaseView({
    required this.children,
    this.appBar,
    super.key,
  });
  final List<Widget> children;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: children,
        ),
      ),
    );
  }
}
