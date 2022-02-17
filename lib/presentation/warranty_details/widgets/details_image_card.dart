import 'package:warranty_keeper/app_library.dart';

class DetailsImageCard extends StatelessWidget {
  final File file;
  const DetailsImageCard({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Image.file(
        file,
        height: MediaQuery.of(context).size.height * .3,
      ),
    );
  }
}
