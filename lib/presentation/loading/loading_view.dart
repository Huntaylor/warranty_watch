import 'package:flutter/material.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/presentation/loading/widgets/triangle_loading_indicator.dart';

class LoadingView extends StatelessWidget {
  static const routeName = '/loading_view';
  static const title = 'loading view';

  const LoadingView({super.key});

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
