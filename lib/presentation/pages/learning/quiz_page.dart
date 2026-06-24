import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';

class QuizPage extends StatefulWidget {
  final String articleId;
  final Quiz? initialQuiz;

  const QuizPage({super.key, required this.articleId, this.initialQuiz});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  int _currentQuestion = 0;
  int? _selectedAnswer;
  bool _showFeedback = false;
  int _correctCount = 0;
  int _wrongCount = 0;
  final DateTime _startTime = DateTime.now();
  List<QuizQuestion> _questions = [];
  bool _isLoading = true;
  String? _errorMessage;

  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnimation;

  @override
  void initState() {
    super.initState();
    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _feedbackAnimation = CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.easeOutBack,
    );
    if (widget.initialQuiz != null && widget.initialQuiz!.questions.isNotEmpty) {
      _questions = widget.initialQuiz!.questions;
      _isLoading = false;
    } else {
      _loadQuiz();
    }
  }

  Future<void> _loadQuiz() async {
    try {
      final quiz = await sl<NewsRepository>().getQuizForArticle(
        widget.articleId,
      );
      if (!mounted) return;
      if (quiz.questions.isEmpty) {
        setState(() {
          _isLoading = false;
          _errorMessage = AppLocalizations.of(context).articleNoQuiz;
        });
        return;
      }
      setState(() {
        _questions = quiz.questions;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = AppLocalizations.of(context).articleQuizError;
      });
    }
  }

  void _selectAnswer(int index) {
    if (_showFeedback) return;
    setState(() {
      _selectedAnswer = index;
      _showFeedback = true;
      if (index == _questions[_currentQuestion].correctIndex) {
        _correctCount++;
      } else {
        _wrongCount++;
      }
    });
    _feedbackController.forward();
  }

  void _nextQuestion() {
    if (_currentQuestion >= _questions.length - 1) {
      final timeTaken = DateTime.now().difference(_startTime).inSeconds;
      context.go(
        '/quiz-results',
        extra: {
          'correct': _correctCount,
          'wrong': _wrongCount,
          'total': _questions.length,
          'timeTaken': timeTaken,
          'questions': _questions,
          'selectedAnswers': _selectedAnswers,
        },
      );
      return;
    }
    setState(() {
      _currentQuestion++;
      _selectedAnswer = null;
      _showFeedback = false;
    });
    _feedbackController.reset();
  }

  List<int> get _selectedAnswers {
    final answers = <int>[];
    for (int i = 0; i <= _currentQuestion; i++) {
      if (i == _currentQuestion && _selectedAnswer != null) {
        answers.add(_selectedAnswer!);
      } else if (i < _currentQuestion) {
        answers.add(-1);
      }
    }
    return answers;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    if (_isLoading) {
      return Scaffold(
        body: Container(
          color: AppColors.background,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_errorMessage != null || _questions.isEmpty) {
      return Scaffold(
        body: Container(
          color: AppColors.background,
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('😕', style: TextStyle(fontSize: 64)),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      _errorMessage ?? t.articleNoQuiz,
                      style: AppTypography.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    final question = _questions[_currentQuestion];
    final progress = (_currentQuestion) / _questions.length;

    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.xs,
                  AppSpacing.sm,
                  AppSpacing.xl,
                  AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 24),
                      onPressed: () => context.pop(),
                    ),
                    const Spacer(),
                    const Text('📝', style: TextStyle(fontSize: 22)),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Quiz',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusFull,
                        ),
                      ),
                      child: Text(
                        '${_correctCount * 10}/${_questions.length * 10}',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusFull,
                      ),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: AppColors.surfaceVariant,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      t.quizProgress(_currentQuestion + 1, _questions.length),
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xxl),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusXl,
                        ),
                        boxShadow: AppColors.shadowMd,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMd,
                              ),
                            ),
                            child: const Center(
                              child: Text('❓', style: TextStyle(fontSize: 24)),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          Text(
                            question.question,
                            style: AppTypography.titleLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    ...question.options.asMap().entries.map((entry) {
                      final i = entry.key;
                      final option = entry.value;
                      final isSelected = _selectedAnswer == i;
                      final isCorrect = question.correctIndex == i;

                      Color? bgColor;
                      Color? borderColor;
                      String? prefix;

                      if (_showFeedback) {
                        if (isCorrect) {
                          bgColor = AppColors.successContainer;
                          borderColor = AppColors.success;
                          prefix = '✅';
                        } else if (isSelected) {
                          bgColor = AppColors.errorContainer;
                          borderColor = AppColors.error;
                          prefix = '❌';
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: AnimatedBuilder(
                          animation: _feedbackAnimation,
                          builder: (context, _) {
                            final scale = isSelected && _showFeedback
                                ? 1.0 + (_feedbackAnimation.value * 0.02)
                                : 1.0;
                            return Transform.scale(
                              scale: scale,
                              child: GestureDetector(
                                onTap: () => _selectAnswer(i),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.all(AppSpacing.lg),
                                  decoration: BoxDecoration(
                                    color: bgColor ?? AppColors.surface,
                                    borderRadius: BorderRadius.circular(
                                      AppSpacing.radiusMd,
                                    ),
                                    border: Border.all(
                                      color:
                                          borderColor ??
                                          (isSelected
                                              ? AppColors.primary
                                              : AppColors.outline.withValues(
                                                  alpha: 0.3,
                                                )),
                                      width: isSelected && !_showFeedback
                                          ? 2
                                          : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      if (prefix != null) ...[
                                        Text(
                                          prefix,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(width: AppSpacing.md),
                                      ],
                                      if (prefix == null)
                                        Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: AppColors.surfaceVariant,
                                            borderRadius: BorderRadius.circular(
                                              AppSpacing.radiusSm,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              String.fromCharCode(65 + i),
                                              style: AppTypography.labelMedium
                                                  .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      if (prefix == null)
                                        const SizedBox(width: AppSpacing.md),
                                      Expanded(
                                        child: Text(
                                          option,
                                          style: AppTypography.bodyLarge
                                              .copyWith(
                                                fontWeight:
                                                    isSelected && !_showFeedback
                                                    ? FontWeight.w600
                                                    : FontWeight.w400,
                                                height: 1.3,
                                              ),
                                        ),
                                      ),
                                      if (_showFeedback && isCorrect)
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: AppColors.success,
                                            borderRadius: BorderRadius.circular(
                                              AppSpacing.radiusSm,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.check_rounded,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                    const SizedBox(height: AppSpacing.lg),
                    if (_showFeedback)
                      Center(
                        child: FilledButton.icon(
                          onPressed: _nextQuestion,
                          icon: Icon(
                            _currentQuestion >= _questions.length - 1
                                ? Icons.done_all_rounded
                                : Directionality.of(context) == TextDirection.rtl
                                    ? Icons.arrow_back_rounded
                                    : Icons.arrow_forward_rounded,
                            size: 20,
                          ),
                          label: Text(
                            _currentQuestion >= _questions.length - 1
                                ? t.quizShowResults
                                : t.quizNext,
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.textOnPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xxxl,
                              vertical: AppSpacing.lg,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMd,
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}
