import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AiFeedback extends StatefulWidget {
  const AiFeedback({super.key});

  @override
  State<AiFeedback> createState() => _AiFeedbackState();
}

class _AiFeedbackState extends State<AiFeedback> {
  List<dynamic> taskList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFeedback();
  }

  void loadFeedback() async {
    final box = await Hive.openBox('feedStore');
    setState(() {
      taskList = box.get('taskList', defaultValue: []);
      _isLoading = false;
    });
    
    // Debug print to help diagnose issues
    debugPrint('Loaded feedback taskList: $taskList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text(
          "AI Insights",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: loadFeedback,
          ),
        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Text(
              "Your Personal Analysis",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "AI-generated insights based on your diary entries",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 24),
            
            // AI Feedback list
            Expanded(
              child: _buildFeedbackList(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFeedbackList() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.orangeAccent,
        ),
      );
    }

    if (taskList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_neutral,
              size: 64,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 16),
            Text(
              "No AI insights found",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Add some diary entries to see AI insights",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        final entry = taskList[index];
        
        // Debug print to help diagnose the structure
        debugPrint('Entry $index: $entry');
        
        // Safely extract values, providing defaults if missing
        final date = entry['date'] ?? 'No date';
        final moodTitle = entry['moodTitle'] ?? 'Unknown mood';
        final aiMessage = entry['aiMessage'] ?? 'No AI insights available';
        
        // Get color from stored integer value or default to grey
        Color moodColor;
        try {
          if (entry['moodColor'] != null) {
            moodColor = Color(entry['moodColor']);
          } else {
            moodColor = Colors.grey;
          }
        } catch (e) {
          debugPrint('Error converting color: $e');
          moodColor = Colors.grey;
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildFeedbackCard(
            date: date,
            moodTitle: moodTitle,
            aiMessage: aiMessage,
            moodColor: moodColor,
          ),
        );
      },
    );
  }
  
  Widget _buildFeedbackCard({
    required String date,
    required String moodTitle,
    required String aiMessage,
    required Color moodColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Entry header
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: moodColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  moodTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // AI Response section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.psychology,
                    color: Colors.orangeAccent,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "AI Insight",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        aiMessage,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade300,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Action buttons
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // View original entry - you'll implement this later
                  },
                  icon: const Icon(
                    Icons.visibility_outlined,
                    size: 16,
                    color: Colors.orangeAccent,
                  ),
                  label: const Text(
                    "View Entry",
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}