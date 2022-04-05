import 'package:warranty_keeper/app_library.dart';

class DetailsImageCard extends StatelessWidget {
  final String url;
  const DetailsImageCard({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Image.network(
        url,
        height: MediaQuery.of(context).size.height * .3,
      ),
    );
  }
}
