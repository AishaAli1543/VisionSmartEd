import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import flutter_tts
import 'ChapterDetailScreen.dart'; // Import ChapterDetailScreen
// Import Speech-to-Text

class SubjectChaptersScreen extends StatefulWidget {
  const SubjectChaptersScreen({super.key});

  @override
  _SubjectChaptersScreenState createState() => _SubjectChaptersScreenState();
}

class _SubjectChaptersScreenState extends State<SubjectChaptersScreen> {
  final List<String> subjects = [
    "Maths",
    "Science",
    "English",
    "History"
  ]; // List of subjects

  // Mapping of subjects to their respective chapters
  final Map<String, List<String>> subjectChapters = {
    "Maths": [
      "Chap 1: Algebra Basics",
      "Chap 2: Geometry Essentials",
      "Chap 3: Calculus Introduction",
      "Chap 4: Probability & Statistics",
      "Chap 5: Trigonometry",
      "Chap 6: Linear Equations"
    ],
    "Science": [
      "Chap 1: Physics Fundamentals",
      "Chap 2: Chemistry Basics",
      "Chap 3: Biology Introduction",
      "Chap 4: Environmental Science",
      "Chap 5: Astronomy",
      "Chap 6: Organic Chemistry"
    ],
    "English": [
      "Chap 1: Grammar Essentials",
      "Chap 2: Writing Techniques",
      "Chap 3: Literature Overview",
      "Chap 4: Comprehension Skills",
      "Chap 5: Poetry Analysis",
      "Chap 6: Vocabulary Building"
    ],
    "History": [
      "Chap 1: Ancient Civilizations",
      "Chap 2: World Wars",
      "Chap 3: Renaissance Era",
      "Chap 4: Modern History",
      "Chap 5: Colonial Period",
      "Chap 6: Industrial Revolution"
    ],
  };

  // Mapping chapters to their expanded descriptions
  final Map<String, String> chapterDescriptions = {
    // Maths
    "Chap 1: Algebra Basics": """
Algebra is a fundamental branch of mathematics that deals with symbols and the rules for manipulating these symbols. It is essential for solving equations and understanding mathematical relationships.

This chapter introduces key concepts such as variables, expressions, and equations. You will learn to simplify expressions, solve linear and quadratic equations, and explore inequalities. Algebra is foundational for advanced mathematics and practical applications like interest rates, data modeling, and engineering.
""",
    "Chap 2: Geometry Essentials": """
Geometry is the study of shapes, sizes, and the properties of space. It explores points, lines, angles, surfaces, and solids in both two and three dimensions.

This chapter introduces geometric concepts such as the Pythagorean theorem, congruence, and similarity. You will also learn about transformations, including rotations, translations, and reflections. Geometry is essential for architecture, design, and engineering.
""",
    "Chap 3: Calculus Introduction": """
Calculus is the mathematical study of continuous change and is vital for fields like physics, engineering, and economics. It is divided into differential calculus (rates of change) and integral calculus (accumulated quantities).

In this chapter, you will learn about limits, derivatives, and integrals. Derivatives help analyze rates of change, while integrals calculate areas under curves and accumulated growth. Applications include optimizing systems and solving complex problems.
""",
    "Chap 4: Probability & Statistics": """
Probability and statistics are crucial for understanding and interpreting data. Probability examines the likelihood of events, while statistics involves collecting, analyzing, and presenting data.

This chapter introduces probability distributions, mean, median, and standard deviation. You will also learn about histograms and scatter plots. These tools are vital in fields like data science, finance, and scientific research.
""",
    "Chap 5: Trigonometry": """
Trigonometry studies the relationships between the angles and sides of triangles. It has applications in fields like physics, astronomy, and engineering.

This chapter explores sine, cosine, and tangent functions, as well as their real-world uses in navigation, construction, and signal processing. Trigonometry provides a deeper understanding of wave motion, circular motion, and spatial dimensions.
""",
    "Chap 6: Linear Equations": """
Linear equations are equations of the first degree, involving one or more variables. They form the basis for understanding relationships in algebra.

This chapter covers solving linear equations, graphing them on a coordinate plane, and exploring systems of linear equations. Applications include predicting trends, calculating costs, and modeling real-world situations.
""",

    // Science
    "Chap 1: Physics Fundamentals": """
Physics is the study of matter, energy, and their interactions. It is foundational for understanding the universe and its natural phenomena.

This chapter covers Newton's laws of motion, conservation of energy, and thermodynamics. You will learn how forces cause motion, how energy transforms between forms, and how these principles apply to everyday life. Physics drives technological advancements, from renewable energy to space exploration.
""",
    "Chap 2: Chemistry Basics": """
Chemistry explores the composition, structure, and properties of matter. It is central to understanding the natural world and creating new materials.

In this chapter, you will study the periodic table, chemical reactions, and molecular structures. Topics include stoichiometry, thermochemistry, and bonding types. Chemistry impacts fields like medicine, agriculture, and environmental science.
""",
    "Chap 3: Biology Introduction": """
Biology is the study of living organisms, their structure, function, growth, and evolution. It explores cellular biology, genetics, and ecosystems.

In this chapter, you will learn about DNA replication, the human body, and ecological balance. Understanding biology is vital for addressing global challenges like climate change, health crises, and biodiversity conservation.
""",

    // English
    "Chap 1: Grammar Essentials": """
Grammar is the foundation of effective communication in any language. It ensures clarity, coherence, and precision.

This chapter covers parts of speech, sentence structure, and punctuation. You will learn to construct grammatically correct sentences and avoid common errors. Mastering grammar is essential for academic writing, professional communication, and creative expression.
""",
    "Chap 2: Writing Techniques": """
Writing is a powerful tool for communication, and in this chapter, you will learn how to structure and organize your ideas effectively.

Topics include crafting essays, persuasive writing, and storytelling techniques. Writing allows you to express your ideas clearly and impactfully. Practical exercises will help improve your style, tone, and coherence.
""",

    // History
    "Chap 1: Ancient Civilizations": """
Ancient civilizations such as Mesopotamia, Egypt, and the Indus Valley were the earliest societies to develop systems of governance, trade, and culture.

This chapter explores their contributions, from the invention of writing to architectural marvels like pyramids. Understanding ancient civilizations sheds light on human progress and societal development.
""",
    "Chap 2: World Wars": """
The two World Wars of the 20th century were among the most devastating conflicts in human history.

This chapter examines the causes, key battles, and outcomes of these wars. Topics include the Treaty of Versailles, World War II alliances, and the rise of global powers. Understanding these events helps contextualize modern geopolitics.
""",
    "Chap 3: Renaissance Era": """
The Renaissance was a period of cultural revival that began in Italy and spread throughout Europe.

This chapter explores the works of Leonardo da Vinci, Michelangelo, and Galileo, as well as advancements in art, science, and philosophy. The Renaissance laid the foundation for the modern world.
"""
    // Add other History chapters similarly...
  };

  String selectedSubject = "Maths"; // Default subject
  List<String> selectedChapters = [];
  final FlutterTts _flutterTts = FlutterTts(); // TTS instance

  @override
  void initState() {
    super.initState();
    selectedChapters = subjectChapters[selectedSubject]!;
    _flutterTts.setLanguage("en-US");
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text); // Speak the text
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Explore Different Subjects'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Subject', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: subjects.map((subject) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedSubject = subject;
                          selectedChapters = subjectChapters[selectedSubject]!;
                        });
                        speak("Selected subject: $subject");
                      },
                      child: Text(subject),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Text('$selectedSubject Chapters', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: selectedChapters.length,
                itemBuilder: (context, index) {
                  String chapterTitle = selectedChapters[index];
                  return ListTile(
                    title: Text(chapterTitle),
                    subtitle: Text(
                      chapterDescriptions[chapterTitle]?.split('.').first ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChapterDetailScreen(
                            chapterTitle: chapterTitle,
                            chapterContent: chapterDescriptions[chapterTitle] ?? "No content available",
                            subject: selectedSubject,
                            quizQuestions: [], chapterDescription: '',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
