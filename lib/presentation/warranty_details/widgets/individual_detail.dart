import 'package:warranty_keeper/app_library.dart';

class IndividualDetailWidget extends StatelessWidget {
  final String detailType;
  final Widget detailContent;
  final VoidCallback? onTap;
  final bool? hasLink;
  const IndividualDetailWidget({
    Key? key,
    required this.detailType,
    required this.detailContent,
    this.onTap,
    this.hasLink,
  }) : super(key: key);

  const IndividualDetailWidget.general({
    key,
    required this.detailContent,
    required this.detailType,
  })  : hasLink = false,
        onTap = null,
        super(key: key);

  const IndividualDetailWidget.urlLink({
    Key? key,
    this.onTap,
    this.hasLink,
    required this.detailContent,
    required this.detailType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.primaryContainer,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Transform.translate(
                offset: const Offset(0, -16),
                child: Container(
                  decoration: BoxDecoration(
                    // color: context.colorScheme.background,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        context.colorScheme.background,
                        context.colorScheme.background,
                        context.colorScheme.primaryContainer,
                      ],
                    ),
                  ),
                  child: Text(
                    detailType,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              detailContent,
            ],
          ),
        ),
      ),
    );
  }
}
