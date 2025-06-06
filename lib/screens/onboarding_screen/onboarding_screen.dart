import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/screens/onboarding_screen/intro_page_1.dart';
import 'package:reuse_mart_mobile/screens/onboarding_screen/intro_page_2.dart';
import 'package:reuse_mart_mobile/screens/onboarding_screen/intro_page_3.dart';
import 'package:reuse_mart_mobile/screens/onboarding_screen/intro_page_4.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //controller
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 3);
              });
            },
            children: [IntroPage1(), IntroPage2(), IntroPage3(), IntroPage4()],
          ),

          Positioned(
            bottom: 42,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _controller.animateToPage(
                        4,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Lewati',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 4,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.white,
                        activeDotColor: AppColors.brightGreen,
                        dotHeight: 12,
                        dotWidth: 12,
                        expansionFactor: 3.0, // ukurang dot aktif
                        spacing: 8, // jarak antar dot
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_controller.page!.toInt() < 3) {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      } else {
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color: AppColors.brightGreen,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Center(
                        child:
                            onLastPage
                                ? Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                                : Text(
                                  'Berikutnya',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
