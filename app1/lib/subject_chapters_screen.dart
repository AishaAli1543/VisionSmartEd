import 'package:flutter/material.dart';
import 'ChapterDetailScreen.dart'; // Import ChapterDetailScreen

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

  // Mapping chapters to their descriptions
  final Map<String, String> chapterDescriptions = {
  "Chap 1: Algebra Basics": """
    Algebra is a fundamental branch of mathematics that involves the study of symbols and the rules for manipulating those symbols. In this chapter, you will explore variables, constants, expressions, and equations. Variables represent unknown quantities, and equations allow you to express relationships between them. You will also learn about algebraic operations such as addition, subtraction, multiplication, and division involving algebraic expressions.
    
    Understanding the basics of algebra is crucial for solving real-world problems, from calculating finances to engineering projects. This chapter forms the foundation for advanced mathematical topics like calculus, geometry, and linear algebra. By the end of this chapter, you will be able to solve linear equations, simplify algebraic expressions, and apply these concepts in various problem-solving scenarios.
  """,

  "Chap 2: Geometry Essentials": """
    Geometry is the study of shapes, sizes, and the properties of space. In this chapter, you will cover the basic elements of geometry, including points, lines, angles, surfaces, and solids. You will also explore different types of shapes such as triangles, quadrilaterals, and circles, and learn how to calculate their areas and perimeters. This chapter will also introduce the concept of congruence and similarity, helping you understand how geometric figures can be compared and manipulated.
    
    Moreover, geometry plays a significant role in various real-world applications such as architecture, engineering, and art. By mastering these fundamental concepts, you will be able to solve practical problems involving measurements, design structures, and analyze spatial relationships. Geometry is the bridge between mathematical theory and the physical world.
  """,

  "Chap 3: Calculus Introduction": """
    Calculus is a branch of mathematics that studies continuous change. This chapter introduces you to two main concepts in calculus: limits and derivatives. Limits allow us to understand the behavior of functions as they approach specific points, while derivatives measure how functions change. You will also learn about the rate of change and how it applies to real-world problems such as velocity and acceleration.
    
    In the second part of this chapter, you will explore the integral, which helps in calculating the area under curves and total accumulations. Calculus has a wide range of applications in fields like physics, economics, engineering, and biology, making it one of the most essential tools for understanding dynamic systems and solving complex problems.
  """,

  "Chap 4: Probability & Statistics": """
    Probability is the branch of mathematics concerned with the likelihood of events occurring. In this chapter, you will learn how to calculate probabilities, understand random variables, and explore different probability distributions. These tools are essential for analyzing uncertainty and making informed decisions in various fields such as finance, science, and everyday life.
    
    Statistics, on the other hand, involves the collection, analysis, and interpretation of data. You will learn how to describe data using measures such as mean, median, and mode, and how to represent it graphically. This chapter will help you understand how to draw conclusions from data and apply these insights to real-world situations, from scientific research to business analysis.
  """,

  "Chap 5: Trigonometry": """
    Trigonometry deals with the relationships between the sides and angles of triangles. In this chapter, you will study trigonometric functions such as sine, cosine, and tangent, which allow you to describe these relationships mathematically. You will also learn how to use the Pythagorean theorem to solve problems involving right-angled triangles and apply trigonometric identities in various scenarios.
    
    Trigonometry is widely used in fields like physics, engineering, and astronomy to solve problems involving angles and distances. Whether you're designing a building, navigating through space, or studying sound waves, the concepts of trigonometry provide the mathematical foundation to analyze and solve complex problems.
  """,

  "Chap 6: Linear Equations": """
    Linear equations involve mathematical expressions that, when plotted on a graph, form straight lines. This chapter focuses on solving and graphing linear equations, understanding slope-intercept form, and working with systems of linear equations. You'll learn how to use these equations to model relationships between quantities that change at a constant rate.
    
    Linear equations are not only foundational in algebra but also have broad applications in various real-world contexts, including economics, engineering, and science. From predicting trends to optimizing processes, mastering linear equations enables you to represent and analyze relationships between variables effectively.
  """,

  // Continue adding more detailed descriptions for other chapters
  "Chap 1: Physics Fundamentals": """
    Physics is the study of matter, energy, and the interactions between them. In this chapter, you will discover the laws of motion, the concept of force, and the relationship between mass and acceleration. You will also explore fundamental concepts such as gravity, friction, and momentum, which are crucial in understanding how objects move and interact in the physical world.

    By the end of the chapter, you will understand how to apply Newton's laws of motion to solve problems in real-world scenarios, from driving a car to launching a rocket. Physics provides a foundation for advanced topics in mechanics, thermodynamics, and electromagnetism, and it has countless applications in technology, engineering, and natural sciences.
  """,
  
  // Add more as needed
};


  // Mapping chapters to their content
  final Map<String, String> chapterContent = {
    "Chap 1: Algebra Basics": """
    Algebra is a fundamental branch of mathematics that involves the study of symbols and the rules for manipulating those symbols. In this chapter, you will explore variables, constants, expressions, and equations. Variables represent unknown quantities, and equations allow you to express relationships between them. You will also learn about algebraic operations such as addition, subtraction, multiplication, and division involving algebraic expressions.
    
    Understanding the basics of algebra is crucial for solving real-world problems, from calculating finances to engineering projects. This chapter forms the foundation for advanced mathematical topics like calculus, geometry, and linear algebra. By the end of this chapter, you will be able to solve linear equations, simplify algebraic expressions, and apply these concepts in various problem-solving scenarios.
  """,

  "Chap 2: Geometry Essentials": """
    Geometry is the study of shapes, sizes, and the properties of space. In this chapter, you will cover the basic elements of geometry, including points, lines, angles, surfaces, and solids. You will also explore different types of shapes such as triangles, quadrilaterals, and circles, and learn how to calculate their areas and perimeters. This chapter will also introduce the concept of congruence and similarity, helping you understand how geometric figures can be compared and manipulated.
    
    Moreover, geometry plays a significant role in various real-world applications such as architecture, engineering, and art. By mastering these fundamental concepts, you will be able to solve practical problems involving measurements, design structures, and analyze spatial relationships. Geometry is the bridge between mathematical theory and the physical world.
  """,

  "Chap 3: Calculus Introduction": """
    Calculus is a branch of mathematics that studies continuous change. This chapter introduces you to two main concepts in calculus: limits and derivatives. Limits allow us to understand the behavior of functions as they approach specific points, while derivatives measure how functions change. You will also learn about the rate of change and how it applies to real-world problems such as velocity and acceleration.
    
    In the second part of this chapter, you will explore the integral, which helps in calculating the area under curves and total accumulations. Calculus has a wide range of applications in fields like physics, economics, engineering, and biology, making it one of the most essential tools for understanding dynamic systems and solving complex problems.
  """,

  "Chap 4: Probability & Statistics": """
    Probability is the branch of mathematics concerned with the likelihood of events occurring. In this chapter, you will learn how to calculate probabilities, understand random variables, and explore different probability distributions. These tools are essential for analyzing uncertainty and making informed decisions in various fields such as finance, science, and everyday life.
    
    Statistics, on the other hand, involves the collection, analysis, and interpretation of data. You will learn how to describe data using measures such as mean, median, and mode, and how to represent it graphically. This chapter will help you understand how to draw conclusions from data and apply these insights to real-world situations, from scientific research to business analysis.
  """,

  "Chap 5: Trigonometry": """
    Trigonometry deals with the relationships between the sides and angles of triangles. In this chapter, you will study trigonometric functions such as sine, cosine, and tangent, which allow you to describe these relationships mathematically. You will also learn how to use the Pythagorean theorem to solve problems involving right-angled triangles and apply trigonometric identities in various scenarios.
    
    Trigonometry is widely used in fields like physics, engineering, and astronomy to solve problems involving angles and distances. Whether you're designing a building, navigating through space, or studying sound waves, the concepts of trigonometry provide the mathematical foundation to analyze and solve complex problems.
  """,

  "Chap 6: Linear Equations": """
    Linear equations involve mathematical expressions that, when plotted on a graph, form straight lines. This chapter focuses on solving and graphing linear equations, understanding slope-intercept form, and working with systems of linear equations. You'll learn how to use these equations to model relationships between quantities that change at a constant rate.
    
    Linear equations are not only foundational in algebra but also have broad applications in various real-world contexts, including economics, engineering, and science. From predicting trends to optimizing processes, mastering linear equations enables you to represent and analyze relationships between variables effectively.
  """,

  // Continue adding more detailed descriptions for other chapters
  "Chap 1: Physics Fundamentals": """
    Physics is the study of matter, energy, and the interactions between them. In this chapter, you will discover the laws of motion, the concept of force, and the relationship between mass and acceleration. You will also explore fundamental concepts such as gravity, friction, and momentum, which are crucial in understanding how objects move and interact in the physical world.

    By the end of the chapter, you will understand how to apply Newton's laws of motion to solve problems in real-world scenarios, from driving a car to launching a rocket. Physics provides a foundation for advanced topics in mechanics, thermodynamics, and electromagnetism, and it has countless applications in technology, engineering, and natural sciences.
  """,
  "Chap 2: Chemistry Basics": """
    Chemistry is the study of matter, its properties, and how substances interact and change. In this chapter, you will learn about atomic structure, the periodic table, and chemical bonds. You will explore how atoms combine to form molecules and how chemical reactions occur. The chapter also introduces basic concepts such as acids, bases, and the conservation of mass.

    Understanding chemistry is vital for a range of industries, from pharmaceuticals to environmental science. The knowledge gained in this chapter will help you grasp more complex topics in organic chemistry, chemical reactions, and material science, providing a solid foundation for exploring how matter shapes the world around us.
  """,

  "Chap 3: Biology Introduction": """
    Biology is the study of living organisms, their structure, function, growth, and evolution. In this chapter, you will explore the basic principles of cell biology, including the structure and function of cell organelles, the process of cell division, and the role of DNA in heredity. You will also be introduced to the concept of ecosystems and how different organisms interact with each other and their environment.

    By understanding the basic principles of biology, you can gain insights into how living systems function at the cellular and molecular levels. This knowledge is essential for further studies in genetics, evolution, and ecology. Biology has applications in medicine, agriculture, environmental science, and biotechnology, making it one of the most essential branches of the life sciences.
  """,

  "Chap 4: Environmental Science": """
    Environmental science is an interdisciplinary field that studies the interactions between humans and their environment. In this chapter, you will learn about ecosystems, biodiversity, and how energy flows through natural systems. You will also study key environmental challenges such as climate change, pollution, and deforestation, along with their impacts on the planet.

    The chapter will focus on sustainable practices and how we can mitigate environmental degradation through conservation efforts and renewable energy solutions. By the end of this chapter, you will understand how human activities affect the environment and what steps can be taken to create a more sustainable future.
  """,

  "Chap 5: Astronomy": """
    Astronomy is the study of celestial objects such as stars, planets, and galaxies, and how they interact within the universe. In this chapter, you will explore the solar system, the lifecycle of stars, and the structure of galaxies. You will also learn about the fundamental forces that govern the universe, such as gravity and electromagnetism.

    Astronomy provides insights into the origin of the universe and the potential for life beyond Earth. By studying this chapter, you will understand how modern telescopes and space exploration missions have advanced our knowledge of the cosmos. Astronomy not only satisfies human curiosity but also has practical applications in fields like satellite technology and global navigation systems.
  """,

  "Chap 6: Organic Chemistry": """
    Organic chemistry is the branch of chemistry that focuses on the structure, properties, and reactions of organic compounds containing carbon. In this chapter, you will explore the types of chemical bonds found in organic molecules, functional groups, and basic reactions such as substitution, elimination, and addition. You will also study the importance of organic chemistry in everyday life, from the synthesis of pharmaceuticals to the creation of plastics.

    Organic chemistry is critical in understanding biological processes, as most biomolecules are organic. This chapter serves as the foundation for advanced studies in biochemistry, medicinal chemistry, and industrial applications such as polymer chemistry and petrochemical production.
  """,
  "Chap 1: Grammar Essentials": """
    Grammar is the foundation of effective communication in any language. In this chapter, you will learn the essential rules of English grammar, including sentence structure, parts of speech, tenses, and punctuation. Understanding grammar is crucial for writing clear and concise sentences, as well as for improving your reading and speaking skills.

    Mastering grammar will not only help you in academic settings but also in everyday communication. This chapter sets the stage for more advanced language studies, helping you develop the tools needed to express ideas correctly and efficiently. Whether you're writing essays or giving presentations, a strong grasp of grammar is essential for success.
  """,

  "Chap 2: Writing Techniques": """
    Writing is a powerful tool for communication, and in this chapter, you will learn how to structure and organize your ideas effectively. This chapter covers various types of writing, including persuasive essays, narrative writing, and reports. You will explore different writing techniques such as brainstorming, drafting, revising, and editing to improve the clarity and flow of your work.

    By the end of this chapter, you will have the skills to produce well-organized and polished pieces of writing for different purposes and audiences. Writing techniques are not only important for academic success but also essential in professional environments where clear communication is key.
  """,

  "Chap 3: Literature Overview": """
    This chapter provides an introduction to classic literature, exploring works from different time periods and genres. You will learn how to analyze literary elements such as theme, plot, character development, and symbolism. The chapter will cover notable authors and works from various regions, helping you gain a broader understanding of cultural and historical contexts in literature.

    Studying literature helps develop critical thinking and interpretative skills, allowing you to engage with texts on a deeper level. By examining the ideas and messages conveyed through literature, you will learn how stories reflect human experience, societal values, and philosophical questions.
  """,

  "Chap 4: Comprehension Skills": """
    Comprehension is the ability to understand and interpret written text. This chapter focuses on developing strategies to improve your reading comprehension, such as identifying main ideas, making inferences, and summarizing content. You will practice reading a variety of texts, from short stories to informational articles, and learn how to analyze the structure and purpose of each.

    By improving your comprehension skills, you will become a more effective reader in both academic and real-world contexts. Whether you're studying for exams, reading novels, or reviewing reports at work, strong comprehension skills are essential for extracting meaning and making informed decisions based on written information.
  """,

  "Chap 5: Poetry Analysis": """
    Poetry is a unique form of literature that uses rhythm, meter, and figurative language to convey emotions and ideas. In this chapter, you will learn how to analyze poems, focusing on elements such as imagery, symbolism, and tone. You will also study various forms of poetry, from sonnets to free verse, and explore how poets use language to evoke feelings and create meaning.

    Poetry analysis requires careful attention to detail and an understanding of literary devices. By studying poetry, you will enhance your ability to appreciate the artistic use of language and deepen your understanding of how writers express complex emotions and concepts through verse.
  """,

  "Chap 6: Vocabulary Building": """
    A strong vocabulary is essential for effective communication and academic success. In this chapter, you will focus on expanding your vocabulary through reading and word-building exercises. You will learn strategies for understanding unfamiliar words in context, and explore synonyms, antonyms, and root words to enhance your language skills.

    Building your vocabulary will improve your ability to express ideas clearly and accurately, whether you're writing essays, giving presentations, or engaging in everyday conversations. This chapter provides the tools you need to become a more articulate and confident communicator.
  """,

  // History chapters

  "Chap 1: Ancient Civilizations": """
    Ancient civilizations such as Mesopotamia, Egypt, and the Indus Valley were the earliest societies to develop systems of governance, trade, and culture. This chapter explores how these civilizations arose, the key contributions they made in areas such as writing, architecture, and religion, and how they influenced the development of human society.

    By studying ancient civilizations, you gain insights into how human beings have structured their lives over millennia, the common challenges they faced, and the legacy they left behind. The innovations of these societies laid the groundwork for future advancements in science, art, and politics.
  """,

  "Chap 2: World Wars": """
    The two World Wars of the 20th century were among the most devastating conflicts in human history, reshaping borders, politics, and economies on a global scale. In this chapter, you will explore the causes, key events, and aftermath of both World War I and World War II, including the rise of totalitarian regimes, the impact on civilian populations, and the creation of international organizations like the United Nations.

    These wars had far-reaching consequences, leading to the Cold War, decolonization, and the establishment of new world powers. By understanding the complexities and tragedies of the World Wars, you will gain insight into the origins of many of the geopolitical issues that continue to shape the world today.
  """,

  "Chap 3: Renaissance Era": """
    The Renaissance was a period of cultural rebirth that began in Italy and spread throughout Europe between the 14th and 17th centuries. This chapter delves into the artistic, scientific, and intellectual achievements of the time, from the works of Leonardo da Vinci and Michelangelo to the revolutionary ideas of Copernicus and Galileo.

    The Renaissance also marked a shift in thinking, with a renewed focus on humanism, individualism, and secularism. This era paved the way for the scientific revolution, the Enlightenment, and modern philosophy, influencing the course of Western history and thought.
  """,

  "Chap 4: Modern History": """
    Modern history, covering the 19th and 20th centuries, witnessed profound changes in political, social, and economic structures. In this chapter, you will study key events such as the Industrial Revolution, the rise of nationalism, and the spread of democracy. You will also explore the impacts of technological advancements, such as the development of electricity, automobiles, and airplanes, which transformed industries and societies globally.

    By examining modern history, you will gain a deeper understanding of how the contemporary world was shaped, including the struggles for independence in colonized regions, civil rights movements, and the ongoing challenges of globalization and technological change.
  """,

  "Chap 5: Colonial Period": """
    The colonial period saw European nations expand their empires across Africa, Asia, and the Americas, often exploiting local populations and resources. This chapter explores the motivations for colonization, such as economic gain, religious conversion, and geopolitical power. You will study the long-lasting impacts of colonization on both the colonizers and the colonized, including the cultural, political, and economic changes that occurred.

    Understanding the colonial period is essential for grasping the complexities of modern geopolitics, as many conflicts and challenges in today’s world are rooted in the colonial legacy. From independence movements to post-colonial economic struggles, the effects of colonization continue to influence global affairs.
  """,

  "Chap 6: Industrial Revolution": """
    The Industrial Revolution was a period of unprecedented technological and industrial growth that began in the late 18th century and continued into the 19th century. This chapter covers key inventions such as the steam engine, spinning jenny, and power loom, and how they transformed manufacturing, transportation, and communication. You will also study the social changes brought about by industrialization, such as urbanization, the rise of factory work, and the emergence of new social classes.

    The Industrial Revolution had far-reaching consequences, both positive and negative, on society and the environment. It led to increased productivity and economic growth but also caused environmental degradation and harsh working conditions. Understanding this period is key to comprehending the origins of modern capitalism and industrial society.
  """,
  };


  String selectedSubject = "Maths"; // Default subject
  List<String> selectedChapters = [];

  @override
  void initState() {
    super.initState();
    selectedChapters = subjectChapters[selectedSubject]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Explore Different Subjects',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Subject',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedSubject,
              icon: const Icon(Icons.arrow_drop_down),
              items: subjects.map((String subject) {
                return DropdownMenuItem<String>(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),
              onChanged: (String? newSubject) {
                setState(() {
                  selectedSubject = newSubject!;
                  selectedChapters = subjectChapters[selectedSubject]!;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              '$selectedSubject Chapters',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: selectedChapters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        String selectedChapter = selectedChapters[index];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChapterDetailScreen(
                              chapterTitle: selectedChapter,
                              chapterDescription: chapterDescriptions[selectedChapter] ?? "No description available",
                              chapterContent: chapterContent[selectedChapter] ?? "No content available",
                              subject: selectedSubject,
                              quizQuestions: const [], // Provide quiz questions here
                            ),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          selectedChapters[index],
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
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
