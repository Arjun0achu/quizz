import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:quizz/homescreen/selectionscreen.dart';

import 'package:share_plus/share_plus.dart';

class RatingScreen extends StatefulWidget {
   RatingScreen({super.key, required this.answercount,this.questionrating});
  final int answercount;

  dynamic questionrating;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int starcount = 0;

  @override
  void initState() {
    calculatepercentage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center( 
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            // Star Rating Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                3,
                (index) => Icon(
                  Icons.star,
                  color: starcount > index ? Colors.amberAccent : Colors.grey,
                  size: index == 1 ? 60 : 35,
                ),
              ),
            ),
            SizedBox(height: 10), 
            // Cached Image
            CachedNetworkImage(
              imageUrl: "http://via.placeholder.com/350x150",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 10), // Spacing
            // Congratulatory Text
            Text(
              'Congratulations!',
              style: TextStyle(fontSize: 20, color: Colors.amber),
            ),
            Text(
              'YOUR SCORE',
              style: TextStyle(fontSize: 15, color: Colors.amber),
            ),
            SizedBox(height: 7), 
            // Score Display
            Text(
              '${widget.answercount}/${widget.questionrating.length}',
              style: TextStyle(fontSize: 15, color: Colors.amber),
            ),
            SizedBox(height: 20), 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                  InkWell(
                    onTap: () {
                      Share.share('Check out my quiz score! https://example.com');
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow[50],
                      ),
                      child: Icon(Icons.share, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 20), 
                  // Retry Button
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Selectionscreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.replay_outlined, color: Colors.black),
                          SizedBox(width: 5),
                          Text(
                            'Retry',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void calculatepercentage() {
  if (widget.questionrating is List) {
    int totalQuestions = widget.questionrating.length;
    num percentage = (widget.answercount / totalQuestions) * 100;
    if (percentage >= 90) {
      starcount = 3;
    } else if (percentage >= 50) {
      starcount = 2;
    } else if (percentage >= 30) {
      starcount = 1;
    } else {
      starcount = 0;
    }
  } else {
    starcount = 0; 
  }
  setState(() {});
}

}
