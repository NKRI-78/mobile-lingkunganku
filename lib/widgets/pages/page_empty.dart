import 'package:flutter/cupertino.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key, required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.asset(
          //   AssetsConst.imageIcNoEvent,
          //   width: 250.0,
          //   height: 250.0,
          // ),
          const SizedBox(
            height: 5,
          ),
          Text(
            msg,
            style: AppTextStyles.textProfileNormal,
          ),
        ],
      ),
    );
  }
}
