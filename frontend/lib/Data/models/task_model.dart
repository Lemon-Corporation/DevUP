// Модель для общей части всех заданий
abstract class Task {
  final String id;
  final String title;
  final String category;
  final String difficulty;
  final String track;
  final String type;
  final int xpReward;
  final int energyCost;
  
  Task({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.track,
    required this.type,
    required this.xpReward,
    required this.energyCost,
  });
  
  // Фабричный метод для создания задания нужного типа на основе данных
  factory Task.fromJson(Map<String, dynamic> json) {
    final type = json["type"];
    
    if (type == "Тест") {
      return TestTask.fromJson(json);
    } else if (type == "Анализ кода") {
      return CodeAnalysisTask.fromJson(json);
    } else {
      return AlgorithmTask.fromJson(json);
    }
  }
}

// Модель для тестовых заданий
class TestTask extends Task {
  final List<Question> questions;
  
  TestTask({
    required String id,
    required String title,
    required String category,
    required String difficulty,
    required String track,
    required int xpReward,
    required int energyCost,
    required this.questions,
  }) : super(
    id: id,
    title: title,
    category: category,
    difficulty: difficulty,
    track: track,
    type: "Тест",
    xpReward: xpReward,
    energyCost: energyCost,
  );
  
  factory TestTask.fromJson(Map<String, dynamic> json) {
    final List<Question> questions = (json["questions"] as List?)
        ?.map((q) => Question.fromJson(q))
        .toList() ?? [];
    
    return TestTask(
      id: json["id"],
      title: json["title"],
      category: json["category"],
      difficulty: json["difficulty"],
      track: json["track"],
      xpReward: json["xpReward"],
      energyCost: json["energyCost"],
      questions: questions,
    );
  }
}

// Модель для анализа кода
class CodeAnalysisTask extends Task {
  final String codeSnippet;
  final String question;
  final String correctAnswer;
  
  CodeAnalysisTask({
    required String id,
    required String title,
    required String category,
    required String difficulty,
    required String track,
    required int xpReward,
    required int energyCost,
    required this.codeSnippet,
    required this.question,
    required this.correctAnswer,
  }) : super(
    id: id,
    title: title,
    category: category,
    difficulty: difficulty,
    track: track,
    type: "Анализ кода",
    xpReward: xpReward,
    energyCost: energyCost,
  );
  
  factory CodeAnalysisTask.fromJson(Map<String, dynamic> json) {
    return CodeAnalysisTask(
      id: json["id"],
      title: json["title"],
      category: json["category"],
      difficulty: json["difficulty"],
      track: json["track"],
      xpReward: json["xpReward"],
      energyCost: json["energyCost"],
      codeSnippet: json["code"] ?? "",
      question: json["question"] ?? "",
      correctAnswer: json["correctAnswer"] ?? "",
    );
  }
}

// Модель для алгоритмической задачи
class AlgorithmTask extends Task {
  final String description;
  final String? exampleInput;
  final String? exampleOutput;
  final String? sampleSolution;
  final List<Example>? examples;
  
  AlgorithmTask({
    required String id,
    required String title,
    required String category,
    required String difficulty,
    required String track,
    required int xpReward,
    required int energyCost,
    required this.description,
    this.exampleInput,
    this.exampleOutput,
    this.sampleSolution,
    this.examples,
  }) : super(
    id: id,
    title: title,
    category: category,
    difficulty: difficulty,
    track: track,
    type: "Задача с развернутым ответом",
    xpReward: xpReward,
    energyCost: energyCost,
  );
  
  factory AlgorithmTask.fromJson(Map<String, dynamic> json) {
    final List<Example>? examples = (json["examples"] as List?)
        ?.map((e) => Example.fromJson(e))
        .toList();
    
    return AlgorithmTask(
      id: json["id"],
      title: json["title"],
      category: json["category"],
      difficulty: json["difficulty"],
      track: json["track"],
      xpReward: json["xpReward"],
      energyCost: json["energyCost"],
      description: json["description"] ?? json["problem"] ?? "",
      exampleInput: json["exampleInput"],
      exampleOutput: json["exampleOutput"],
      sampleSolution: json["sampleSolution"],
      examples: examples,
    );
  }
}

// Модель вопроса для тестового задания
class Question {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;
  
  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
  
  factory Question.fromJson(Map<String, dynamic> json) {
    final List<String> options = (json["options"] as List?)
        ?.map((o) => o.toString())
        .toList() ?? [];
    
    return Question(
      question: json["question"] ?? "",
      options: options,
      correctAnswer: json["correctAnswer"] ?? 0,
      explanation: json["explanation"] ?? "",
    );
  }
}

// Модель примера для алгоритмической задачи
class Example {
  final String input;
  final String output;
  final String? explanation;
  
  Example({
    required this.input,
    required this.output,
    this.explanation,
  });
  
  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(
      input: json["input"] ?? "",
      output: json["output"] ?? "",
      explanation: json["explanation"],
    );
  }
}

// Класс для хранения и управления задачами
class TaskRepository {
  // Статический метод для получения всех задач
  static List<Task> getAllTasks() {
    final List<Task> allTasks = [];
    allTasks.addAll(_generateTestTasks());
    allTasks.addAll(_generateCodeAnalysisTasks());
    allTasks.addAll(_generateAlgorithmTasks());
    return allTasks;
  }
  
  // Получение задачи по ID
  static Task? getTaskById(String id) {
    try {
      return getAllTasks().firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // Получение задач по типу
  static List<Task> getTasksByType(String type) {
    return getAllTasks().where((task) => task.type == type).toList();
  }
  
  // Получение задач по направлению (треку)
  static List<Task> getTasksByTrack(String track) {
    return getAllTasks().where((task) => task.track == track).toList();
  }
  
  // Тестовые задания
  static List<TestTask> _generateTestTasks() {
    return [
      TestTask(
        id: "test1",
        title: "Основы JavaScript",
        category: "JavaScript",
        difficulty: "Легкий",
        track: "Junior Frontend (React)",
        xpReward: 10,
        energyCost: 2,
        questions: [
          Question(
            question: "Что выведет console.log(typeof null)?",
            options: ["null", "undefined", "object", "number"],
            correctAnswer: 2,
            explanation: "В JavaScript typeof null возвращает 'object', что считается ошибкой в языке.",
          ),
        ],
      ),
      TestTask(
        id: "test2",
        title: "SQL запросы",
        category: "SQL",
        difficulty: "Средний",
        track: "Junior Backend (Django)",
        xpReward: 15,
        energyCost: 3,
        questions: [
          Question(
            question: "Какой SQL запрос выберет уникальные значения из столбца name?",
            options: [
              "SELECT name FROM users",
              "SELECT UNIQUE name FROM users",
              "SELECT DISTINCT name FROM users",
              "SELECT DIFFERENT name FROM users"
            ],
            correctAnswer: 2,
            explanation: "Ключевое слово DISTINCT используется для получения уникальных значений из столбца.",
          ),
        ],
      ),
      TestTask(
        id: "test3",
        title: "Функции в JavaScript",
        category: "JavaScript",
        difficulty: "Средний",
        track: "Junior Frontend (React)",
        xpReward: 15,
        energyCost: 3,
        questions: [
          Question(
            question: "Что такое замыкание (closure) в JavaScript?",
            options: [
              "Функция, которая не имеет доступа к внешним переменным",
              "Функция, которая имеет доступ к переменным из внешней функции даже после завершения внешней функции",
              "Функция, которая закрывает соединение с сервером",
              "Функция, которая вызывает сама себя"
            ],
            correctAnswer: 1,
            explanation: "Замыкание - это функция, которая запоминает свое лексическое окружение даже после того, как внешняя функция завершилась.",
          ),
        ],
      ),
      TestTask(
        id: "test4",
        title: "Работа с объектами",
        category: "JavaScript",
        difficulty: "Средний",
        track: "Junior Frontend (React)",
        xpReward: 15,
        energyCost: 3,
        questions: [
          Question(
            question: "Какой метод используется для получения массива ключей объекта в JavaScript?",
            options: [
              "Object.keys(obj)",
              "Object.values(obj)",
              "Object.entries(obj)",
              "Object.getKeys(obj)"
            ],
            correctAnswer: 0,
            explanation: "Object.keys(obj) возвращает массив строковых ключей объекта obj.",
          ),
        ],
      ),
      TestTask(
        id: "test5",
        title: "Основы React",
        category: "React",
        difficulty: "Средний",
        track: "Junior Frontend (React)",
        xpReward: 20,
        energyCost: 4,
        questions: [
          Question(
            question: "Что такое JSX в React?",
            options: [
              "JavaScript XML - синтаксическое расширение JavaScript",
              "Java Syntax Extension",
              "JavaScript Extra Library",
              "JSON XML Format"
            ],
            correctAnswer: 0,
            explanation: "JSX - это синтаксическое расширение JavaScript, которое позволяет писать HTML-подобный код в JavaScript файлах.",
          ),
        ],
      ),
    ];
  }
  
  // Задания на анализ кода
  static List<CodeAnalysisTask> _generateCodeAnalysisTasks() {
    return [
      CodeAnalysisTask(
        id: "code1",
        title: "Анализ React компонента",
        category: "React",
        difficulty: "Средний",
        track: "Junior Frontend (React)",
        xpReward: 20,
        energyCost: 4,
        codeSnippet: """
function Counter() {
  const [count, setCount] = useState(0);
  
  useEffect(() => {
    document.title = "Clicked " + count + " times";
  });
  
  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}
        """,
        question: "Что произойдет при каждом клике на кнопку?",
        correctAnswer: "Значение count увеличится на 1, и заголовок документа обновится с новым значением count. useEffect будет вызываться после каждого рендера компонента.",
      ),
      CodeAnalysisTask(
        id: "code2",
        title: "Анализ замыканий",
        category: "JavaScript",
        difficulty: "Средний",
        track: "Junior Frontend (React)",
        xpReward: 20,
        energyCost: 4,
        codeSnippet: """
function createCounter() {
  let count = 0;
  
  return function() {
    count += 1;
    return count;
  };
}

const counter1 = createCounter();
const counter2 = createCounter();

console.log(counter1()); // ?
console.log(counter1()); // ?
console.log(counter2()); // ?
        """,
        question: "Что будет выведено в консоль?",
        correctAnswer: "1, 2, 1. Каждый вызов createCounter() создает новое замыкание со своей переменной count.",
      ),
      CodeAnalysisTask(
        id: "code3",
        title: "Анализ промисов",
        category: "JavaScript",
        difficulty: "Сложный",
        track: "Junior Frontend (React)",
        xpReward: 25,
        energyCost: 5,
        codeSnippet: """
function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function sequence() {
  console.log('a');
  
  await delay(1000);
  console.log('b');
  
  await delay(500);
  console.log('c');
  
  return 'done';
}

sequence().then(result => console.log(result));
console.log('d');
        """,
        question: "В каком порядке будут выведены буквы в консоль?",
        correctAnswer: "a, d, b, c, done. Сначала выводится 'a', затем код продолжает выполнение и выводит 'd', после чего через 1 секунду выводится 'b', через 0.5 секунды - 'c', и наконец 'done'.",
      ),
      CodeAnalysisTask(
        id: "code4",
        title: "Анализ React компонента с хуками",
        category: "React",
        difficulty: "Сложный",
        track: "Junior Frontend (React)",
        xpReward: 25,
        energyCost: 5,
        codeSnippet: """
function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    setLoading(true);
    fetchUser(userId)
      .then(data => {
        setUser(data);
        setLoading(false);
      });
  }, [userId]);
  
  if (loading) return <div>Loading...</div>;
  
  return (
    <div>
      <h1>{user.name}</h1>
      <p>Email: {user.email}</p>
    </div>
  );
}
        """,
        question: "Что произойдет, если компонент UserProfile получит новый userId через пропсы?",
        correctAnswer: "Сработает useEffect из-за изменения зависимости [userId], показатель loading станет true, будет сделан новый запрос fetchUser с новым userId, и когда данные загрузятся, компонент обновится с новыми данными пользователя.",
      ),
    ];
  }
  
  // Алгоритмические задачи
  static List<AlgorithmTask> _generateAlgorithmTasks() {
    return [
      AlgorithmTask(
        id: "algo1",
        title: "Поиск палиндрома",
        category: "Алгоритмы",
        difficulty: "Легкий",
        track: "Junior Frontend (React)",
        xpReward: 25,
        energyCost: 5,
        description: "Напишите функцию, которая проверяет, является ли строка палиндромом (читается одинаково слева направо и справа налево).",
        exampleInput: "racecar",
        exampleOutput: "true",
        sampleSolution: """
function isPalindrome(str) {
  const cleanStr = str.toLowerCase().replace(/[^a-z0-9]/g, '');
  return cleanStr === cleanStr.split('').reverse().join('');
}
        """,
      ),
      AlgorithmTask(
        id: "algo2",
        title: "Фильтрация массива",
        category: "Алгоритмы",
        difficulty: "Легкий",
        track: "Junior Frontend (React)",
        xpReward: 20,
        energyCost: 4,
        description: "Напишите функцию, которая фильтрует массив чисел, оставляя только четные числа.",
        exampleInput: "[1, 2, 3, 4, 5, 6]",
        exampleOutput: "[2, 4, 6]",
        sampleSolution: """
function filterEvenNumbers(numbers) {
  return numbers.filter(num => num % 2 === 0);
}
        """,
      ),
      AlgorithmTask(
        id: "algo3",
        title: "Асинхронная обработка",
        category: "JavaScript",
        difficulty: "Средний",
        track: "Junior Frontend (React)",
        xpReward: 30,
        energyCost: 6,
        description: "Напишите асинхронную функцию, которая получает данные из API и обрабатывает их. Используйте async/await.",
        exampleInput: "https://api.example.com/data",
        exampleOutput: "{ processed: true, data: [...] }",
        sampleSolution: """
async function fetchAndProcessData(url) {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    const data = await response.json();
    
    // Обработка данных
    const processedData = data.map(item => ({
      ...item,
      processed: true
    }));
    
    return {
      processed: true,
      data: processedData
    };
  } catch (error) {
    console.error('Error fetching data:', error);
    return {
      processed: false,
      error: error.message
    };
  }
}
        """,
      ),
    ];
  }
} 