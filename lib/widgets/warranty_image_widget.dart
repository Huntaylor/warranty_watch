import 'package:warranty_keeper/app_library.dart';

class WarrantyImage extends StatelessWidget {
  const WarrantyImage({
    Key? key,
    this.image,
    // this.fileList,
    required this.text,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final String? image;
  // final List<WarrantyImages>? fileList;
  final String text;
  final VoidCallback onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 5, right: 5),
      child: /*  fileList != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .2,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade500,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Image(
                          image: FileImage(fileList![index].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Transform.translate(
                          offset: const Offset(5, -5),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.change_circle,
                              color: Colors.lightBlue,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : */
          (image != null)
              ? Stack(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height * .2,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Image(
                          image: FileImage(File(image!)),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Transform.translate(
                          offset: const Offset(5, -5),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.change_circle,
                              color: Colors.lightBlue,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: context.themeData.cardColor,
                      border: Border.all(color: context.colorScheme.primary),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            text,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          icon,
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
