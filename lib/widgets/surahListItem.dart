import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/constants/colors.dart' show kbuttonColor, ktextColor;
import 'package:quran/views/surah_content.dart';

class Surah_list_item extends StatelessWidget {
   String name, revType, nOfSurahs, number;
   Surah_list_item(
     this.nOfSurahs,
     this.name,
     this.revType,
     this.number,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SurahContent()),
          );
        },

        child: Container(
          height: 70,
          child: Row(
            children: [
              Container(
                width: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: kbuttonColor,
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 335,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF6F1EB),
                  borderRadius: BorderRadius.circular(12), // optional
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.3,
                      ), // shadow color with opacity
                      spreadRadius: 3, // how much the shadow spreads
                      blurRadius: 8, // how soft the shadow is
                      offset: Offset(2, 4), // shadow position: x, y
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Stack(
                    children: [
                      SvgPicture.asset('Assets/images/muslim (1) 1.svg'),
                      Positioned(
                        top: 8,
                        left: number.length == 1 ? 14 : 10,
                        child: Text(
                          '$number',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Container(
                    width: 10,
                    child: Text(
                      revType,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    'عدد الاّيات : $nOfSurahs ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  trailing: Text(
                    '$name',
                    style: TextStyle(
                      color: ktextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Amiri',
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

// class surah_item extends StatelessWidget {
//   final String name, revType, nOfSurahs, number;

//   const surah_item({
//     super.key,
//     required this.name,
//     required this.revType,
//     required this.nOfSurahs,
//     required this.number,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Stack(
//         children: [
//           SvgPicture.asset('Assets/images/muslim (1) 1.svg'),
//           Positioned(
//             top: 8,
//             left: number.length == 1 ? 14 : 10,
//             child: Text(
//               '$number',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//       title: Text(
//         'عدد الاّيات : $nOfSurahs $revType',
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//       trailing: Text(
//         '$name',
//         style: TextStyle(
//           color: ktextColor,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Amiri',
//         ),
//       ),
//     );
//   }
// }
