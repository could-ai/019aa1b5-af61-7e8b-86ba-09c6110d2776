import 'package:flutter/material.dart';
import 'package:couldai_user_app/widgets/test_card.dart';
import 'package:couldai_user_app/data/mock_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedSection = 'Класс';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Row(
        children: [
          // Left Sidebar
          _buildSidebar(),
          
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top Header
                _buildHeader(context),
                
                // Content Grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _buildContentGrid(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.eco, size: 64, color: Colors.green),
          const SizedBox(height: 40),
          _buildSidebarItem('Класс', Icons.school),
          _buildSidebarItem('ОГЭ', Icons.assignment),
          _buildSidebarItem('ЕГЭ', Icons.school_outlined),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', // Placeholder for plant image
              height: 100,
              errorBuilder: (c, e, s) => const Icon(Icons.local_florist, size: 80, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(String title, IconData icon) {
    final isSelected = _selectedSection == title;
    return Material(
      color: isSelected ? Colors.green.withOpacity(0.1) : Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedSection = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            border: isSelected 
                ? const Border(right: BorderSide(color: Colors.green, width: 4))
                : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? Colors.green : Colors.grey),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.green[800] : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Empty space to balance the layout if needed, or breadcrumbs
          const SizedBox(width: 150), 
          
          const Spacer(),
          
          // Center Title
          Text(
            'biOne',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.green[800],
              letterSpacing: 1.5,
            ),
          ),
          
          const Spacer(),
          
          // Right Side - Personal Cabinet
          TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Row(
                    children: [
                      Icon(Icons.engineering, color: Colors.orange),
                      SizedBox(width: 10),
                      Text("В разработке"),
                    ],
                  ),
                  content: const Text("Работаем над этим, ждите обновлений!"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("ОК"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.person, color: Colors.green),
            label: const Text(
              "Личный кабинет",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              backgroundColor: Colors.green.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentGrid() {
    // Filter mock data based on section (mock logic)
    final tests = MockData.getTestsForSection(_selectedSection);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        childAspectRatio: 1.2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: tests.length,
      itemBuilder: (context, index) {
        return TestCard(testData: tests[index]);
      },
    );
  }
}
