import 'package:warranty_keeper/app_library.dart';

class IndividualDetailWidget extends StatelessWidget {
  final String detailType;
  final String detailTitle;
  final VoidCallback? onTap;
  final bool? hasLink;
  const IndividualDetailWidget({
    Key? key,
    required this.detailType,
    required this.detailTitle,
    this.onTap,
    this.hasLink,
  }) : super(key: key);

  const IndividualDetailWidget.general({
    key,
    required this.detailTitle,
    required this.detailType,
  })  : hasLink = false,
        onTap = null,
        super(key: key);

  const IndividualDetailWidget.urlLink({
    Key? key,
    this.onTap,
    this.hasLink,
    required this.detailTitle,
    required this.detailType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Transform.translate(
              offset: const Offset(0, -16),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Text(
                  detailType,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Text(
              detailTitle,
            ),
          ],
        ),
      ),
    );
  }
}
