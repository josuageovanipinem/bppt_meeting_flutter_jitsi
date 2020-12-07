import 'dart:io';
import 'package:bppt_meeting/material/palette.dart';
import 'package:bppt_meeting/meeting.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key key}) : super(key: key);

  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final int _totalPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Container(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              _currentPage = page;
              setState(() {});
            },
            children: <Widget>[
              _buildPageContent(
                  image: 'assets/images/onboarding/1.png',
                  title: 'BPPT Solid',
                  body:
                      'Penguatan kelembagaan dan regulasi baik secara internal dan external. Dengan mengedepankan visi dan misi BPPT serta tugas pokok BPPT sebagai lembaga kaji terap tekhnologi'),
              _buildPageContent(
                  image: 'assets/images/onboarding/2.png',
                  title: 'BPPT Smart',
                  body:
                      'Membangun sumber daya manusia BPPT, sebagai human capital yang mumpuni. Memberdayakan asset sumber daya manusia perekayasa, peneliti serta jabatan fungsional lainnya agar menjadi kekuatan di dalam menjalankan human centric innovation'),
              _buildPageContent(
                  image: 'assets/images/onboarding/3.png',
                  title: 'BPPT Speed',
                  body:
                      'Mendorong terbangunnya program flagship nasional di berbagai bidang tekhnologi.Dengan tujuan akhir menjadi rekomendasi bagi seluruh Lembaga pemerintah dan swasta dalam mewujudkan Indonesia maju dan mandiri.')
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage != 2
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _pageController.animateToPage(2,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.linear);
                      setState(() {});
                    },
                    splashColor: Colors.teal[300],
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                          color: Colors.teal[600], fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    child: Row(children: [
                      for (int i = 0; i < _totalPages; i++)
                        i == _currentPage
                            ? _buildPageIndicator(true)
                            : _buildPageIndicator(false)
                    ]),
                  ),
                  FlatButton(
                    onPressed: () {
                      _pageController.animateToPage(_currentPage + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                      setState(() {});
                    },
                    splashColor: Colors.blue[50],
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                          color: Colors.teal[600], fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            )
          : InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Meeting()));
              },
              child: Container(
                height: Platform.isIOS ? 70 : 60,
                color: Colors.teal[300],
                alignment: Alignment.center,
                child: Text(
                  'GET STARTED NOW',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
    );
  }

  Widget _buildPageContent({
    String image,
    String title,
    String body,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(image),
          ),
          SizedBox(height: 40),
          Align(
            alignment: Alignment
                .center, // Align however you like (i.e .centerRight, centerLeft)
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17,
                  height: 2.0,
                  fontWeight: FontWeight.w600,
                  color: Palette.titleColor),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text(
              body,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.5, height: 1.5, color: Palette.descriptionColor),
            ),
          ),
        ],
      ),
    );
  }
}
