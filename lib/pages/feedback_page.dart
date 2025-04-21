import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.feedback_rounded,
                        color: Colors.orangeAccent,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Share Your Thoughts',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Help us improve your experience',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Feedback categories
              Text(
                'WHAT ARE YOU THINKING ABOUT?',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 15),
              
              // Category buttons
              Row(
                children: [
                  _buildCategoryButton(Icons.star_rounded, 'Feature'),
                  const SizedBox(width: 12),
                  _buildCategoryButton(Icons.bug_report_rounded, 'Bug'),
                  const SizedBox(width: 12),
                  _buildCategoryButton(Icons.lightbulb_rounded, 'Idea'),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Feedback input section
              Text(
                'YOUR FEEDBACK',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 15),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Share your experience or suggestion...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    contentPadding: const EdgeInsets.all(20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              
              const SizedBox(height: 25),
              
              // Email field (optional)
              Text(
                'YOUR EMAIL (OPTIONAL)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 15),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'email@example.com',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    contentPadding: const EdgeInsets.all(20),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Submit button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    shadowColor: Colors.orangeAccent.withOpacity(0.5),
                  ),
                  child: const Text(
                    'SUBMIT FEEDBACK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildCategoryButton(IconData icon, String label) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.orangeAccent,
                  size: 30,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}