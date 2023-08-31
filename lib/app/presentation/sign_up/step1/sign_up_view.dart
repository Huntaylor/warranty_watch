// import 'package:warranty_watch/app/app_library.dart';
// import 'package:warranty_watch/app/presentation/sign_up/widgets/password_requirement_widget.dart';
// import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';
// import 'package:warranty_watch/modules/cubit/sign_up/sign_up_cubit.dart';

// class SignUpEmailView extends StatelessWidget {
//   const SignUpEmailView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final state = signUpCubit.state;
//     final authCubit = context.watch<AuthCubit>();

//     String? errorText;

//     if (authCubit.state.isError) {
//       errorText = 'This email is already in use';
//     } else {
//       errorText = null;
//     }
//     final signUpRead = context.read<SignUpCubit>();
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 8),
//           child: WarrantyElevatedButton.loading(
//             onPressed: () async {
//               await authCubit.checkEmail(state.asSignUp.email!);
//               if (!authCubit.state.isError) {
//                 signUpRead.pushPersonalData();
//               }
//             },
//             text: 'Next',
//             isLoading: authCubit.state.isLoading,
//             isEnabled: signUpCubit.enabledEmailNext(),
//           ),
//         ),
//       ],
//     );
//   }
// }
