import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:unibus/core/app_export.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late Material materialButton;

  late int index;

  final onboardingPagesList = [
    PageModel(
      widget: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 90.0,
              ),
              child: Image.asset(ImageConstant.bus,),
            ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Efficient Bus Transportation Management',
                  style: pageTitleStyle.copyWith(color: theme.primaryColor,fontSize: 16.0),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome to our app! Experience hassle-free bus transportation management tailored for universities and educational institutions.',
                  style: pageInfoStyle.copyWith(color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Streamline your travel needs with our comprehensive platform.',
                  style: pageInfoStyle.copyWith(color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    PageModel(
      widget: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 90.0,
              ),
              child: Image.asset(ImageConstant.map,),
            ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Real-Time Bus Tracking',
                  style: pageTitleStyle.copyWith(color: theme.primaryColor,fontSize: 16.0),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Never miss a bus again! Track bus locations in real-time and receive alerts before your bus arrives. ',
                  style: pageInfoStyle. copyWith(color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Our app ensures you\'re always informed about your transportation options.',
                  style: pageInfoStyle. copyWith(color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    PageModel(
      widget: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 90.0,
              ),
              child: Image.asset(ImageConstant.notifications,),
            ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Personalized Profiles and Notifications',
                  style: pageTitleStyle .copyWith(color: theme.primaryColor,fontSize: 16.0),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Customize your experience! Create a personalized profile to manage your contact information',
                  style: pageInfoStyle .copyWith(color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'and receive tailored notifications about bus arrivals, departures, and important updates.',
                  style: pageInfoStyle .copyWith(color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: theme.primaryColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  Material get _signupButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: PrimaryColors().primary2,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {
          Get.toNamed(AppRoutes.loginOrRegisterScreen);
        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Log In',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        centerTitle: true,
        title: Text(
          'UNIBUS',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Image.asset(ImageConstant.imgLogo)
        ],
      ),
        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return DecoratedBox(
              decoration: BoxDecoration(
                 border: Border.all(
                  width: 0.0,
                ),
              ),
              child: ColoredBox(
                color:Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIndicator(
                        netDragPercent: dragDistance,
                        pagesLength: pagesLength,
                        indicator: Indicator(
                          closedIndicator:   ClosedIndicator(
                            color: PrimaryColors().primary2,
                          ),
                          indicatorDesign: IndicatorDesign.polygon(
                            polygonDesign: PolygonDesign(
                               polygon: DesignType.polygon_pentagon,
                            ),
                          ),
                        ),
                      ),
                      index == pagesLength - 1
                          ? _signupButton
                          : _skipButton(setIndex: setIndex)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
