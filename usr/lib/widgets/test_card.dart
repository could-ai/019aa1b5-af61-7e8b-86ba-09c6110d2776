import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/test_model.dart';
import 'package:couldai_user_app/screens/test_execution_screen.dart';

class TestCard extends StatelessWidget {
  final TestModel testData;

  const TestCard({super.key, required this.testData});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestExecutionScreen(test: testData),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header / Image Area
            Container(
              height: 120,
              width: double.infinity,
              color: _getTypeColor(testData.type),
              child: Center(
                child: Icon(
                  _getTypeIcon(testData.type),
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
            
            // Card Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testData.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      testData.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            _getTypeLabel(testData.type),
                            style: const TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          backgroundColor: _getTypeColor(testData.type),
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward, color: Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(TestType type) {
    switch (type) {
      case TestType.quiz:
        return Colors.green;
      case TestType.imageMap:
        return Colors.teal;
      case TestType.sequence:
        return Colors.orange;
      case TestType.research:
        return Colors.blue;
    }
  }

  IconData _getTypeIcon(TestType type) {
    switch (type) {
      case TestType.quiz:
        return Icons.quiz;
      case TestType.imageMap:
        return Icons.image_search;
      case TestType.sequence:
        return Icons.sort;
      case TestType.research:
        return Icons.science;
    }
  }

  String _getTypeLabel(TestType type) {
    switch (type) {
      case TestType.quiz:
        return "ТЕСТ";
      case TestType.imageMap:
        return "КАРТИНКА";
      case TestType.sequence:
        return "ПОСЛЕДОВАТЕЛЬНОСТЬ";
      case TestType.research:
        return "ИССЛЕДОВАНИЕ";
    }
  }
}
