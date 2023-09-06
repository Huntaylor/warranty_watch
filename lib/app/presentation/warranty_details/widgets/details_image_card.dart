import 'package:warranty_watch/app/app_library.dart';

class DetailsImageCard extends StatelessWidget {
  const DetailsImageCard({
    required this.url,
    super.key,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Image.network(
            url,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * .3,
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) {
                return child;
              }
              return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * .3,
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
