import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/screen/login_view.dart';
import 'package:mvvm/ui/splash/intro_page.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAll(() => AuthViewModel());
                      },
                      child: Text(
                        'Алгасах',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView(
                    controller: controller,
                    children: [
                      IntroPage(
                        title: RichText(
                          text: TextSpan(
                            text: ' ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 32,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.Green,
                                  fontSize: 32,
                                ),
                              ),
                              TextSpan(
                                text: '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IntroPage(
                        title: RichText(
                          text: TextSpan(
                            text: '',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.Green,
                              fontSize: 32,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IntroPage(
                        title: RichText(
                          text: TextSpan(
                            text: ' ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 32,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: '!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.Green,
                                  fontSize: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Center(
                                //Page шилжилтийн indicator
                                child: SmoothPageIndicator(
                                  controller: controller,
                                  count: 3,
                                  effect: ExpandingDotsEffect(
                                    activeDotColor: AppColors.Green,
                                    dotColor: AppColors.Green,
                                    dotHeight: 15,
                                    dotWidth: 20,
                                    spacing: 10,
                                  ),
                                  onDotClicked: (index) =>
                                      controller.animateToPage(
                                    index,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            FloatingActionButton.extended(
                              backgroundColor: AppColors.Green,
                              onPressed: () {
                                checkNextPage();
                              },
                              label: Container(
                                width: 70,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                ),
                              ),
                            ),

                            // CustomIntroButton(onTap: (){checkNextPage();},   icon: Icon(
                            //   Icons.arrow_forward_ios,
                            //   size: 18,
                            //   color: Colors.black,
                            // ),
                            //   height: 60,
                            //   width: 60,
                            //   color: MyColors.orange,
                            // ),
                            // RoundButtonTest(
                            //   clickAction: () {
                            //     checkNextPage();
                            //   },
                            //   icon:
                            //   Icon(
                            //     Icons.arrow_forward_ios,
                            //     size: 18,
                            //     color: Colors.black,
                            //   ),
                            //   bgColor: MyColors.orange,
                            //   border: Border.all(
                            //     width: 2,
                            //     color: Colors.black,
                            //   ),
                            //   boxShadow: BoxShadow(
                            //     color: Colors.black,
                            //     offset: Offset(0, 4),
                            //   ),
                            // ),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkNextPage() {
    double? currentPage = controller.page;
    if ((currentPage ?? 0) < 2) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      //  End page
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginView()));
    }
  }
}

// Scaffold(
//         backgroundColor: Image.asset('assets/images/background_intro.png').color,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Column(
//                       children: [
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           'Алгасах',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 15,
//                     )
//                   ],
//                 ),
//                 Expanded(
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       PageView(
//                         controller: controller,
//                         children: [
//                           IntroPage(
//                             title: 'Treelings-тэй хамт',
//                             desc:
//                                 'Treelings аппаар дамжуулж\n8 төрлийн модноос сонгон\nмодоо тариал',
//                           ),
//                           IntroPage(
//                             title: 'Эх дэлхийгээ',
//                             desc:
//                                 'Treelings аппаар дамжуулж\n8 төрлийн модноос сонгон\nмодоо тариал',
//                           ),
//                           IntroPage(
//                             title: 'Моджуулъя',
//                             desc:
//                                 'Treelings аппаар дамжуулж\n8 төрлийн модноос сонгон\nмодоо тариал',
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 30),
//                                   child: Center(
//                                     //Page шилжилтийн indicator
//                                     child: SmoothPageIndicator(
//                                       controller: controller,
//                                       count: 3,
//                                       effect: ExpandingDotsEffect(
//                                         activeDotColor: Colors.white,
//                                         dotColor: Colors.white,
//                                         dotHeight: 8,
//                                         dotWidth: 8,
//                                         spacing: 8,
//                                       ),
//                                       onDotClicked: (index) =>
//                                           controller.animateToPage(
//                                         index,
//                                         duration: Duration(milliseconds: 300),
//                                         curve: Curves.easeIn,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 RoundButtonNext(
//                                     clickAction: () {
//                                       checkNextPage();
//                                     },
//                                     icon: Icon(
//                                       Icons.arrow_forward_ios,
//                                       size: 18,
//                                       color: Colors.black,
//                                     ),
//                                     bgColor: MyColors.orange),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
