import 'package:warranty_watch/app/app_library.dart';

class IndividualDetailWidget extends StatelessWidget {
  const IndividualDetailWidget({
    required this.detailType,
    required this.detailContent,
    super.key,
    this.onTap,
    this.hasLink,
  });

  const IndividualDetailWidget.general({
    required this.detailContent,
    required this.detailType,
    super.key,
  })  : hasLink = false,
        onTap = null,
        super();

  const IndividualDetailWidget.urlLink({
    required this.detailContent,
    required this.detailType,
    super.key,
    this.onTap,
    this.hasLink,
  });
  final String detailType;
  final Widget detailContent;
  final VoidCallback? onTap;
  final bool? hasLink;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.primaryContainer,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Transform.translate(
                offset: const Offset(0, -16),
                child: Container(
                  decoration: BoxDecoration(
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
