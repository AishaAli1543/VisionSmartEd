import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';  // Import flutter_tts
import 'package:speech_to_text/speech_to_text.dart' as stt; // STT

class QuizScreen extends StatefulWidget {
  final String subject;

  const QuizScreen({super.key, required this.subject});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int?> selectedAnswers = []; // Initialize as empty
  int score = 0;
  bool showResults = false;
  final FlutterTts flutterTts = FlutterTts();  // Initialize TTS
  final stt.SpeechToText _speech = stt.SpeechToText(); // Initialize STT

  // Map of subject quizzes
  final Map<String, List<Map<String, dynamic>>> subjectQuizzes = {
    'Maths': [
      {
        'question': 'What is the basic element of algebra called?',
        'options': ['Variable', 'Angle', 'Constant', 'Polygon'],
        'answer': 0,
      },
      {
        'question': 'What is the result of solving a linear equation?',
        'options': ['A curve', 'A constant', 'A straight line', 'An inequality'],
        'answer': 2,
      },
      {
        'question': 'Which branch of mathematics deals with shapes and space?',
        'options': ['Calculus', 'Algebra', 'Geometry', 'Statistics'],
        'answer': 2,
      },
      {
        'question': 'What is the formula for the area of a circle?',
        'options': ['πr^2', '2πr', 'r^2', 'πd'],
        'answer': 0,
      },
      {
        'question': 'Which trigonometric function is opposite/hypotenuse?',
        'options': ['Sine', 'Cosine', 'Tangent', 'Cosecant'],
        'answer': 0,
      },
      {
        'question': 'What is the slope of the line y = 3x + 2?',
        'options': ['1', '2', '3', '4'],
        'answer': 2,
      },
      {
        'question': 'What theorem is used to solve right-angled triangles?',
        'options': ['Pythagorean Theorem', 'Euclidean Theorem', 'Fermat\'s Last Theorem', 'Algebraic Theorem'],
        'answer': 0,
      },
      {
        'question': 'What is the value of sin(90°)?',
        'options': ['0', '0.5', '1', 'Undefined'],
        'answer': 2,
      },
      {
        'question': 'In probability, what is the likelihood of flipping heads on a fair coin?',
        'options': ['0.25', '0.5', '0.75', '1'],
        'answer': 1,
      },
      {
        'question': 'Which concept deals with the rate of change of a function?',
        'options': ['Limits', 'Integrals', 'Derivatives', 'Exponents'],
        'answer': 2,
      },
    ],

    'Science': [
      {
        'question': 'What is the basic unit of matter?',
        'options': ['Atom', 'Molecule', 'Proton', 'Neutron'],
        'answer': 0,
      },
      {
        'question': 'Which gas is most abundant in Earth\'s atmosphere?',
        'options': ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
        'answer': 1,
      },
      {
        'question': 'What is the chemical formula for water?',
        'options': ['H₂O', 'CO₂', 'O₂', 'CH₄'],
        'answer': 0,
      },
      {
        'question': 'Who developed the theory of general relativity?',
        'options': ['Isaac Newton', 'Albert Einstein', 'Galileo Galilei', 'Niels Bohr'],
        'answer': 1,
      },
      {
        'question': 'Which planet is known as the "Red Planet"?',
        'options': ['Earth', 'Mars', 'Jupiter', 'Venus'],
        'answer': 1,
      },
      {
        'question': 'What is the speed of light in a vacuum?',
        'options': ['300,000 km/s', '150,000 km/s', '500,000 km/s', '1,000,000 km/s'],
        'answer': 0,
      },
      {
        'question': 'What is Newton\'s first law of motion?',
        'options': ['For every action, there is an equal and opposite reaction', 'An object at rest stays at rest', 'F = ma', 'Energy cannot be created or destroyed'],
        'answer': 1,
      },
      {
        'question': 'What is the smallest unit of life?',
        'options': ['Atom', 'Cell', 'Tissue', 'Organ'],
        'answer': 1,
      },
      {
        'question': 'What is the powerhouse of the cell?',
        'options': ['Nucleus', 'Mitochondria', 'Ribosome', 'Chloroplast'],
        'answer': 1,
      },
      {
        'question': 'Which of the following is an example of a chemical change?',
        'options': ['Melting ice', 'Burning wood', 'Breaking glass', 'Boiling water'],
        'answer': 1,
      },
    ],

    'English': [
      {
        'question': 'What is the plural of "child"?',
        'options': ['Childs', 'Children', 'Childrens', 'Childes'],
        'answer': 1,
      },
      {
        'question': 'Which part of speech describes a noun?',
        'options': ['Adjective', 'Verb', 'Adverb', 'Pronoun'],
        'answer': 0,
      },
      {
        'question': 'What is the past tense of "go"?',
        'options': ['Goed', 'Go', 'Went', 'Going'],
        'answer': 2,
      },
      {
        'question': 'Which literary device is used in "The world is a stage"?',
        'options': ['Simile', 'Metaphor', 'Alliteration', 'Personification'],
        'answer': 1,
      },
      {
        'question': 'Which word is a synonym for "happy"?',
        'options': ['Sad', 'Angry', 'Joyful', 'Tired'],
        'answer': 2,
      },
      {
        'question': 'What is a group of lines in a poem called?',
        'options': ['Paragraph', 'Sentence', 'Verse', 'Stanza'],
        'answer': 3,
      },
      {
        'question': 'Which of these is a preposition?',
        'options': ['Run', 'Jump', 'With', 'Because'],
        'answer': 2,
      },
      {
        'question': 'What is the main idea of a story called?',
        'options': ['Theme', 'Plot', 'Character', 'Setting'],
        'answer': 0,
      },
      {
        'question': 'What is a comparison using "like" or "as" called?',
        'options': ['Metaphor', 'Simile', 'Irony', 'Hyperbole'],
        'answer': 1,
      },
      {
        'question': 'Which part of speech expresses action?',
        'options': ['Noun', 'Verb', 'Adjective', 'Adverb'],
        'answer': 1,
      },
    ],

    'History': [
      {
        'question': 'Who was the first President of the United States?',
        'options': ['George Washington', 'Abraham Lincoln', 'John Adams', 'Thomas Jefferson'],
        'answer': 0,
      },
      {
        'question': 'What year did World War II end?',
        'options': ['1918', '1939', '1945', '1963'],
        'answer': 2,
      },
      {
        'question': 'Which empire was known for gladiatorial combat?',
        'options': ['Roman Empire', 'British Empire', 'Ottoman Empire', 'Persian Empire'],
        'answer': 0,
      },
      {
        'question': 'Where did the Renaissance begin?',
        'options': ['France', 'England', 'Italy', 'Spain'],
        'answer': 2,
      },
      {
        'question': 'Who was the leader of Germany during World War II?',
        'options': ['Adolf Hitler', 'Joseph Stalin', 'Winston Churchill', 'Franklin D. Roosevelt'],
        'answer': 0,
      },
      {
        'question': 'Which civilization built the pyramids?',
        'options': ['Romans', 'Greeks', 'Egyptians', 'Aztecs'],
        'answer': 2,
      },
      {
        'question': 'Who wrote the Declaration of Independence?',
        'options': ['Thomas Jefferson', 'Benjamin Franklin', 'George Washington', 'John Adams'],
        'answer': 0,
      },
      {
        'question': 'Who was known as the "Iron Lady"?',
        'options': ['Margaret Thatcher', 'Angela Merkel', 'Indira Gandhi', 'Queen Elizabeth I'],
        'answer': 0,
      },
      {
        'question': 'What was the purpose of the Great Wall of China?',
        'options': ['To stop floods', 'To protect against invasions', 'To mark territory', 'For transportation'],
        'answer': 1,
      },
      {
        'question': 'Which event started World War I?',
        'options': ['Sinking of the Titanic', 'Assassination of Archduke Franz Ferdinand', 'Pearl Harbor', 'Russian Revolution'],
        'answer': 1,
      },
    ],
  };

  bool _isListening = false; // Track listening status
  String _spokenCommand = ""; // Store recognized command

  @override
  void initState() {
    super.initState();
    _initializeQuiz();
    _initializeTTS();
  }

  Future<void> _initializeTTS() async {
    flutterTts.setCompletionHandler(() {
      print("TTS completed");
    });

    flutterTts.setErrorHandler((msg) {
      print("TTS error: $msg");
    });
  }

  void _initializeQuiz() {
    final quiz = subjectQuizzes[widget.subject] ?? [];
    // Initialize selectedAnswers based on quiz length
    if (selectedAnswers.isEmpty) {
      selectedAnswers = List<int?>.filled(quiz.length, null);
    }
    // Announce the first question
    _speakQuestion(0);
  }

  // Method to speak the current question and options
  Future<void> _speakQuestion(int index) async {
    final quiz = subjectQuizzes[widget.subject] ?? [];
    if (index < quiz.length) {
      String question = quiz[index]['question'];
      String options = quiz[index]['options'].join(', '); // Join options with commas
      String announcement = "Question: $question. Options are: $options";
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(announcement);
    }
  }

  void calculateScore() {
    score = 0;
    final quiz = subjectQuizzes[widget.subject] ?? [];
    for (int i = 0; i < quiz.length; i++) {
      if (selectedAnswers[i] == quiz[i]['answer']) {
        score++;
      }
    }
    setState(() {
      showResults = true;
    });

    // Announce the score after quiz completion
    _announceScore(score, quiz.length);
  }

  // Method to announce the score
  Future<void> _announceScore(int score, int totalQuestions) async {
    String announcement = "You scored $score out of $totalQuestions.";
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(announcement);
  }

  // Start listening for voice input (STT)
  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _spokenCommand = val.recognizedWords;
            });
            _handleVoiceCommand(_spokenCommand);
          },
        );
      } else {
        setState(() => _isListening = false);
        await flutterTts.speak('Speech recognition not available.');
      }
    }
  }

  // Stop listening for voice input
  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  // Handle voice commands
  void _handleVoiceCommand(String command) {
    final normalizedCommand = command.trim().toLowerCase();
    print("Recognized Command: $normalizedCommand"); // Debugging line

    if (normalizedCommand.contains("next question")) {
      // Logic to go to the next question
      int currentQuestionIndex = selectedAnswers.indexOf(null);
      if (currentQuestionIndex != -1) {
        _speakQuestion(currentQuestionIndex);
      } else {
        calculateScore();
      }
    } else {
      flutterTts.speak("Command not recognized. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = subjectQuizzes[widget.subject] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} Quiz'),
        actions: [
          IconButton(
            icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
            onPressed: _isListening ? _stopListening : _startListening,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showResults
            ? _buildResultsView(quiz)
            : _buildQuizView(quiz),
      ),
    );
  }

  Widget _buildQuizView(List<Map<String, dynamic>> quiz) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: quiz.length,
            itemBuilder: (context, index) {
              return _buildQuizQuestion(
                question: quiz[index]['question'],
                options: quiz[index]['options'],
                questionIndex: index,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResultsView(List<Map<String, dynamic>> quiz) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Your Score: $score / ${quiz.length}', style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              showResults = false;
              selectedAnswers = List<int?>.filled(quiz.length, null);
            });
            // Announce the first question again when retrying
            _speakQuestion(0);
          },
          child: const Text('Retry Quiz'),
        ),
      ],
    );
  }

  Widget _buildQuizQuestion({
    required String question,
    required List<String> options,
    required int questionIndex,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        for (var i = 0; i < options.length; i++)
          RadioListTile<int>(
            title: Text(options[i]),
            value: i,
            groupValue: selectedAnswers[questionIndex],
            onChanged: (int? value) {
              setState(() {
                selectedAnswers[questionIndex] = value;
              });
            },
          ),
        ElevatedButton(
          onPressed: () {
            if (selectedAnswers[questionIndex] != null) {
              // Speak the next question
              if (questionIndex + 1 < subjectQuizzes[widget.subject]!.length) {
                _speakQuestion(questionIndex + 1);
              } else {
                // If it's the last question, announce the score
                calculateScore();
              }
            }
          },
          child: const Text('Submit Answer'),
        ),
        const SizedBox(height: 20), // Add some space between questions
      ],
    );
  }
}
