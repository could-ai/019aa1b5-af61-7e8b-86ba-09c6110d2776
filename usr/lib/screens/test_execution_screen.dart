import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/test_model.dart';

class TestExecutionScreen extends StatefulWidget {
  final TestModel test;

  const TestExecutionScreen({super.key, required this.test});

  @override
  State<TestExecutionScreen> createState() => _TestExecutionScreenState();
}

class _TestExecutionScreenState extends State<TestExecutionScreen> {
  // State for Sequence Type
  late List<String> _sequenceItems;

  @override
  void initState() {
    super.initState();
    if (widget.test.type == TestType.sequence && widget.test.questions.isNotEmpty) {
      _sequenceItems = List<String>.from(widget.test.questions);
      _sequenceItems.shuffle(); // Shuffle for the user to solve
    } else {
      _sequenceItems = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.test.title),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.test.description,
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: _buildInteractiveContent(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ответ принят! (Демо режим)')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('ПРОВЕРИТЬ ОТВЕТ'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveContent() {
    switch (widget.test.type) {
      case TestType.sequence:
        return _buildSequenceInteraction();
      case TestType.imageMap:
        return _buildImageInteraction();
      case TestType.research:
        return _buildResearchInteraction();
      case TestType.quiz:
      default:
        return _buildQuizInteraction();
    }
  }

  Widget _buildSequenceInteraction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Перетащите элементы в правильном порядке:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final String item = _sequenceItems.removeAt(oldIndex);
                _sequenceItems.insert(newIndex, item);
              });
            },
            children: [
              for (int i = 0; i < _sequenceItems.length; i++)
                Card(
                  key: ValueKey(_sequenceItems[i]),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.green[50],
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text('${i + 1}', style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(_sequenceItems[i]),
                    trailing: const Icon(Icons.drag_handle),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageInteraction() {
    return Center(
      child: Container(
        width: 600,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 100, color: Colors.grey),
                  Text("Здесь будет изображение клетки"),
                ],
              ),
            ),
            // Example interactive point
            Positioned(
              top: 100,
              left: 150,
              child: Tooltip(
                message: "Ядро",
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.green.withOpacity(0.7),
                  child: const Icon(Icons.question_mark, size: 15, color: Colors.white),
                ),
              ),
            ),
             Positioned(
              bottom: 80,
              right: 120,
              child: Tooltip(
                message: "Вакуоль",
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.green.withOpacity(0.7),
                  child: const Icon(Icons.question_mark, size: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResearchInteraction() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.science, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          const Text("Виртуальная лаборатория", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("Перетащите реагенты в пробирку (Демо)"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Draggable<String>(
                data: "water",
                feedback: const Icon(Icons.water_drop, size: 50, color: Colors.blue),
                childWhenDragging: const Icon(Icons.water_drop, size: 50, color: Colors.grey),
                child: const Column(
                  children: [
                    Icon(Icons.water_drop, size: 50, color: Colors.blue),
                    Text("Вода"),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              DragTarget<String>(
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: candidateData.isNotEmpty ? Colors.green : Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(child: Text("Пробирка")),
                  );
                },
                onAccept: (data) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Добавлено: Вода")));
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQuizInteraction() {
    return ListView(
      children: [
        const Text("Вопрос 1: Какая функция у хлоропластов?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        RadioListTile(value: 1, groupValue: 0, onChanged: (v){}, title: const Text("Синтез белка")),
        RadioListTile(value: 2, groupValue: 0, onChanged: (v){}, title: const Text("Фотосинтез")),
        RadioListTile(value: 3, groupValue: 0, onChanged: (v){}, title: const Text("Дыхание")),
        RadioListTile(value: 4, groupValue: 0, onChanged: (v){}, title: const Text("Запас веществ")),
      ],
    );
  }
}
