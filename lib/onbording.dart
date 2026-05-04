import 'package:flutter/material.dart';
import 'package:sw2project/features/customer_flow/presentation/choose_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
      {
      "image": "assets/onbording/image1.jpeg",
      "title": "FAST SERVICE",
      "desc": "SHOW YOUR DIGITAL TICKET AND START YOUR TRANSACTION."
    },
    {
      "image": "assets/onbording/image2.jpeg",
      "title": "SAVE YOUR TIME",
      "desc": "BOOK YOUR BANK TURN FROM ANYWHERE AND WAIT LESS."
    },
    {
      "image": "assets/onbording/image3.jpeg", 
      "title": "LIVE TRACKING",
      "desc": "MONITOR YOUR TURN STEP-BY-STEP AND GET NOTIFIED."
    },
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) => _buildPageContent(
                  image: _onboardingData[index]["image"]!,
                  title: _onboardingData[index]["title"]!,
                  desc: _onboardingData[index]["desc"]!,
                ),
              ),
            ),
            
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => _buildDot(index: index),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage == _onboardingData.length - 1) {
                            // التوجيه لصفحة الـ Choose Service
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const ChooseServiceScreen()),
                            );
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF84CBE5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentPage == _onboardingData.length - 1 ? "GET STARTED" : "NEXT",
                          style: const TextStyle(
                            color: Colors.white, 
                            fontSize: 18, 
                            fontWeight: FontWeight.bold
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
      ),
    );
  }

  Widget _buildPageContent({required String image, required String title, required String desc}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image, 
          height: MediaQuery.of(context).size.height * 0.35, 
          width: MediaQuery.of(context).size.width * 0.8,   
          fit: BoxFit.contain, 
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 100, color: Colors.grey);
          },
        ),
        const SizedBox(height: 40),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            letterSpacing: 1.2,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16, 
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFF84CBE5) : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}