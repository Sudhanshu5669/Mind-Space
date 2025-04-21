
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mind_space/Components/CustomAppBar.dart';
import 'package:mind_space/pages/addMood.dart';
import 'package:mind_space/Components/moodCard.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void addTask(){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Addmood()),
);
  }

  List<dynamic> taskList = [];

  @override
  void initState() {
    super.initState();
    loadMoods();
  }

  void loadMoods() async {
  await Hive.initFlutter(); // 🛠 Ensure initialization

  var box = await Hive.openBox('MoodStore');
  setState(() {
    taskList = box.get('taskList', defaultValue: []);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey.shade900,


      //appBar: SimpleAppBar(),

      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Take A Break", style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),



      // Floating add button start
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.add),
        ),
      // floating add button end


      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          final mood = taskList[index];
          return Moodcard(
            index: mood['index'],
            date: mood['date'],
            diary: mood['diary'],
          );
        },
      ),
      
      
      // BOTTOM NAVIGATION BAR START
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 14, 13, 13),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 14, 13, 13),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(16),
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.link,
                text: 'feedback',
                ),
              GButton(
                icon: Icons.settings,
                text: 'settings',
                ),
            ],
          ),
        ),
      ),
      // BOTTOM NAVIGATION BAR END




    );
  }
}