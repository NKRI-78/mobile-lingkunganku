import 'package:flutter/cupertino.dart';

import '../../misc/colors.dart';

class PagePaymentStatus extends StatelessWidget {
  const PagePaymentStatus({super.key, required this.msg, required this.img});

  final String msg;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              img,
              width: 250.0,
              height: 250.0,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(msg,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ),
    );
  }
}
