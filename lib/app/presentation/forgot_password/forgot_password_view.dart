import 'package:gap/gap.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/app/widgets/warranty_logo_widget.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return WarrantyBaseView(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'FORGOT PASSWORD',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            fontSize: 18,
          ),
        ),
      ),
      children: [
        const Gap(60),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: WarrantyLogo.general(),
        ),
        Visibility(
          child: Text('Check your email to reset your password'),
        ),
        // const Gap(60),
        WarrantyTextField.email(
          onChanged: (value) {},
          textFieldName: 'Account Email',
        ),
        WarrantyElevatedButton.general(
          isEnabled: true,
          onPressed: () {},
          text: 'Reset Password',
        ),
      ],
    );
  }
}
