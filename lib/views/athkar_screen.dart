import 'package:flutter/material.dart';
import 'package:quran/constants/colors.dart';
import 'package:quran/constants/lists.dart';

class AthkarScreen extends StatelessWidget {
  String keys;
  AthkarScreen({super.key, required this.keys});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الاذكار')),
      body: Expanded(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: Text(
                    'التكرار : 3 ',
                    style: TextStyle(
                      color: kbuttonColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  title: Text(
                    'أعوذ بالـلـه من الشيطان الـرجـيم ﴿اللهُ لاَ إِلَٰهَ إِلاَّ هُـوَ الْـحَيُّ الْـقَيُّومُ لاَ تَأخذُهُ سنَةٌ ولا نومٌ لهُ ما في السَّمَاوَاتِ وما في الأَرضِ من ذا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بإِذنهِ يعْلَمُ ما بينَ أيدِيهِمْ وما خلفَهُمْ ولا يُحيطُونَ بِشيءٍ مِّن عِلْمِهِ إِلاَّ بِمَا شَاء وَسعَ كُرْسيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤودُهُ حِفظُهُمَا وهوَ العَليُّ العَظيمُ﴾ ',
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Divider(height: 2, thickness: 1, color: ktextColor),
                    Image.asset(
                      'Assets/images/—Pngtree—hand drawn cartoon praying ramadan_5351151 1.png',
                      height: 30,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
