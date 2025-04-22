
import 'package:flutter/material.dart';
import 'package:mind_space/Components/CustomAppBar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mind_space/services/secure_storage_service.dart';

class Addmood extends StatefulWidget {
  const Addmood({super.key});

  @override
  State<Addmood> createState() => _AddmoodState();
}

class _AddmoodState extends State<Addmood> {

  final _secureStorage = SecureStorageService();

  // Track selected mood
  String selectedMood = '';

  // List of moods with emoji and labels - using direct Color objects
  final List<Map<String, dynamic>> moods = [
    {
      'emoji': '😫', 
      'label': 'Horrible',
      'color': Color(0xFFB71C1C) // Using direct Color object instead of Colors.red.shade800
    },
    {
      'emoji': '😟', 
      'label': 'Bad',
      'color': Color(0xFFD84315) // Using direct Color object instead of Colors.orange.shade800
    },
    {
      'emoji': '😐', 
      'label': 'Neutral',
      'color': Color(0xFFFBC02D) // Using direct Color object instead of Colors.yellow.shade700
    },
    {
      'emoji': '😊', 
      'label': 'Good',
      'color': Color(0xFF7CB342) // Using direct Color object instead of Colors.lightGreen.shade600
    },
    {
      'emoji': '😁', 
      'label': 'Amazing',
      'color': Color(0xFF2E7D32) // Using direct Color object instead of Colors.green.shade600
    },
  ];

  final _moodBox = Hive.box('MoodStore');

  dynamic calcRes(Map<String, dynamic> taskok) {
  // Extract the values from the map
  double anxiety = taskok["anxietyLevel"]?.toDouble() ?? 0.0;
  double lowMood = taskok["lowMoodLevel"]?.toDouble() ?? 0.0;
  double contentment = taskok["contentmentLevel"]?.toDouble() ?? 0.0;
  double frustration = taskok["frustrationLevel"]?.toDouble() ?? 0.0;
  double excitement = taskok["excitementLevel"]?.toDouble() ?? 0.0;

  // Weights
  double contentmentWeight = 0.6;
  double excitementWeight = 0.4;

  double anxietyWeight = 0.3;
  double lowMoodWeight = 0.4;
  double frustrationWeight = 0.3;

  // Calculate mood score
  double positive = (contentment * contentmentWeight) + (excitement * excitementWeight);
  double negative = (anxiety * anxietyWeight) + (lowMood * lowMoodWeight) + (frustration * frustrationWeight);

  double moodScore = positive - negative;
  print(moodScore);
  return moodScore;
}



  dynamic _getFeedback() async {
    final String? token = await _secureStorage.getToken();
    print(token);
    var response = await http.get(
      Uri.parse("http://192.168.227.240:3000/moodScore/feedback"),
         headers: {
           'Cookie': 'session=${token}',
           'Content-Type': 'application/json',
         },
         
 );

      if(response.statusCode == 200){
      final responseData = jsonDecode(response.body);
      print(responseData);
      return responseData;
    } else if(response.statusCode == 401){
      final responseData = jsonDecode(response.body);
      return responseData;
    }


  }

  dynamic getFeedback(taskok) async {
    var response = await _getFeedback();
    var box = await Hive.openBox('feedStore');

    var calc = calcRes(taskok);

    String str = "";
    int color = 0;

    if(calc >= 0 && calc < 3.5){
      str = "Mixed feelings";
      calc = 1;
      color = Colors.deepPurple.toARGB32();
    } else if (calc >= 3.5 && calc < 7){
      str = "Neutral feelings";
      calc = 2;
      color = Colors.yellow.toARGB32();
    } else{
      str = "Feelings good";
      calc = 3;
      color = Colors.green.toARGB32();
    }


    List<dynamic> taskList = box.get('taskList', defaultValue: []);
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";
    print("Response: $response");
    Map<String, dynamic> task = {'date': formattedDate, 'moodTitle': str, 'aiMessage': response["feedback"], 'moodColor': color};
    taskList.insert(0, task);
    box.put('taskList', taskList);
    print(task);
  }





  dynamic _submitMood(mood, diary) async {

    var index = 0;
    switch (mood) {
      case "Horrible": index = 1; break;
      case "Bad": index = 2; break;
      case "Neutral": index = 3; break;
      case "Good": index = 4; break;
      case "Amazing": index = 5; break;
    }

    final String? token = await _secureStorage.getToken();

    var response = await http.post(
      Uri.parse("http://192.168.227.240:3000/moodScore"),
         headers: {
           'Cookie': 'session=${token}',
           'Content-Type': 'application/json',
         },
         body: jsonEncode({
           'selfRating': index,
           'text': diary,
         }),
    );

    if(response.statusCode == 200){
      final responseData = jsonDecode(response.body);
      print(responseData);
      return responseData;
    } else if(response.statusCode == 401){
      final responseData = jsonDecode(response.body);
    }

  }

  /*
  {
  "anxietyLevel": 4,
  "lowMoodLevel": 3,
  "contentmentLevel": 6,
  "frustrationLevel": 2,
  "excitementLevel": 5
  }
  */


  void addData(mood, diary) async {

    var response = await _submitMood(mood, diary);

    var box = await Hive.openBox('MoodStore');
    List<dynamic> taskList = box.get('taskList', defaultValue: []);
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";
    Map<String, dynamic> task = {'index': mood, 'date': formattedDate, 'diary': diary, 'anxietyLevel': response["anxietyLevel"], 'lowMoodLevel': response["lowMoodLevel"],'contentmentLevel': response["contentmentLevel"], 'frustrationLevel': response["frustrationLevel"], 'excitementLevel': response["excitementLevel"]};
    taskList.insert(0, task);
    _moodBox.put('taskList', taskList);
    print(task);

    getFeedback(task);
  }

  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: SimpleAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const Text(
            'How are you feeling today?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: moods.length,
              itemBuilder: (context, index) {
                final mood = moods[index];
                final isSelected = selectedMood == mood['label'];
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMood = mood['label'];
                      });
                    },
                    child: Card(
                      elevation: 4,
                      color: isSelected ? mood['color'] : Colors.grey.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              mood['emoji'],
                              style: const TextStyle(fontSize: 32),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              mood['label'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (selectedMood.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      hintText: "Add a note about how you're feeling...",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    style: const TextStyle(color: Colors.white),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Log the selected mood
                        addData(selectedMood, _noteController.text);
                      print('Note: ${_noteController.text}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mood saved: $selectedMood')),
                      );
                      // Here you would save to database and navigate back
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedMood.isNotEmpty 
                          ? getMoodColor(selectedMood) 
                          : Colors.blue, // Provide default color
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save Mood',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
  
  // Helper method to get color based on mood with null safety
  Color getMoodColor(String mood) {
    for (var m in moods) {
      if (m['label'] == mood && m['color'] != null) {
        return m['color'];
      }
    }
    return Colors.blue; // Default fallback color
  }

  
}

