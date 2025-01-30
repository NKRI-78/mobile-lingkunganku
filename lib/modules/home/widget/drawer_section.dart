import 'package:flutter/material.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../router/builder.dart';
import '../../../widgets/button/custom_button.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 50),
                children: <Widget>[
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/lingkunganku.png'),
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.textColor1,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: 50),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 70,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.whiteColor,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.settings_outlined,
                                color: AppColors.whiteColor,
                              ),
                              title: Text(
                                'Settings',
                                style: AppTextStyles.buttonText1,
                              ),
                              onTap: () {
                                SettingsRoute().go(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: CustomButton(
                text: 'Close App',
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: AppColors.redColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
