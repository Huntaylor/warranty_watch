import 'package:warranty_keeper/app_library.dart';

class DetailsImageCard extends StatelessWidget {
  final File file;
  const DetailsImageCard({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.file(
        file,
        height: MediaQuery.of(context).size.height * .3,
      ),
    );
  }
}
