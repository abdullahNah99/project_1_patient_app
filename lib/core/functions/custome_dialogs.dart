import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import '../utils/app_assets.dart';
import '../widgets/custome_button.dart';
import '../widgets/custome_image.dart';

abstract class CustomDialogs {
  static void showCustomDialog(
    BuildContext context, {
    required int balance,
    required void Function() onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            height: 150.h,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Note: You will lose 100 from your wallet when you submit appointment',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomeButton(
                      text: 'Submit',
                      onPressed: onPressed,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                Positioned(
                  bottom: 135.h,
                  left: 220.w,
                  child: CustomeImage(
                    image: AppAssets.stethoscopeIcon,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25.r),
                    height: 75,
                    width: 75,
                  ),
                ),
                Positioned(
                  bottom: 145.h,
                  left: 90.w,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 252, 246, 252),
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: defaultColor),
                    ),
                    child: Text(
                      "$balance ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<DateTime?> pickDateDialog(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1930, 1, 1),
      lastDate: DateTime.now(),
    );
  }

  static void showRatingDialog(
    BuildContext context, {
    required void Function() onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .28,
            child: CustomeRatingView(
              onPressed: onPressed,
            ),
          ),
        );
      },
    );
  }

  static int? helperGetRatingIndex() => CustomeRatingView.ratingValue;
}

class CustomeRatingView extends StatefulWidget {
  final void Function() onPressed;
  static int? ratingValue;
  const CustomeRatingView({
    super.key,
    required this.onPressed,
  });

  @override
  State<CustomeRatingView> createState() => _CustomeRatingViewState();
}

class _CustomeRatingViewState extends State<CustomeRatingView> {
  int ratingIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Rating',
              style: TextStyle(
                fontSize: 20.h,
                color: defaultColor.withOpacity(.6),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      ratingIndex = index + 1;
                      CustomeRatingView.ratingValue = ratingIndex;
                    });
                  },
                  icon: index < ratingIndex
                      ? Icon(
                          Icons.star,
                          color: Colors.yellow.shade600,
                          size: 33.w,
                        )
                      : Icon(
                          Icons.star_border,
                          color: Colors.yellow.shade600,
                          size: 33.w,
                        ),
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          CustomeButton(
            text: 'Submit',
            onPressed: widget.onPressed,
            width: MediaQuery.of(context).size.width * .5,
          ),
        ],
      ),
    );
  }
}
