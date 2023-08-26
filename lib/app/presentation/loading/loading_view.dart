import 'package:flutter/material.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/loading/widgets/triangle_loading_indicator.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});
  static const routeName = '/loading_view';
  static const title = 'loading view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: const TriangleLoadingIndicator(),
    );
  }
}
