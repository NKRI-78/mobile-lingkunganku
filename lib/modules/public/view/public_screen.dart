import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';

class PublicScreen extends StatelessWidget {
  const PublicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(62),
                  bottomRight: Radius.circular(62),
                ),
              ),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 50, bottom: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon Menu dengan Builder untuk mendapatkan context yang benar
                      Builder(
                        builder: (context) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: AppColors.blackColor,
                                size: 32,
                              ),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                          );
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.notifications_on_outlined,
                                color: AppColors.blackColor,
                                size: 32,
                              ),
                              onPressed: () {
                                // Handle notification button press
                              },
                            ),
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: const Text(
                                  '5',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.textColor1,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Hi User,',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.textColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 15,
                          ),
                        ),
                        onPressed: () {
                          // Handle registration button press
                        },
                        child: const Text(
                          'Yuk registrasi baru !',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
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
                  padding: EdgeInsets.only(top: 100),
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
                            height: 80,
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
                                  style: TextStyle(color: AppColors.whiteColor),
                                ),
                                onTap: () {
                                  // Navigator.pop(context);
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
                width: 120,
                margin: EdgeInsets.only(bottom: 40, left: 40, right: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
