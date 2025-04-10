import 'package:flutter/material.dart';
import 'package:school_mgmt/screens/solution_screen.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/card_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({super.key});

  @override
  State<QuestionListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuestionListScreen> {
  List<Map<String, dynamic>> _questions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      final response = await Supabase.instance.client
          .from('questions')
          .select('*')
          .order('created_at', ascending: false)
          .limit(10);
      setState(() {
        _questions = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching questions: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load questions')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Row(
          children: [
            Image.asset(
              "assets/icons/quiz.png",
              color: theme.colorScheme.onPrimary,
              height: appBarIconHeight,
            ),
            const SizedBox(width: 10),
            Text(
              'Q U E S T I O N S',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _questions.isEmpty
              ? const Center(child: Text("No questions available"))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final question = _questions[index];
                      return CustomCard(
                        titleText: "Question ${index + 1}",
                        bodyText: question['question'],
                        buttonLabel: "Answer",
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TeacherSolutionScreen(
                              questionNumber: index + 1,
                              questionText: question['question'],
                            ),
                          ));
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
