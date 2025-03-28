import 'package:devup/Values/values.dart';
import 'package:flutter/material.dart';

class AppData {
  static final List<String> difficultyLevels = ["Легкий", "Средний", "Сложный"];

  static final List<String> programmingTracks = [
    "Junior Frontend (React)",
    "Junior Backend (Django)",
    "Junior Backend (Spring)",
    "Middle Frontend (React)",
    "Middle Backend (Django)",
    "Middle Backend (Spring)"
  ];

  static final List<String> taskTypes = [
    "Тест",
    "Анализ кода",
    "Задача с развернутым ответом"
  ];

  static final List<String> taskCategories = [
    "Алгоритмы",
    "Структуры данных",
    "JavaScript",
    "React",
    "Python",
    "Django",
    "Java",
    "Spring",
    "SQL",
    "Архитектура",
    "Паттерны проектирования",
    "Сети",
    "Git",
    "Soft Skills"
  ];

  static final List<Map<String, dynamic>> testTasks = [
    {
      "id": "test1",
      "title": "Основы JavaScript",
      "category": "JavaScript",
      "difficulty": "Легкий",
      "track": "Junior Frontend (React)",
      "type": "Тест",
      "xpReward": 10,
      "energyCost": 2,
      "questions": [
        {
          "question": "Что выведет console.log(typeof null)?",
          "options": ["null", "undefined", "object", "number"],
          "correctAnswer": 2,
          "explanation":
              "В JavaScript typeof null возвращает 'object', что считается ошибкой в языке."
        }
      ],
      "nextTaskId": "test2"
    },
    {
      "id": "test2",
      "title": "SQL запросы",
      "category": "SQL",
      "difficulty": "Средний",
      "track": "Junior Backend (Django)",
      "type": "Тест",
      "xpReward": 15,
      "energyCost": 3,
      "questions": [
        {
          "question":
              "Какой SQL запрос выберет уникальные значения из столбца name?",
          "options": [
            "SELECT name FROM users",
            "SELECT UNIQUE name FROM users",
            "SELECT DISTINCT name FROM users",
            "SELECT DIFFERENT name FROM users"
          ],
          "correctAnswer": 2,
          "explanation":
              "Ключевое слово DISTINCT используется для получения уникальных значений из столбца."
        }
      ],
      "nextTaskId": "test3"
    },
    {
      "id": "test3",
      "title": "React Hooks",
      "category": "React",
      "difficulty": "Средний",
      "track": "Junior Frontend (React)",
      "type": "Тест",
      "xpReward": 15,
      "energyCost": 3,
      "questions": [
        {
          "question":
              "Какой хук используется для выполнения побочных эффектов в функциональных компонентах React?",
          "options": ["useState", "useEffect", "useContext", "useReducer"],
          "correctAnswer": 1,
          "explanation":
              "useEffect используется для выполнения побочных эффектов, таких как запросы к API, подписки на события и т.д."
        }
      ],
      "nextTaskId": "code1"
    }
  ];

  static final List<Map<String, dynamic>> codeAnalysisTasks = [
    {
      "id": "code1",
      "title": "Анализ React компонента",
      "category": "React",
      "difficulty": "Средний",
      "track": "Junior Frontend (React)",
      "type": "Анализ кода",
      "xpReward": 20,
      "energyCost": 4,
      "codeSnippet": """
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
      "questions": [
        {
          "question": "Что произойдет при каждом клике на кнопку?",
          "options": [
            "Значение count увеличится на 1, но заголовок документа не изменится",
            "Значение count увеличится на 1, и заголовок документа обновится только при первом рендере",
            "Значение count увеличится на 1, и заголовок документа обновится с новым значением count",
            "Произойдет ошибка, так как не импортированы useState и useEffect"
          ],
          "correctAnswer": 2,
          "explanation":
              "useEffect будет вызываться после каждого рендера компонента, обновляя заголовок документа с новым значением count."
        }
      ],
      "nextTaskId": "code2"
    },
    {
      "id": "code2",
      "title": "Выбор лучшего кода",
      "category": "JavaScript",
      "difficulty": "Средний",
      "track": "Junior Frontend (React)",
      "type": "Анализ кода",
      "xpReward": 25,
      "energyCost": 4,
      "description":
          "Выберите наиболее оптимальный вариант кода для решения задачи: найти сумму всех чисел в массиве.",
      "questions": [
        {
          "question":
              "Какой из вариантов кода наиболее оптимален и соответствует современным практикам?",
          "options": [
            """
function sumArray(arr) {
  let sum = 0;
  for(let i = 0; i < arr.length; i++) {
    sum += arr[i];
  }
  return sum;
}
            """,
            """
function sumArray(arr) {
  return arr.reduce((acc, curr) => {
    return acc + curr;
  }, 0);
}
            """,
            """
function sumArray(arr) {
  let sum = 0;
  arr.forEach(function(num) {
    sum = sum + num;
  });
  return sum;
}
            """,
            """
function sumArray(arr) {
  let sum = 0;
  let i = 0;
  while(i < arr.length) {
    sum += arr[i];
    i++;
  }
  return sum;
}
            """
          ],
          "correctAnswer": 1,
          "explanation":
              "Вариант с использованием reduce является наиболее функциональным и декларативным подходом, что соответствует современным практикам JavaScript. Он также более читаемый и компактный."
        }
      ],
      "nextTaskId": "algo1"
    }
  ];

  // Примеры задач с развернутым ответом
  static final List<Map<String, dynamic>> algorithmTasks = [
    {
      "id": "algo1",
      "title": "Поиск палиндрома",
      "category": "Алгоритмы",
      "difficulty": "Легкий",
      "track": "Junior Frontend (React)",
      "type": "Задача с развернутым ответом",
      "xpReward": 25,
      "energyCost": 5,
      "description":
          "Напишите функцию, которая проверяет, является ли строка палиндромом (читается одинаково слева направо и справа налево).",
      "examples": [
        {
          "input": "racecar",
          "output": "true",
          "explanation":
              "Строка 'racecar' читается одинаково в обоих направлениях"
        },
        {
          "input": "hello",
          "output": "false",
          "explanation": "Строка 'hello' не является палиндромом"
        }
      ],
      "sampleSolution": """
function isPalindrome(str) {
  const cleanStr = str.toLowerCase().replace(/[^a-z0-9]/g, '');
  return cleanStr === cleanStr.split('').reverse().join('');
}
      """,
      "nextTaskId": "algo2"
    },
    {
      "id": "algo2",
      "title": "Поиск наибольшей подстроки",
      "category": "Алгоритмы",
      "difficulty": "Средний",
      "track": "Junior Backend (Django)",
      "type": "Задача с развернутым ответом",
      "xpReward": 30,
      "energyCost": 6,
      "description":
          "Напишите функцию, которая находит длину наибольшей подстроки без повторяющихся символов в заданной строке.",
      "examples": [
        {
          "input": "abcabcbb",
          "output": "3",
          "explanation":
              "Наибольшая подстрока без повторяющихся символов: 'abc', длина = 3"
        },
        {
          "input": "bbbbb",
          "output": "1",
          "explanation":
              "Наибольшая подстрока без повторяющихся символов: 'b', длина = 1"
        },
        {
          "input": "pwwkew",
          "output": "3",
          "explanation":
              "Наибольшая подстрока без повторяющихся символов: 'wke', длина = 3"
        }
      ],
      "sampleSolution": """
function lengthOfLongestSubstring(s) {
  let maxLength = 0;
  let start = 0;
  const charMap = new Map();
  
  for (let end = 0; end < s.length; end++) {
    const currentChar = s[end];
    
    if (charMap.has(currentChar) && charMap.get(currentChar) >= start) {
      start = charMap.get(currentChar) + 1;
    }
    
    charMap.set(currentChar, end);
    maxLength = Math.max(maxLength, end - start + 1);
  }
  
  return maxLength;
}
      """,
      "nextTaskId": "algo3"
    },
    {
      "id": "algo3",
      "title": "Сортировка массива",
      "category": "Алгоритмы",
      "difficulty": "Сложный",
      "track": "Junior Backend (Django)",
      "type": "Задача с развернутым ответом",
      "xpReward": 35,
      "energyCost": 7,
      "description":
          "Реализуйте алгоритм быстрой сортировки (QuickSort) для сортировки массива целых чисел.",
      "examples": [
        {
          "input": "[5, 3, 8, 4, 2]",
          "output": "[2, 3, 4, 5, 8]",
          "explanation": "Массив отсортирован по возрастанию"
        },
        {
          "input": "[1, 1, 2, 0, 0, 1]",
          "output": "[0, 0, 1, 1, 1, 2]",
          "explanation":
              "Массив с повторяющимися элементами отсортирован по возрастанию"
        }
      ],
      "sampleSolution": """
function quickSort(arr) {
  if (arr.length <= 1) {
    return arr;
  }
  
  const pivot = arr[Math.floor(arr.length / 2)];
  const left = [];
  const middle = [];
  const right = [];
  
  for (let element of arr) {
    if (element < pivot) {
      left.push(element);
    } else if (element > pivot) {
      right.push(element);
    } else {
      middle.push(element);
    }
  }
  
  return [...quickSort(left), ...middle, ...quickSort(right)];
}
      """,
      "nextTaskId": null
    }
  ];

  static final List<Map<String, dynamic>> progressIndicatorList = [
    {
      "cardTitle": "TypeScript",
      "rating": "3/5",
      "progress": "60.00",
      "progressBar": "2"
    },
    {
      "cardTitle": "JavaScript Основы",
      "rating": "4/5",
      "progress": "80.00",
      "progressBar": "3"
    },
    {
      "cardTitle": "React",
      "rating": "2/5",
      "progress": "40.00",
      "progressBar": "1"
    },
    {
      "cardTitle": "SQL",
      "rating": "3/5",
      "progress": "60.00",
      "progressBar": "2"
    },
    {
      "cardTitle": "Паттерны проектирования",
      "rating": "1/5",
      "progress": "20.00",
      "progressBar": "1"
    },
  ];

  // Достижения пользователя
  static final List<Map<String, dynamic>> achievements = [
    {
      "title": "Алгоритмический старт",
      "description": "Решите 5 алгоритмических задач",
      "progress": 3,
      "total": 5,
      "icon": "assets/icons/algorithm.png"
    },
    {
      "title": "JavaScript мастер",
      "description": "Пройдите все тесты по JavaScript",
      "progress": 8,
      "total": 10,
      "icon": "assets/icons/javascript.png"
    },
    {
      "title": "SQL гуру",
      "description": "Ответьте правильно на 20 вопросов по SQL",
      "progress": 12,
      "total": 20,
      "icon": "assets/icons/database.png"
    }
  ];

  // Ежедневные челленджи
  static final List<Map<String, dynamic>> dailyChallenges = [
    {
      "title": "Решите 3 задачи",
      "reward": "50 XP",
      "progress": 1,
      "total": 3,
      "icon": "assets/icons/challenge.png"
    },
    {
      "title": "Пройдите тест по React",
      "reward": "30 XP + 2 энергии",
      "progress": 0,
      "total": 1,
      "icon": "assets/icons/react.png"
    }
  ];

  static final List<Map<String, dynamic>> notificationMentions = [
    {
      "mentionedBy": "Benjamin Poole",
      "mentionedIn": "Unity Gaming",
      "read": false,
      "date": "Nov 2nd",
      "profileImage": "assets/placeholder.png",
      "hashTagPresent": true,
      "userOnline": false,
      "color": "BBF1C3",
      "hashElement": "@tranmautritam",
      "message":
          " when you have time please take a look at the new designs I just made in Figma. 👋"
    },
    {
      "mentionedBy": "Katharine Walls",
      "mentionedIn": "Unity Gaming",
      "read": true,
      "date": "Nov 2nd",
      "profileImage": "assets/placeholder.png",
      "hashTagPresent": false,
      "color": "DBCFFE",
      "userOnline": true,
      "hashElement": "",
      "message":
          "Please make the presentation as soon as possible Tam. We're still waiting for it. 🏀"
    },
    {
      "mentionedBy": "Bertha Ramos",
      "mentionedIn": "UI8 Products",
      "read": true,
      "date": "Nov 2nd",
      "profileImage": "assets/placeholder.png",
      "hashTagPresent": false,
      "userOnline": true,
      "color": "FFC5D5",
      "hashElement": "",
      "message":
          "Are you actually working? I don't see any new stuffs from you. Please Be creative!!!"
    },
    {
      "mentionedBy": "Marie Bowen",
      "mentionedIn": "Productivity",
      "date": "Nov 2nd",
      "read": true,
      "profileImage": "assets/placeholder.png",
      "hashTagPresent": false,
      "color": "FAA3FF",
      "userOnline": false,
      "hashElement": "",
      "message": "Are you actually working? We're still waiting for it. 🏀"
    },
    {
      "mentionedBy": "Katharine Walls",
      "mentionedIn": "Unity Gaming",
      "read": true,
      "date": "Nov 2nd",
      "profileImage": "assets/placeholder.png",
      "hashTagPresent": false,
      "color": "DBCFFE",
      "userOnline": true,
      "hashElement": "",
      "message":
          "Please make the presentation as soon as possible Tam. We're still waiting for it. 🏀"
    },
    {
      "mentionedBy": "Bertha Ramos",
      "mentionedIn": "UI8 Products",
      "read": true,
      "date": "Nov 2nd",
      "profileImage": "assets/placeholder.png",
      "hashTagPresent": false,
      "userOnline": true,
      "color": "FFC5D5",
      "hashElement": "",
      "message":
          "Are you actually working? I don't see any new stuffs from you. Please Be creative!!!"
    },
    {
      "mentionedBy": "Marie Bowen",
      "mentionedIn": "Productivity",
      "date": "Nov 2nd",
      "read": true,
      "profileImage": "assets/placeholder.png",
      "hashTagPresent": false,
      "color": "FAA3FF",
      "userOnline": false,
      "hashElement": "",
      "message": "Are you actually working? We're still waiting for it. 🏀"
    },
  ];

  static final List<String> profileImages = [
    "assets/placeholder.png",
    "assets/placeholder.png",
    "assets/placeholder.png",
    "assets/placeholder.png"
  ];

  static final List<Color> groupBackgroundColors = [
    HexColor.fromHex("BCF2C7"),
    HexColor.fromHex("8D96FF"),
    HexColor.fromHex("A5F69C"),
    HexColor.fromHex("FCA3FF")
  ];

  static final List<Map<String, dynamic>> onlineUsers = [
    {
      "name": "Gareth Reid 🔥",
      "profileImage": "assets/placeholder.png",
      "color": "BAF0C5",
    },
    {
      "name": "Vincent Lyons 🇺🇸",
      "profileImage": "assets/placeholder.png",
      "color": "DACFFE",
    },
    {
      "name": "Adeline Nunez 🎉",
      "profileImage": "assets/placeholder.png",
      "color": "FFC7D5",
    },
    {
      "name": "Samuel Doyle 🔥",
      "profileImage": "assets/placeholder.png",
      "color": "C0E7FD",
    },
    {
      "name": "Ruth Benson 🔥",
      "profileImage": "assets/placeholder.png",
      "color": "D7D2D4",
    },
    {
      "name": "Adeline Nunez 🎉",
      "profileImage": "assets/placeholder.png",
      "color": "FFC7D5",
    },
    {
      "name": "Samuel Doyle 🔥",
      "profileImage": "assets/placeholder.png",
      "color": "C0E7FD",
    },
    {
      "name": "Ruth Benson 🔥",
      "profileImage": "assets/placeholder.png",
      "color": "D7D2D4",
    },
    {
      "name": "Adeline Nunez 🎉",
      "profileImage": "assets/placeholder.png",
      "color": "FFC7D5",
    },
    {
      "name": "Samuel Doyle 🔥",
      "profileImage": "assets/placeholder.png",
      "color": "C0E7FD",
    },
    {
      "name": "Ruth Benson 🔥",
      "profileImage": "assets/placeholder.png",
      "color": "D7D2D4",
    },
    {
      "name": "Gareth Reid 🔥",
      "profileImage": "assets/placeholder.png",
      "color": "BAF0C5",
    },
    {
      "name": "Vincent Lyons 🇺🇸",
      "profileImage": "assets/placeholder.png",
      "color": "DACFFE",
    },
    {
      "name": "Adeline Nunez 🎉",
      "profileImage": "assets/placeholder.png",
      "color": "FFC7D5",
    },
  ];

  static final List<Map<String, dynamic>> employeeData = [
    {
      "employeeName": "Aaliyah Langosh",
      "employeeImage": "assets/placeholder.png",
      "color": HexColor.fromHex("FCA3FF"),
      "activated": true,
      "employeePosition": "Senior Interactions Agent"
    },
    {
      "employeeName": "Greta Streich",
      "employeeImage": "assets/placeholder.png",
      "color": HexColor.fromHex("94F1F1"),
      "activated": false,
      "employeePosition": "Dynamic Security Technician"
    },
    {
      "employeeName": "Judd Koch",
      "employeeImage": "assets/placeholder.png",
      "color": HexColor.fromHex("8D96FF"),
      "activated": true,
      "employeePosition": "Senior Interactions Agent"
    },
    {
      "employeeName": "Katherine Wells",
      "employeeImage": "assets/placeholder.png",
      "color": HexColor.fromHex("DBD0FD"),
      "activated": false,
      "employeePosition": "Dynamic Security Technician"
    },
    {
      "employeeName": "Betha Ramos",
      "employeeImage": "assets/placeholder.png",
      "color": HexColor.fromHex("FFC5D5"),
      "activated": false,
      "employeePosition": "Dynamic Security Technician"
    },
    {
      "employeeName": "Greta Streich",
      "employeeImage": "assets/placeholder.png",
      "color": HexColor.fromHex("94F1F1"),
      "activated": false,
      "employeePosition": "Dynamic Security Technician"
    },
    {
      "employeeName": "Aaliyah Langosh",
      "employeeImage": "assets/placeholder.png",
      "color": HexColor.fromHex("FCA3FF"),
      "activated": true,
      "employeePosition": "Senior Interactions Agent"
    },
  ];

  static final List<Map<String, dynamic>> productData = [
    {
      "projectName": "Unity Dashboard",
      "category": "Design",
      "color": "A06AFA",
      "ratingsUpperNumber": 15,
      "ratingsLowerNumber": 20
    },
    {
      "projectName": "Instagram   Shots🇺🇸",
      "category": "Marketing",
      "color": "8D96FF",
      "ratingsUpperNumber": 8,
      "ratingsLowerNumber": 20
    },
    {
      "projectName": "Cubbies",
      "category": "Design",
      "color": "FF968E",
      "ratingsUpperNumber": 15,
      "ratingsLowerNumber": 20
    },
    {
      "projectName": "OpenMind 🚀",
      "category": "Development",
      "color": "FFDE72",
      "ratingsUpperNumber": 19,
      "ratingsLowerNumber": 20
    },
    {
      "projectName": "UI8 Platform",
      "category": "Design",
      "color": "A06AFA",
      "ratingsUpperNumber": 10,
      "ratingsLowerNumber": 20
    },
    {
      "projectName": "3D Characters Inc.",
      "category": "Development",
      "color": "A6F69C",
      "ratingsUpperNumber": 18,
      "ratingsLowerNumber": 20
    },
  ];
}
