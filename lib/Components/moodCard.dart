
import 'package:flutter/material.dart';


class Moodcard extends StatelessWidget {
  final String index;
  final String date;
  final String diary;
  final int anxietyLevel;
  final int lowMoodLevel;
  final int contentmentLevel;
  final int frustrationLevel;
  final int excitementLevel;

  const Moodcard(
    {
    super.key,
    required this.index,
    required this.date,
    required this.diary,
    this.anxietyLevel = 0,
    this.lowMoodLevel = 0,
    this.contentmentLevel = 0,
    this.frustrationLevel = 0,
    this.excitementLevel = 0,
    }
    );

    dynamic deleteCard(){

    }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Text("Mood: $index", style: TextStyle(color: Colors.orangeAccent)),
                  SizedBox(width: 200),
                  //Icon(Icons.delete, color: Colors.orangeAccent,)
                ],
              ),
              SizedBox(height: 8),
              Text(date, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 12),
              Text(diary, style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
