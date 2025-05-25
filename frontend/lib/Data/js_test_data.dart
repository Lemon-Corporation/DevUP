class JSTestData {
  // Расширенная база вопросов для переменных и типов данных
  static final List<Map<String, dynamic>> _variablesQuestionsPool = [
    // Оригинальные вопросы
    {
      "question": "Что выведет console.log(typeof null)?",
      "options": ["null", "undefined", "object", "number"],
      "correctAnswer": 2,
      "explanation": "В JavaScript typeof null возвращает 'object' — это известная особенность (баг) языка, который сохранился по историческим причинам.",
      "wrongExplanation": "Хотя логично было бы ожидать 'null', JavaScript возвращает 'object' из-за особенностей реализации."
    },
    {
      "question": "Какое значение будет у переменной x после выполнения кода?\nlet x;\nconsole.log(x);",
      "options": ["null", "undefined", "0", "''"],
      "correctAnswer": 1,
      "explanation": "Переменные, объявленные с let или const, но не инициализированные, имеют значение undefined.",
      "wrongExplanation": "В JavaScript неинициализированные переменные автоматически получают значение undefined, а не null или другие значения."
    },
    {
      "question": "Что выведет console.log('5' + 3)?",
      "options": ["8", "'53'", "53", "NaN"],
      "correctAnswer": 1,
      "explanation": "При использовании оператора + с строкой JavaScript выполняет конкатенацию, преобразуя число в строку.",
      "wrongExplanation": "JavaScript не выполняет математическое сложение, когда один из операндов — строка. Происходит конкатенация строк."
    },
    {
      "question": "Какой из способов объявления переменной НЕ рекомендуется в современном JavaScript?",
      "options": ["let", "const", "var", "function"],
      "correctAnswer": 2,
      "explanation": "var имеет функциональную область видимости и поднятие (hoisting), что может привести к неожиданному поведению. Рекомендуется использовать let и const.",
      "wrongExplanation": "let и const имеют блочную область видимости и более предсказуемое поведение, поэтому они предпочтительнее var."
    },
    {
      "question": "Что выведет console.log(typeof [])?",
      "options": ["array", "object", "list", "undefined"],
      "correctAnswer": 1,
      "explanation": "В JavaScript массивы являются объектами, поэтому typeof возвращает 'object'. Для проверки массива используйте Array.isArray().",
      "wrongExplanation": "Хотя массивы выглядят как отдельный тип, в JavaScript они являются разновидностью объектов."
    },
    {
      "question": "Какое значение имеет переменная после выполнения?\nconst arr = [1, 2, 3];\narr.push(4);\nconsole.log(arr);",
      "options": ["[1, 2, 3]", "[1, 2, 3, 4]", "Ошибка", "undefined"],
      "correctAnswer": 1,
      "explanation": "const предотвращает переназначение переменной, но не делает объект неизменяемым. Методы массива могут изменять его содержимое.",
      "wrongExplanation": "const защищает от переназначения переменной (arr = ...), но не от изменения содержимого объекта или массива."
    },
    {
      "question": "Что выведет console.log(0.1 + 0.2 === 0.3)?",
      "options": ["true", "false", "undefined", "NaN"],
      "correctAnswer": 1,
      "explanation": "Из-за особенностей представления чисел с плавающей точкой в JavaScript 0.1 + 0.2 = 0.30000000000000004, что не равно 0.3.",
      "wrongExplanation": "JavaScript использует стандарт IEEE 754 для чисел с плавающей точкой, что может приводить к неточностям в вычислениях."
    },
    {
      "question": "Какой тип данных НЕ является примитивным в JavaScript?",
      "options": ["string", "number", "object", "boolean"],
      "correctAnswer": 2,
      "explanation": "object является сложным типом данных. Примитивные типы: string, number, boolean, null, undefined, symbol, bigint.",
      "wrongExplanation": "Примитивные типы хранят значения напрямую, а объекты хранят ссылки на данные в памяти."
    },
    // Дополнительные вопросы
    {
      "question": "Что выведет console.log(typeof undefined)?",
      "options": ["undefined", "null", "object", "string"],
      "correctAnswer": 0,
      "explanation": "typeof undefined возвращает строку 'undefined'. Это единственный случай, когда typeof возвращает то же значение, что и проверяемое.",
      "wrongExplanation": "typeof всегда возвращает строку, поэтому typeof undefined === 'undefined'."
    },
    {
      "question": "Что произойдет при выполнении?\nconst x = 5;\nx = 10;",
      "options": ["x станет 10", "Ошибка", "x останется 5", "undefined"],
      "correctAnswer": 1,
      "explanation": "Переменные, объявленные с const, нельзя переназначать. Попытка переназначения вызовет TypeError.",
      "wrongExplanation": "const создает неизменяемую привязку к значению, переназначение невозможно."
    },
    {
      "question": "Что выведет console.log('10' - 5)?",
      "options": ["'105'", "5", "NaN", "'10-5'"],
      "correctAnswer": 1,
      "explanation": "Оператор - всегда выполняет математическую операцию, поэтому строка '10' преобразуется в число 10.",
      "wrongExplanation": "В отличие от +, оператор - не может работать со строками, поэтому происходит числовое преобразование."
    },
    {
      "question": "Какое значение имеет переменная?\nlet a;\nif (true) {\n  let a = 5;\n}\nconsole.log(a);",
      "options": ["5", "undefined", "Ошибка", "null"],
      "correctAnswer": 1,
      "explanation": "let имеет блочную область видимости. Переменная a внутри блока if - это другая переменная, не влияющая на внешнюю a.",
      "wrongExplanation": "Блочная область видимости означает, что переменные let/const существуют только в пределах своего блока {}."
    },
    {
      "question": "Что выведет console.log(Number('123abc'))?",
      "options": ["123", "NaN", "Ошибка", "'123abc'"],
      "correctAnswer": 1,
      "explanation": "Number() пытается преобразовать всю строку в число. Если строка содержит нечисловые символы, возвращается NaN.",
      "wrongExplanation": "Number() требует, чтобы вся строка была валидным числом, иначе возвращает NaN."
    },
    {
      "question": "Что выведет console.log(Boolean(''))?",
      "options": ["true", "false", "''", "undefined"],
      "correctAnswer": 1,
      "explanation": "Пустая строка '' является falsy значением в JavaScript, поэтому Boolean('') возвращает false.",
      "wrongExplanation": "Falsy значения в JS: false, 0, '', null, undefined, NaN. Все остальное truthy."
    },
    {
      "question": "Что выведет console.log(typeof NaN)?",
      "options": ["NaN", "undefined", "number", "object"],
      "correctAnswer": 2,
      "explanation": "NaN (Not a Number) парадоксально имеет тип 'number' в JavaScript.",
      "wrongExplanation": "Несмотря на название 'Not a Number', NaN технически является специальным числовым значением."
    }
  ];

  // Расширенная база вопросов для операторов
  static final List<Map<String, dynamic>> _operatorsQuestionsPool = [
    // Оригинальные вопросы
    {
      "question": "Что выведет console.log(5 == '5')?",
      "options": ["true", "false", "undefined", "NaN"],
      "correctAnswer": 0,
      "explanation": "Оператор == выполняет приведение типов. Строка '5' преобразуется в число 5, поэтому результат true.",
      "wrongExplanation": "Оператор == (нестрогое равенство) автоматически приводит типы, в отличие от === (строгое равенство)."
    },
    {
      "question": "Что выведет console.log(5 === '5')?",
      "options": ["true", "false", "undefined", "NaN"],
      "correctAnswer": 1,
      "explanation": "Оператор === проверяет строгое равенство без приведения типов. 5 (число) не равно '5' (строка).",
      "wrongExplanation": "Строгое равенство (===) не выполняет приведение типов, поэтому число и строка никогда не будут равны."
    },
    {
      "question": "Что выведет console.log(10 % 3)?",
      "options": ["3", "1", "0", "3.33"],
      "correctAnswer": 1,
      "explanation": "Оператор % возвращает остаток от деления. 10 разделить на 3 = 3 с остатком 1.",
      "wrongExplanation": "Оператор модуло (%) возвращает именно остаток от деления, а не результат деления."
    },
    {
      "question": "Что выведет console.log(true && false || true)?",
      "options": ["true", "false", "undefined", "null"],
      "correctAnswer": 0,
      "explanation": "Сначала выполняется true && false = false, затем false || true = true. Оператор && имеет больший приоритет.",
      "wrongExplanation": "Важно помнить приоритет операторов: && выполняется раньше ||."
    },
    {
      "question": "Что выведет console.log(!!'hello')?",
      "options": ["true", "false", "hello", "undefined"],
      "correctAnswer": 0,
      "explanation": "Двойное отрицание (!!) преобразует значение в boolean. Непустая строка 'hello' является truthy, поэтому результат true.",
      "wrongExplanation": "Первый ! преобразует 'hello' в false (так как строка truthy), второй ! делает из false значение true."
    },
    {
      "question": "Что выведет console.log(0 || 'default')?",
      "options": ["0", "'default'", "true", "false"],
      "correctAnswer": 1,
      "explanation": "Оператор || возвращает первое truthy значение. 0 является falsy, поэтому возвращается 'default'.",
      "wrongExplanation": "Оператор || часто используется для установки значений по умолчанию, возвращая первое truthy значение."
    },
    {
      "question": "Что выведет console.log(2 ** 3)?",
      "options": ["6", "8", "9", "23"],
      "correctAnswer": 1,
      "explanation": "Оператор ** выполняет возведение в степень. 2 в степени 3 равно 8 (2 * 2 * 2).",
      "wrongExplanation": "Оператор ** — это современный способ возведения в степень в JavaScript, эквивалентный Math.pow(2, 3)."
    },
    {
      "question": "Что произойдет с переменной x после выполнения x += 5, если x = 10?",
      "options": ["x = 10", "x = 15", "x = 5", "Ошибка"],
      "correctAnswer": 1,
      "explanation": "Оператор += прибавляет значение к переменной и присваивает результат. x = x + 5 = 10 + 5 = 15.",
      "wrongExplanation": "Составные операторы присваивания (+=, -=, *=, /=) выполняют операцию и присваивают результат той же переменной."
    },
    // Дополнительные вопросы
    {
      "question": "Что выведет console.log(null ?? 'default')?",
      "options": ["null", "'default'", "undefined", "false"],
      "correctAnswer": 1,
      "explanation": "Оператор ?? (nullish coalescing) возвращает правый операнд, если левый null или undefined.",
      "wrongExplanation": "?? работает только с null и undefined, в отличие от || который работает со всеми falsy значениями."
    },
    {
      "question": "Что выведет console.log(0 ?? 'default')?",
      "options": ["0", "'default'", "false", "null"],
      "correctAnswer": 0,
      "explanation": "Оператор ?? возвращает левый операнд, если он не null и не undefined. 0 не является nullish значением.",
      "wrongExplanation": "?? проверяет только null и undefined, 0 является валидным значением."
    },
    {
      "question": "Что выведет console.log(false && 'never')?",
      "options": ["false", "'never'", "true", "undefined"],
      "correctAnswer": 0,
      "explanation": "Оператор && возвращает первое falsy значение или последнее truthy. false - falsy, поэтому возвращается false.",
      "wrongExplanation": "Логическое И (&&) использует короткое замыкание - если первый операнд falsy, второй не вычисляется."
    },
    {
      "question": "Что выведет console.log('5' * 2)?",
      "options": ["'52'", "10", "NaN", "'5*2'"],
      "correctAnswer": 1,
      "explanation": "Оператор * всегда выполняет математическую операцию, поэтому '5' преобразуется в число 5.",
      "wrongExplanation": "Операторы *, /, -, % всегда приводят операнды к числам, в отличие от +."
    },
    {
      "question": "Что выведет console.log(++x) если x = 5?",
      "options": ["5", "6", "undefined", "Ошибка"],
      "correctAnswer": 1,
      "explanation": "Префиксный инкремент ++x сначала увеличивает значение, затем возвращает его. x становится 6 и возвращается 6.",
      "wrongExplanation": "Префиксный инкремент изменяет значение ДО использования, постфиксный - ПОСЛЕ."
    },
    {
      "question": "Что выведет console.log(x++) если x = 5?",
      "options": ["5", "6", "undefined", "Ошибка"],
      "correctAnswer": 0,
      "explanation": "Постфиксный инкремент x++ сначала возвращает текущее значение, затем увеличивает его. Возвращается 5, x становится 6.",
      "wrongExplanation": "Постфиксный инкремент возвращает старое значение, а изменение происходит после."
    },
    {
      "question": "Что выведет console.log(true || false && false)?",
      "options": ["true", "false", "undefined", "null"],
      "correctAnswer": 0,
      "explanation": "Оператор && имеет больший приоритет чем ||. Сначала false && false = false, затем true || false = true.",
      "wrongExplanation": "Приоритет операторов: сначала &&, потом ||. Используйте скобки для ясности."
    }
  ];

  // Метод для получения случайных вопросов из пула
  static List<Map<String, dynamic>> _getRandomQuestions(List<Map<String, dynamic>> pool, int count) {
    final shuffled = List<Map<String, dynamic>>.from(pool)..shuffle();
    return shuffled.take(count).toList();
  }

  // Тест: Переменные и типы данных
  static Map<String, dynamic> get variablesTypesTest {
    return {
      "id": "js_variables_test",
      "title": "Переменные и типы данных",
      "category": "JavaScript",
      "difficulty": "Легкий",
      "track": "Junior Frontend (React)",
      "type": "Тест",
      "xpReward": 15,
      "energyCost": 3,
      "description": "Проверьте свои знания переменных и типов данных в JavaScript",
      "questions": _getRandomQuestions(_variablesQuestionsPool, 8),
    };
  }

  // Тест: Операторы и выражения
  static Map<String, dynamic> get operatorsTest {
    return {
      "id": "js_operators_test",
      "title": "Операторы и выражения",
      "category": "JavaScript",
      "difficulty": "Средний",
      "track": "Junior Frontend (React)",
      "type": "Тест",
      "xpReward": 20,
      "energyCost": 4,
      "description": "Проверьте знания операторов JavaScript и их поведения",
      "questions": _getRandomQuestions(_operatorsQuestionsPool, 8),
    };
  }

  // Расширенная база для анализа кода переменных
  static final List<Map<String, dynamic>> _variablesCodePool = [
    {
      "codeSnippet": """function example() {
  console.log(a); // Что выведет?
  console.log(b); // Что выведет?
  console.log(c); // Что выведет?
  
  var a = 1;
  let b = 2;
  const c = 3;
  
  console.log(a); // Что выведет?
  console.log(b); // Что выведет?
  console.log(c); // Что выведет?
}

example();""",
      "questions": [
        {
          "question": "Что выведет первый console.log(a)?",
          "options": ["1", "undefined", "ReferenceError", "null"],
          "correctAnswer": 1,
          "explanation": "Переменные var поднимаются (hoisting), но инициализируются как undefined до присваивания значения.",
          "wrongExplanation": "var объявления поднимаются в начало функции, но значение присваивается только в месте объявления."
        },
        {
          "question": "Что выведет первый console.log(b)?",
          "options": ["2", "undefined", "ReferenceError", "null"],
          "correctAnswer": 2,
          "explanation": "Переменные let находятся в 'temporal dead zone' до их объявления, поэтому возникает ReferenceError.",
          "wrongExplanation": "let и const поднимаются, но недоступны до объявления из-за temporal dead zone."
        },
        {
          "question": "Что выведет первый console.log(c)?",
          "options": ["3", "undefined", "ReferenceError", "null"],
          "correctAnswer": 2,
          "explanation": "Как и let, const находится в temporal dead zone до объявления, вызывая ReferenceError.",
          "wrongExplanation": "const ведет себя так же, как let в отношении temporal dead zone."
        }
      ]
    },
    {
      "codeSnippet": """for (var i = 0; i < 3; i++) {
  setTimeout(() => {
    console.log('var:', i);
  }, 100);
}

for (let j = 0; j < 3; j++) {
  setTimeout(() => {
    console.log('let:', j);
  }, 100);
}""",
      "questions": [
        {
          "question": "Что выведет console.log('var:', i)?",
          "options": ["0, 1, 2", "3, 3, 3", "undefined", "ReferenceError"],
          "correctAnswer": 1,
          "explanation": "var имеет функциональную область видимости. К моменту выполнения setTimeout, цикл завершен и i = 3.",
          "wrongExplanation": "var создает одну переменную для всего цикла, которая изменяется на каждой итерации."
        },
        {
          "question": "Что выведет console.log('let:', j)?",
          "options": ["0, 1, 2", "3, 3, 3", "undefined", "ReferenceError"],
          "correctAnswer": 0,
          "explanation": "let имеет блочную область видимости. Каждая итерация создает новую переменную j.",
          "wrongExplanation": "let создает новую переменную для каждой итерации цикла."
        },
        {
          "question": "Как исправить проблему с var?",
          "options": ["Использовать let", "Использовать IIFE", "Использовать bind", "Все варианты"],
          "correctAnswer": 3,
          "explanation": "Все перечисленные способы решают проблему замыкания: let создает блочную область видимости, IIFE создает новую функцию, bind привязывает значение.",
          "wrongExplanation": "Существует несколько способов решения проблемы замыкания в циклах."
        }
      ]
    }
  ];

  // Расширенная база для анализа кода операторов
  static final List<Map<String, dynamic>> _operatorsCodePool = [
    {
      "codeSnippet": """let a = 5;
let b = '5';
let c = 0;
let d = '';
let e = null;
let f = undefined;

console.log(a == b);     // Результат 1
console.log(a === b);    // Результат 2
console.log(c || d || 'default'); // Результат 3
console.log(e ?? f ?? 'fallback'); // Результат 4
console.log(++a * 2);    // Результат 5""",
      "questions": [
        {
          "question": "Что выведет console.log(a == b)?",
          "options": ["true", "false", "undefined", "NaN"],
          "correctAnswer": 0,
          "explanation": "Оператор == приводит типы. Строка '5' преобразуется в число 5, поэтому 5 == 5 возвращает true.",
          "wrongExplanation": "Нестрогое равенство (==) выполняет приведение типов, в отличие от строгого равенства (===)."
        },
        {
          "question": "Что выведет console.log(a === b)?",
          "options": ["true", "false", "undefined", "NaN"],
          "correctAnswer": 1,
          "explanation": "Строгое равенство (===) не приводит типы. Число 5 не равно строке '5'.",
          "wrongExplanation": "Оператор === проверяет равенство значения И типа, без приведения типов."
        },
        {
          "question": "Что выведет console.log(c || d || 'default')?",
          "options": ["0", "''", "'default'", "false"],
          "correctAnswer": 2,
          "explanation": "Оператор || возвращает первое truthy значение. 0 и '' являются falsy, поэтому возвращается 'default'.",
          "wrongExplanation": "Оператор || проверяет значения слева направо и возвращает первое truthy значение."
        },
        {
          "question": "Что выведет console.log(e ?? f ?? 'fallback')?",
          "options": ["null", "undefined", "'fallback'", "false"],
          "correctAnswer": 2,
          "explanation": "Оператор ?? (nullish coalescing) возвращает правый операнд, если левый null или undefined. Оба e и f являются nullish.",
          "wrongExplanation": "Оператор ?? работает только с null и undefined, в отличие от || который работает со всеми falsy значениями."
        },
        {
          "question": "Что выведет console.log(++a * 2)? (изначально a = 5)",
          "options": ["10", "12", "11", "6"],
          "correctAnswer": 1,
          "explanation": "Префиксный инкремент ++a сначала увеличивает a до 6, затем умножает на 2, получается 12.",
          "wrongExplanation": "Префиксный инкремент (++a) увеличивает значение ДО использования в выражении, в отличие от постфиксного (a++)."
        }
      ]
    },
    {
      "codeSnippet": """let x = 10;
let y = '20';
let z = null;
let w = undefined;

console.log(x + y);      // Результат 1
console.log(x - y);      // Результат 2
console.log(z || w || 42); // Результат 3
console.log(z ?? w ?? 42); // Результат 4
console.log(!z && !w);   // Результат 5""",
      "questions": [
        {
          "question": "Что выведет console.log(x + y)?",
          "options": ["30", "'1020'", "NaN", "Ошибка"],
          "correctAnswer": 1,
          "explanation": "Оператор + с строкой выполняет конкатенацию. 10 преобразуется в '10', результат '1020'.",
          "wrongExplanation": "Когда один из операндов + является строкой, происходит конкатенация, а не сложение."
        },
        {
          "question": "Что выведет console.log(x - y)?",
          "options": ["'-10'", "-10", "NaN", "'10-20'"],
          "correctAnswer": 1,
          "explanation": "Оператор - всегда выполняет математическую операцию. '20' преобразуется в 20, результат 10 - 20 = -10.",
          "wrongExplanation": "Операторы -, *, /, % всегда приводят операнды к числам."
        },
        {
          "question": "Что выведет console.log(z || w || 42)?",
          "options": ["null", "undefined", "42", "false"],
          "correctAnswer": 2,
          "explanation": "Оператор || возвращает первое truthy значение. null и undefined falsy, поэтому возвращается 42.",
          "wrongExplanation": "|| проверяет все falsy значения: false, 0, '', null, undefined, NaN."
        },
        {
          "question": "Что выведет console.log(z ?? w ?? 42)?",
          "options": ["null", "undefined", "42", "false"],
          "correctAnswer": 2,
          "explanation": "Оператор ?? возвращает правый операнд только если левый null или undefined. Оба z и w nullish.",
          "wrongExplanation": "?? работает только с null и undefined, игнорируя другие falsy значения."
        },
        {
          "question": "Что выведет console.log(!z && !w)?",
          "options": ["true", "false", "null", "undefined"],
          "correctAnswer": 0,
          "explanation": "!null = true, !undefined = true, поэтому true && true = true.",
          "wrongExplanation": "Оператор ! преобразует null и undefined в true, так как они falsy."
        }
      ]
    }
  ];

  // Динамический анализ кода: Переменные
  static Map<String, dynamic> get variablesCodeAnalysis {
    final randomCode = (_variablesCodePool..shuffle()).first;
    return {
      "id": "js_variables_code",
      "title": "Анализ кода: Переменные",
      "category": "JavaScript",
      "difficulty": "Средний",
      "track": "Junior Frontend (React)",
      "type": "Анализ кода",
      "xpReward": 25,
      "energyCost": 5,
      "description": "Проанализируйте поведение переменных в различных контекстах",
      "codeSnippet": randomCode["codeSnippet"],
      "questions": randomCode["questions"],
    };
  }

  // Динамический анализ кода: Операторы
  static Map<String, dynamic> get operatorsCodeAnalysis {
    final randomCode = (_operatorsCodePool..shuffle()).first;
    return {
      "id": "js_operators_code",
      "title": "Анализ кода: Операторы",
      "category": "JavaScript",
      "difficulty": "Средний",
      "track": "Junior Frontend (React)",
      "type": "Анализ кода",
      "xpReward": 25,
      "energyCost": 5,
      "description": "Проанализируйте сложные выражения с операторами",
      "codeSnippet": randomCode["codeSnippet"],
      "questions": randomCode["questions"],
    };
  }

  // ========== МОДУЛЬ 2: ФУНКЦИИ И ОБЛАСТЬ ВИДИМОСТИ ==========
  
  // Расширенная база вопросов для функций
  static final List<Map<String, dynamic>> _functionsQuestionsPool = [
    // ========== ЛЕГКИЕ ВОПРОСЫ (базовые концепции) ==========
    {
      "question": "Как правильно объявить функцию в JavaScript?",
      "options": ["function myFunc() {}", "def myFunc():", "func myFunc() {}", "function: myFunc() {}"],
      "correctAnswer": 0,
      "explanation": "В JavaScript функции объявляются с помощью ключевого слова 'function', за которым следует имя функции и круглые скобки.",
      "wrongExplanation": "Синтаксис 'function имя() {}' - это стандартный способ объявления функций в JavaScript."
    },
    {
      "question": "Что нужно написать, чтобы вызвать функцию с именем 'sayHello'?",
      "options": ["sayHello()", "call sayHello", "sayHello", "run sayHello()"],
      "correctAnswer": 0,
      "explanation": "Для вызова функции нужно написать её имя, за которым следуют круглые скобки ().",
      "wrongExplanation": "Круглые скобки () обязательны для вызова функции, даже если она не принимает параметры."
    },
    {
      "question": "Как передать значение 5 в функцию greet?",
      "options": ["greet(5)", "greet[5]", "greet{5}", "greet = 5"],
      "correctAnswer": 0,
      "explanation": "Аргументы передаются в функцию внутри круглых скобок при её вызове.",
      "wrongExplanation": "Для передачи аргументов используются круглые скобки, а не квадратные или фигурные."
    },
    {
      "question": "Что делает ключевое слово 'return' в функции?",
      "options": ["Возвращает значение из функции", "Останавливает программу", "Создает новую функцию", "Удаляет функцию"],
      "correctAnswer": 0,
      "explanation": "return возвращает значение из функции и завершает её выполнение.",
      "wrongExplanation": "return - это способ вернуть результат работы функции и передать его в место вызова."
    },
    {
      "question": "Что выведет console.log(add(2, 3)) для функции function add(a, b) { return a + b; }?",
      "options": ["5", "23", "undefined", "error"],
      "correctAnswer": 0,
      "explanation": "Функция складывает два числа: 2 + 3 = 5.",
      "wrongExplanation": "Оператор + с числами выполняет математическое сложение, а не конкатенацию строк."
    },
    {
      "question": "Как создать стрелочную функцию, которая возвращает сумму двух чисел?",
      "options": ["(a, b) => a + b", "a, b -> a + b", "function(a, b) => a + b", "=> (a, b) a + b"],
      "correctAnswer": 0,
      "explanation": "Стрелочные функции используют синтаксис (параметры) => выражение.",
      "wrongExplanation": "Стрелочные функции - это краткий способ записи функций с помощью символа =>"
    },
    
    // ========== СРЕДНИЕ ВОПРОСЫ ==========
    {
      "question": "Что выведет console.log(typeof function() {})?",
      "options": ["function", "object", "undefined", "string"],
      "correctAnswer": 0,
      "explanation": "В JavaScript функции имеют тип 'function'. Это единственный callable тип в языке.",
      "wrongExplanation": "Функции в JavaScript - это специальный тип данных 'function', не объекты в контексте typeof."
    },
    {
      "question": "Что произойдет при вызове функции до ее объявления?\nconst result = myFunc();\nfunction myFunc() { return 'Hello'; }",
      "options": ["'Hello'", "undefined", "ReferenceError", "TypeError"],
      "correctAnswer": 0,
      "explanation": "Function declarations поднимаются (hoisting) полностью, включая их реализацию, поэтому функцию можно вызвать до объявления.",
      "wrongExplanation": "В отличие от var, function declarations поднимаются целиком, а не только объявление."
    },
    {
      "question": "Что выведет console.log(func.length) для function func(a, b, c = 5) {}?",
      "options": ["2", "3", "0", "undefined"],
      "correctAnswer": 0,
      "explanation": "Свойство length функции возвращает количество параметров ДО первого параметра с значением по умолчанию.",
      "wrongExplanation": "Параметры со значениями по умолчанию не учитываются в func.length."
    },
    
    // ========== СЛОЖНЫЕ ВОПРОСЫ ==========
    {
      "question": "Что выведет этот код?\nconst func = function() { return 'A'; };\nfunction func() { return 'B'; }\nconsole.log(func());",
      "options": ["'A'", "'B'", "TypeError", "ReferenceError"],
      "correctAnswer": 0,
      "explanation": "Function declaration поднимается первым, затем переменная func переназначается на function expression, поэтому результат 'A'.",
      "wrongExplanation": "Hoisting работает так: сначала поднимаются function declarations, затем выполняются присваивания переменных."
    },
    {
      "question": "Что выведет console.log(add(2, 3)) для arrow function?\nconst add = (a, b) => a + b;",
      "options": ["5", "undefined", "TypeError", "ReferenceError"],
      "correctAnswer": 2,
      "explanation": "Arrow functions не поднимаются (hoisting). Попытка вызова до объявления вызовет TypeError: add is not a function.",
      "wrongExplanation": "Arrow functions ведут себя как переменные - поднимается только объявление, но не значение."
    },
    {
      "question": "Сколько параметров принимает эта функция?\nfunction test(a, b, ...rest) { return arguments.length; }",
      "options": ["2", "3", "Зависит от вызова", "undefined"],
      "correctAnswer": 2,
      "explanation": "Функция может принять любое количество аргументов. arguments.length покажет реальное количество переданных аргументов.",
      "wrongExplanation": "Rest параметр (...rest) позволяет функции принимать неограниченное количество аргументов."
    },
    {
      "question": "Что выведет этот код?\nfunction outer() {\n  var x = 1;\n  return function inner() {\n    return x++;\n  };\n}\nconst fn = outer();\nconsole.log(fn() + fn());",
      "options": ["2", "3", "4", "NaN"],
      "correctAnswer": 1,
      "explanation": "Первый вызов fn() возвращает 1 и увеличивает x до 2. Второй вызов возвращает 2. Сумма: 1 + 2 = 3.",
      "wrongExplanation": "Замыкание сохраняет ссылку на переменную x, поэтому изменения сохраняются между вызовами."
    },
    {
      "question": "Что выведет console.log(this) в arrow function в строгом режиме?",
      "options": ["window", "undefined", "Лексический this", "null"],
      "correctAnswer": 2,
      "explanation": "Arrow functions не имеют собственного this, они наследуют this из окружающего лексического контекста.",
      "wrongExplanation": "Arrow functions всегда используют лексический this, независимо от способа вызова."
    },
    {
      "question": "Что выведет этот код?\nconst obj = {\n  name: 'Test',\n  getName: () => this.name\n};\nconsole.log(obj.getName());",
      "options": ["'Test'", "undefined", "null", "ReferenceError"],
      "correctAnswer": 1,
      "explanation": "Arrow function наследует this из глобального контекста, где this.name undefined, а не из объекта obj.",
      "wrongExplanation": "Arrow functions не привязываются к объекту при вызове как методы, они сохраняют лексический this."
    },
    {
      "question": "Что выведет console.log(sum(1)(2)(3)) для функции каррирования?",
      "options": ["6", "function", "undefined", "NaN"],
      "correctAnswer": 0,
      "explanation": "Каррированная функция возвращает новую функцию для каждого аргумента, пока не получит все необходимые параметры.",
      "wrongExplanation": "Каррирование позволяет вызывать функцию частично, передавая аргументы по одному."
    },
    {
      "question": "Что выведет этот код?\nfunction test() {\n  console.log(arguments instanceof Array);\n}\ntest(1, 2, 3);",
      "options": ["true", "false", "undefined", "TypeError"],
      "correctAnswer": 1,
      "explanation": "arguments - это array-like объект, но не настоящий массив. Он не наследуется от Array.prototype.",
      "wrongExplanation": "arguments имеет length и индексы, но не является экземпляром Array и не имеет методов массива."
    },
    {
      "question": "Что выведет console.log(func.call(null, 1, 2)) в строгом режиме?",
      "options": ["this = null", "this = window", "this = undefined", "TypeError"],
      "correctAnswer": 0,
      "explanation": "В строгом режиме call() с null или undefined не заменяет this на глобальный объект.",
      "wrongExplanation": "Строгий режим предотвращает автоматическую замену null/undefined на глобальный объект."
    },
    {
      "question": "Что выведет этот код?\nconst arr = [1, 2, 3];\nconst fn = arr.map;\nfn(x => x * 2);",
      "options": ["[2, 4, 6]", "TypeError", "undefined", "[1, 2, 3]"],
      "correctAnswer": 1,
      "explanation": "Метод map потерял контекст (this) при присваивании переменной. Нужно использовать bind() или call().",
      "wrongExplanation": "Методы объектов теряют свой контекст при извлечении в отдельные переменные."
    },
    {
      "question": "Что выведет console.log(fn.bind(obj)(1, 2)) если fn возвращает this.value + a + b?",
      "options": ["Зависит от obj.value", "undefined", "NaN", "TypeError"],
      "correctAnswer": 0,
      "explanation": "bind() создает новую функцию с привязанным контекстом. Результат зависит от значения obj.value.",
      "wrongExplanation": "bind() жестко привязывает this к указанному объекту, независимо от способа вызова."
    },
    {
      "question": "Что выведет этот код?\nfunction* generator() {\n  yield 1;\n  yield 2;\n  return 3;\n}\nconst gen = generator();\nconsole.log(gen.next().value);",
      "options": ["1", "2", "3", "undefined"],
      "correctAnswer": 0,
      "explanation": "Первый вызов next() возвращает первое yield значение. Generator функции выполняются пошагово.",
      "wrongExplanation": "Generator функции приостанавливаются на каждом yield и возобновляются при вызове next()."
    }
  ];

  // Расширенная база вопросов для замыканий и области видимости
  static final List<Map<String, dynamic>> _closuresQuestionsPool = [
    // ========== ЛЕГКИЕ ВОПРОСЫ (базовые концепции) ==========
    {
      "question": "Что такое область видимости (scope) в JavaScript?",
      "options": ["Место, где переменная доступна", "Тип переменной", "Способ объявления функции", "Метод объекта"],
      "correctAnswer": 0,
      "explanation": "Область видимости определяет, где в коде переменная может быть использована.",
      "wrongExplanation": "Scope - это контекст, в котором переменные и функции доступны для использования."
    },
    {
      "question": "Какая переменная имеет глобальную область видимости?",
      "options": ["var x = 5; (вне функций)", "let x = 5; (внутри функции)", "const x = 5; (внутри блока)", "function x() {} (внутри функции)"],
      "correctAnswer": 0,
      "explanation": "Переменные, объявленные вне всех функций и блоков, имеют глобальную область видимости.",
      "wrongExplanation": "Глобальные переменные доступны из любого места в программе."
    },
    {
      "question": "В чем разница между var и let в области видимости?",
      "options": ["var - функциональная, let - блочная", "var - блочная, let - функциональная", "Никакой разницы", "var быстрее let"],
      "correctAnswer": 0,
      "explanation": "var имеет функциональную область видимости, а let и const - блочную.",
      "wrongExplanation": "Это ключевое различие между старым (var) и новым (let/const) способами объявления переменных."
    },
    {
      "question": "Что выведет этот код?\nfunction test() {\n  var x = 1;\n  console.log(x);\n}\ntest();",
      "options": ["1", "undefined", "ReferenceError", "null"],
      "correctAnswer": 0,
      "explanation": "Переменная x объявлена внутри функции и доступна в её области видимости.",
      "wrongExplanation": "Переменная x существует и имеет значение 1 внутри функции test."
    },
    {
      "question": "Что такое замыкание простыми словами?",
      "options": ["Функция, которая помнит переменные извне", "Способ закрыть программу", "Тип цикла", "Метод массива"],
      "correctAnswer": 0,
      "explanation": "Замыкание - это когда внутренняя функция имеет доступ к переменным внешней функции.",
      "wrongExplanation": "Замыкания позволяют функциям 'запоминать' переменные из внешней области видимости."
    },
    {
      "question": "Что выведет этот код?\nfunction outer() {\n  var message = 'Привет';\n  function inner() {\n    console.log(message);\n  }\n  inner();\n}\nouter();",
      "options": ["'Привет'", "undefined", "ReferenceError", "null"],
      "correctAnswer": 0,
      "explanation": "Внутренняя функция inner имеет доступ к переменной message из внешней функции outer.",
      "wrongExplanation": "Это пример замыкания - inner 'видит' переменную message из outer."
    },
    
    // ========== СРЕДНИЕ ВОПРОСЫ ==========
    {
      "question": "Что выведет этот код?\nfor (var i = 0; i < 3; i++) {\n  setTimeout(() => console.log(i), 100);\n}",
      "options": ["0, 1, 2", "3, 3, 3", "undefined", "ReferenceError"],
      "correctAnswer": 1,
      "explanation": "var имеет функциональную область видимости. К моменту выполнения setTimeout цикл завершен и i = 3.",
      "wrongExplanation": "Все setTimeout функции ссылаются на одну и ту же переменную i, которая изменяется в цикле."
    },
    {
      "question": "Как исправить предыдущий код с помощью IIFE?",
      "options": ["(function(j) { setTimeout(() => console.log(j), 100); })(i)", "Использовать let", "Использовать const", "Все варианты"],
      "correctAnswer": 3,
      "explanation": "IIFE создает новую область видимости для каждой итерации, let/const имеют блочную область видимости.",
      "wrongExplanation": "Все перечисленные способы создают отдельную область видимости для каждой итерации цикла."
    },
    {
      "question": "Что выведет этот код?\nfunction createCounter() {\n  let count = 0;\n  return {\n    increment: () => ++count,\n    decrement: () => --count,\n    value: () => count\n  };\n}\nconst counter = createCounter();\nconsole.log(counter.increment() + counter.value());",
      "options": ["1", "2", "0", "undefined"],
      "correctAnswer": 1,
      "explanation": "increment() увеличивает count до 1 и возвращает 1. value() возвращает текущий count (1). Сумма: 1 + 1 = 2.",
      "wrongExplanation": "Замыкание сохраняет доступ к переменной count, все методы работают с одной переменной."
    },
    
    // ========== СЛОЖНЫЕ ВОПРОСЫ ==========
    {
      "question": "Что выведет этот код?\nconst funcs = [];\nfor (let i = 0; i < 3; i++) {\n  funcs.push(() => i);\n}\nconsole.log(funcs[0]() + funcs[1]() + funcs[2]());",
      "options": ["0", "3", "6", "9"],
      "correctAnswer": 1,
      "explanation": "let создает новую переменную для каждой итерации. Каждая функция захватывает свое значение i: 0 + 1 + 2 = 3.",
      "wrongExplanation": "Блочная область видимости let создает отдельную переменную i для каждой итерации цикла."
    },
    {
      "question": "Что выведет этот код?\nfunction outer(x) {\n  return function middle(y) {\n    return function inner(z) {\n      return x + y + z;\n    };\n  };\n}\nconsole.log(outer(1)(2)(3));",
      "options": ["6", "123", "undefined", "function"],
      "correctAnswer": 0,
      "explanation": "Каждая функция сохраняет доступ к параметрам внешних функций через замыкание. 1 + 2 + 3 = 6.",
      "wrongExplanation": "Вложенные функции имеют доступ ко всем переменным внешних областей видимости."
    },
    {
      "question": "Что выведет этот код?\nlet x = 1;\nfunction test() {\n  console.log(x);\n  let x = 2;\n}\ntest();",
      "options": ["1", "2", "undefined", "ReferenceError"],
      "correctAnswer": 3,
      "explanation": "Локальная переменная x находится в temporal dead zone до ее объявления, поэтому возникает ReferenceError.",
      "wrongExplanation": "let поднимается, но недоступна до объявления. Локальная переменная затеняет глобальную."
    },
    {
      "question": "Что выведет этот код?\nconst module = (function() {\n  let private = 0;\n  return {\n    getPrivate: () => private,\n    setPrivate: (val) => private = val\n  };\n})();\nmodule.setPrivate(5);\nconsole.log(module.getPrivate());",
      "options": ["0", "5", "undefined", "ReferenceError"],
      "correctAnswer": 1,
      "explanation": "IIFE создает модуль с приватной переменной. setPrivate изменяет private на 5, getPrivate возвращает 5.",
      "wrongExplanation": "Паттерн модуля использует замыкание для создания приватных переменных и публичных методов."
    },
    {
      "question": "Что выведет этот код?\nfunction createAdder(x) {\n  return function(y) {\n    return x + y;\n  };\n}\nconst add5 = createAdder(5);\nconst add10 = createAdder(10);\nconsole.log(add5(3) + add10(2));",
      "options": ["8", "12", "20", "15"],
      "correctAnswer": 2,
      "explanation": "add5(3) = 5 + 3 = 8, add10(2) = 10 + 2 = 12. Сумма: 8 + 12 = 20.",
      "wrongExplanation": "Каждый вызов createAdder создает отдельное замыкание с собственным значением x."
    }
  ];

  // Тест: Функции
  static Map<String, dynamic> get functionsTest {
    return {
      "id": "js_functions_test",
      "title": "Функции в JavaScript",
      "category": "JavaScript",
      "difficulty": "Легкий",
      "track": "Junior Frontend (React)",
      "type": "Тест",
      "xpReward": 15,
      "energyCost": 3,
      "description": "Изучите основы функций: объявление, вызов, параметры и продвинутые концепции",
      "questions": _getRandomQuestions(_functionsQuestionsPool, 8),
    };
  }

  // Тест: Замыкания и область видимости
  static Map<String, dynamic> get closuresTest {
    return {
      "id": "js_closures_test",
      "title": "Замыкания и область видимости",
      "category": "JavaScript",
      "difficulty": "Средний",
      "track": "Junior Frontend (React)",
      "type": "Тест",
      "xpReward": 20,
      "energyCost": 4,
      "description": "Освойте область видимости, замыкания и продвинутые концепции JavaScript",
      "questions": _getRandomQuestions(_closuresQuestionsPool, 8),
    };
  }

  // Анализ кода: Функции
  static final List<Map<String, dynamic>> _functionsCodePool = [
    {
      "codeSnippet": """function test() {
  console.log(a); // Результат 1
  console.log(b); // Результат 2
  console.log(c); // Результат 3
  
  function a() { return 'function a'; }
  var b = function() { return 'function b'; };
  const c = () => 'arrow function c';
}

test();""",
      "questions": [
        {
          "question": "Что выведет первый console.log(a)?",
          "options": ["function a", "[Function: a]", "undefined", "ReferenceError"],
          "correctAnswer": 1,
          "explanation": "Function declarations полностью поднимаются, поэтому функция доступна до объявления.",
          "wrongExplanation": "В отличие от переменных, function declarations поднимаются целиком, включая реализацию."
        },
        {
          "question": "Что выведет первый console.log(b)?",
          "options": ["function b", "undefined", "[Function: b]", "ReferenceError"],
          "correctAnswer": 1,
          "explanation": "var b поднимается как undefined, функция присваивается только в месте объявления.",
          "wrongExplanation": "Function expressions не поднимаются, поднимается только объявление переменной."
        },
        {
          "question": "Что выведет первый console.log(c)?",
          "options": ["arrow function c", "undefined", "[Function: c]", "ReferenceError"],
          "correctAnswer": 3,
          "explanation": "const находится в temporal dead zone до объявления, поэтому возникает ReferenceError.",
          "wrongExplanation": "const и let поднимаются, но недоступны до объявления из-за temporal dead zone."
        }
      ]
    },
    {
      "codeSnippet": """const obj = {
  name: 'Object',
  regularMethod: function() {
    return this.name;
  },
  arrowMethod: () => {
    return this.name;
  },
  nestedMethod: function() {
    const inner = () => this.name;
    return inner();
  }
};

console.log(obj.regularMethod());  // Результат 1
console.log(obj.arrowMethod());    // Результат 2
console.log(obj.nestedMethod());   // Результат 3""",
      "questions": [
        {
          "question": "Что выведет obj.regularMethod()?",
          "options": ["'Object'", "undefined", "null", "ReferenceError"],
          "correctAnswer": 0,
          "explanation": "Обычная функция как метод объекта имеет this, указывающий на объект obj.",
          "wrongExplanation": "При вызове метода объекта this автоматически привязывается к этому объекту."
        },
        {
          "question": "Что выведет obj.arrowMethod()?",
          "options": ["'Object'", "undefined", "null", "ReferenceError"],
          "correctAnswer": 1,
          "explanation": "Arrow function наследует this из лексического контекста (глобального), где this.name undefined.",
          "wrongExplanation": "Arrow functions не имеют собственного this и не привязываются к объекту при вызове."
        },
        {
          "question": "Что выведет obj.nestedMethod()?",
          "options": ["'Object'", "undefined", "null", "ReferenceError"],
          "correctAnswer": 0,
          "explanation": "Arrow function inner наследует this от nestedMethod, который указывает на obj.",
          "wrongExplanation": "Arrow function внутри обычного метода наследует this этого метода."
        }
      ]
    }
  ];

  // Динамический анализ кода: Функции
  static Map<String, dynamic> get functionsCodeAnalysis {
    final randomCode = (_functionsCodePool..shuffle()).first;
    return {
      "id": "js_functions_code",
      "title": "Анализ кода: Функции",
      "category": "JavaScript",
      "difficulty": "Сложный",
      "track": "Junior Frontend (React)",
      "type": "Анализ кода",
      "xpReward": 30,
      "energyCost": 6,
      "description": "Проанализируйте поведение различных типов функций",
      "codeSnippet": randomCode["codeSnippet"],
      "questions": randomCode["questions"],
    };
  }

  // Обновленный метод получения всех тестов
  static List<Map<String, dynamic>> getAllTests() {
    return [
      // Модуль 1: Основы
      variablesTypesTest,
      operatorsTest,
      variablesCodeAnalysis,
      operatorsCodeAnalysis,
      // Модуль 2: Функции
      functionsTest,
      closuresTest,
      functionsCodeAnalysis,
    ];
  }
} 