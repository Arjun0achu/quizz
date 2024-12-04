import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz/dummydb/dummydb.dart';
import 'package:quizz/quizz_screen/quizz_screen.dart';


class Selectionscreen extends StatelessWidget {
  Selectionscreen({super.key});

  static List<Map<String, String>> selectionimage = [
    {
      "title": "Movie",
      "image": "assets/animations/pexels-obregonia-d-toretto-325418-918281.jpg",
    },
    {
      "title": "Sports",
      "image": "assets/animations/pexels-punlob-173477-564094.jpg",
    },
    {
      "title": "Gym",
      "image": "assets/animations/pexels-victorfreitas-841130.jpg",
    },
    {
      "title": "Football",
      "image": "assets/animations/pexels-pixabay-39362.jpg",
    },
    {
      "title": "Maths",
      "image": "assets/animations/pexels-jeshoots-com-147458-714699.jpg",
    },
    {
      "title": "Animals",
      "image": "assets/animations/pexels-lestrade84-17811.jpg",
    },
  ];

  final List<List<dynamic>> answer = [
    Dummydb.MovieQuestion,
    Dummydb.racingQuestion,
    Dummydb.GymQuestion,
    Dummydb.FootballQuestion,
    Dummydb.MathsQuestion,
    Dummydb.AnimalQuestion,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 143, 198),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Category',
              style: GoogleFonts.roboto(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.custom(
                gridDelegate: SliverStairedGridDelegate(
                  pattern: [
                    StairedGridTile(0.5, 1),
                    StairedGridTile(0.5, 1),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: selectionimage.length,
                  (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  datashare: answer[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 150,
                            width: 120,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  selectionimage[index]['image']!,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          selectionimage[index]['title']!,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
