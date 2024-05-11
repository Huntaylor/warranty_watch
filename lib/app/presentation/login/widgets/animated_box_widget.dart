import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/cubit/login/login_cubit.dart';

class AnimatedBox extends StatelessWidget {
  const AnimatedBox({
    required this.animation,
    super.key,
  });

  final Duration animation;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginCubit>().state;
    return AnimatedSize(
      duration: animation,
      child: Visibility(
        visible: state.isInitial,
        replacement: const SizedBox(
          height: 70,
        ),
        child: const SizedBox(
          height: 130,
          // height: state.isInitial ? 130 : 75,
        ),
      ),
    );
  }
}
