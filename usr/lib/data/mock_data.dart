import 'package:couldai_user_app/models/test_model.dart';

class MockData {
  static List<TestModel> getTestsForSection(String section) {
    // In a real app, this would filter by section. 
    // For demo, we return a mix of interactive types.
    
    return [
      TestModel(
        id: '1',
        title: 'Строение растительной клетки',
        description: 'Интерактивный тест: найдите органоиды на изображении клетки.',
        type: TestType.imageMap,
        questions: [],
      ),
      TestModel(
        id: '2',
        title: 'Фотосинтез: Этапы',
        description: 'Расставьте этапы фотосинтеза в правильном хронологическом порядке.',
        type: TestType.sequence,
        questions: [
          "Поглощение кванта света хлорофиллом",
          "Фотолиз воды",
          "Синтез АТФ",
          "Фиксация углекислого газа",
          "Синтез глюкозы"
        ],
      ),
      TestModel(
        id: '3',
        title: 'Семейства покрытосеменных',
        description: 'Классический тест на знание признаков семейств Крестоцветные и Розоцветные.',
        type: TestType.quiz,
        questions: [],
      ),
      TestModel(
        id: '4',
        title: 'Лабораторная: Влияние света',
        description: 'Виртуальное исследование: проведите опыт с элодеей и подсчитайте пузырьки газа.',
        type: TestType.research,
        questions: [],
      ),
      TestModel(
        id: '5',
        title: 'Жизненный цикл мхов',
        description: 'Соберите цикл развития кукушкина льна из фрагментов.',
        type: TestType.sequence,
        questions: [],
      ),
      TestModel(
        id: '6',
        title: 'Ткани растений',
        description: 'Определите тип ткани по микрофотографии среза стебля.',
        type: TestType.imageMap,
        questions: [],
      ),
    ];
  }
}
