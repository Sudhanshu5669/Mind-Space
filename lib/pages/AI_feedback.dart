import 'package:flutter/material.dart';

class AiFeedback extends StatelessWidget {
  const AiFeedback({super.key});

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
            onPressed: () {
              // Refresh AI feedback - you'll implement this
            },
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
    // This is a placeholder. You'll replace this with actual data
    // from your backend when you implement the functionality
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildFeedbackCard(
          date: "April 21, 2025",
          moodTitle: "Happy day",
          aiMessage: "Placeholder for AI feedback. You'll replace this with actual feedback from your backend.",
          moodColor: Colors.green,
        ),
        const SizedBox(height: 16),
        _buildFeedbackCard(
          date: "April 20, 2025",
          moodTitle: "Feeling anxious",
          aiMessage: "Placeholder for AI feedback. You'll replace this with actual feedback from your backend.",
          moodColor: Colors.orange,
        ),
        const SizedBox(height: 16),
        _buildFeedbackCard(
          date: "April 19, 2025",
          moodTitle: "Mixed feelings",
          aiMessage: "Placeholder for AI feedback. You'll replace this with actual feedback from your backend.",
          moodColor: Colors.purple,
        ),
      ],
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
                    // View original entry - you'll implement this
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