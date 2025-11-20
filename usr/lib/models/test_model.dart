enum TestType { quiz, imageMap, sequence, research }

class TestModel {
  final String id;
  final String title;
  final String description;
  final TestType type;
  final List<dynamic> questions; // Simplified for demo

  TestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.questions,
  });
}
