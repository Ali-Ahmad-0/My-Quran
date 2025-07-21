import 'package:flutter/material.dart';
import 'package:quran/constants/colors.dart';
import 'package:quran/constants/lists.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurahContent extends StatefulWidget {
  final int startPage;
  final String surahName;
  final bool isDark;
  SurahContent({
    super.key,
    required this.startPage,
    required this.surahName,
    required this.isDark,
  });

  @override
  State<SurahContent> createState() => _SurahContentState();
}

class _SurahContentState extends State<SurahContent> {
  late PageController _pageController;
  Future<void> _setPageNumber(int page ,String name) async {
    final prfs = await SharedPreferences.getInstance();
    prfs.setInt('latestPageNumber', page);
    prfs.setString('surahName', name);
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.startPage - 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final portraitHeight = orientation == Orientation.portrait
        ? screenSize.height * 0.95
        : screenSize.height * 3;
    return Scaffold(
      backgroundColor: widget.isDark ? ktextColor : ksecondaryBackgroundColor,
      body: PageView.builder(
        controller: _pageController,
        reverse: true,
        onPageChanged: (index) {
          _setPageNumber(index + 1 , widget.surahName);
        },
        itemCount: pageImagePath.length,
        itemBuilder: (context, index) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: widget.isDark
                    ? ColorFiltered(
                        colorFilter: const ColorFilter.matrix(<double>[
                          -1, 0, 0, 0, 255, // Red
                          0, -1, 0, 0, 255, // Green
                          0, 0, -1, 0, 255, // Blue
                          0, 0, 0, 1, 0, // Alpha
                        ]),
                        child: Image.asset(
                          'Assets/quran_image/${pageImagePath[index]}',
                          fit: BoxFit.fill,
                          height: portraitHeight,
                        ),
                      )
                    : Image.asset(
                        'Assets/quran_image/${pageImagePath[index]}',
                        fit: BoxFit.fill,
                        height: portraitHeight,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${index + 1} الصفحة',
                      style: TextStyle(
                        fontFamily: 'amiri',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: widget.isDark
                            ? ksecondaryBackgroundColor
                            : ktextColor,
                      ),
                    ),
                    Text(
                      '${widget.surahName}',
                      style: TextStyle(
                        fontFamily: 'amiri',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: widget.isDark
                            ? ksecondaryBackgroundColor
                            : ktextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
