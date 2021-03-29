import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';

import 'loginScreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);
  Widget pageIndexIndicator(bool isCuurent) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.symmetric(horizontal: 3),
      height: isCuurent ? 20.0 : 12.0,
      width: isCuurent ? 20.0 : 12.0,
      decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: Colors.black, style: BorderStyle.solid),
          color: isCuurent ? Color.fromRGBO(16, 119, 194, 1) : Colors.black,
          borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
                alignment: Alignment.topCenter,
                child: Container(
                    child: GestureDetector(
                  onTap: () {
                    // pageController.animateToPage(2,
                    //     duration: Duration(milliseconds: 600),
                    //     curve: Curves.linearToEaseOut);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      buildSizedBox(buildHeight(context), 0.05),
                      Image.asset(
                        "assets/images/teamduel.png",
                        width: 185,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Your mobile Fantasy Sports Platform',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: PageView(
                            controller: pageController,
                            onPageChanged: (val) {
                              setState(() {
                                currentIndex = val;
                              });
                            },
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  "assets/images/onboarding.png",
                                  width: 185,
                                ),
                              ),
                              Image.asset(
                                "assets/images/onboarding.png",
                                width: 185,
                              ),
                              Image.asset(
                                "assets/images/onboarding.png",
                                width: 185,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          currentIndex == 0
                              ? createContent(currentIndex,
                                  "Demonstrate your Sports Knowledge  & Handicapping Skills ")
                              : currentIndex == 1
                                  ? createContent(currentIndex,
                                      "Demonstrate your Sports Knowledge  & Handicapping Skills ")
                                  : createContent(currentIndex,
                                      "Demonstrate your Sports Knowledge  & Handicapping Skills "),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < 3; i++)
                                currentIndex == i
                                    ? pageIndexIndicator(true)
                                    : pageIndexIndicator(false)
                            ],
                          ),
                          // Divider(
                          //   color: Colors.black,
                          //   thickness: 2,
                          //   endIndent: 40,
                          //   indent: 40,
                          // ),
                          // Text('Powered By Winx'),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 200,
                              child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                                color: Color.fromRGBO(34, 123, 239, 0.94),
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      FadeNavigation(widget: LoginScreen()));
                                },
                                child: Text(
                                  'Get Started',
                                  style: GoogleFonts.poppins(fontSize: 18),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ))),
            Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(bottom: 40),
                  // child: ,
                ))
          ],
        ),
      ),
    );
  }

  Container createContent(int index, String msg) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: AnimatedOpacity(
        opacity: currentIndex == index ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: Column(
          children: <Widget>[
            Text(
              'BE A WINNER',
              maxLines: 3,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '$msg',
              maxLines: 3,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
