import 'package:flutter/material.dart';
import 'package:quran/constants/colors.dart';
import 'package:quran/constants/lists.dart';

class AthkarScreen extends StatelessWidget {
  String keys;
  AthkarScreen({super.key, required this.keys});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ksecondaryBackgroundColor,
        title: Text(
          keys,
          style: TextStyle(
            color: kdarkColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Amiri', // or 'Poppins', or remove for default
          ),
        ),
        iconTheme: IconThemeData(color: kdarkColor), // for back button color
        elevation: 0, // flat look, optional
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: athkarMap[keys]!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  ListTile(
                    leading: Text(
                      'التكرار : ${athkarMap[keys]![index]['counter']} ',
                      style: TextStyle(
                        color: kdarkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    title: Text(
                      athkarMap[keys]![index]['text'] ?? 'unknown',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'amiri',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: MediaQuery.of(context).size.width * 0.1,
                        endIndent: MediaQuery.of(context).size.width * 0.1,
                        color: ktextColor,
                      ),
                      Image.asset('Assets/images/pattern.png', height: 30),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
