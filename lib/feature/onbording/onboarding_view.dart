import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/app_text_style.dart';
import 'package:se7ety/feature/onbording/onboarder_model.dart';
import 'package:se7ety/welcome_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  var pagecn = PageController();
  int lastIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: () {}, child: const Text('تخطي'))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  lastIndex = value;
                });
              },
              itemCount: model.length,
              controller: pagecn,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      SvgPicture.asset(model[index].image),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        model[index].title,
                        style: getTitleStyle(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        model[index].describtion,
                        textAlign: TextAlign.center,
                        style: getbodyStyle(),
                      ),
                      const Spacer(
                        flex: 2,
                      )
                    ],
                  ),
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    SmoothPageIndicator(
                      controller: pagecn,
                      count: model.length,
                      effect: WormEffect(
                        activeDotColor: AppColors.color1,
                        dotHeight: 10,
                      ),
                      onDotClicked: (index) {},
                    ),
                    const Spacer(),
                    (lastIndex == model.length - 1)
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const WelcomeView(),
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.color1,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'هيا بنا',
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
