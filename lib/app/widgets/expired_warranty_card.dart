import 'package:warranty_watch/app/app_library.dart';

class ExpiredWarrantyCard extends StatelessWidget {
  const ExpiredWarrantyCard({
    required this.title,
    required this.expirationDate,
    required this.onSelect,
    super.key,
  }) : super();

  final String title;
  final DateTime expirationDate;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: GestureDetector(
        onTap: onSelect,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.primary.withOpacity(.1),
                offset: const Offset(
                  0,
                  3,
                ),
                blurRadius: 3,
                spreadRadius: 1,
              ),
              const BoxShadow(
                color: Colors.white,
              ),
            ],
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.textTheme.bodyLarge,
              ),
              Text(
                'Expired: ${expirationDate.month}/${expirationDate.day}/${expirationDate.year}',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colorScheme.primary.withOpacity(.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
