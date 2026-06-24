import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/usecases/manage_vocabulary.dart';
import 'package:newslingo/presentation/cubit/word/word_state.dart';

class WordCubit extends Cubit<WordState> {
  final ManageVocabulary manageVocabulary;

  WordCubit(this.manageVocabulary) : super(const WordState());

  Future<void> loadSavedWords() async {
    emit(state.copyWith(isLoading: true));
    try {
      final words = await manageVocabulary.getSavedWords();
      emit(
        state.copyWith(isLoading: false, savedWords: words, errorMessage: null),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> addWord(SavedWord word) async {
    try {
      await manageVocabulary.saveWord(word);
      final updated = [word, ...state.savedWords];
      emit(
        state.copyWith(savedWords: updated, dailyCount: state.dailyCount + 1, errorMessage: null),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> deleteWord(String word) async {
    try {
      await manageVocabulary.deleteWord(word);
      final updated = state.savedWords.where((w) => w.word != word).toList();
      emit(state.copyWith(savedWords: updated, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> markReviewed(String word) async {
    final idx = state.savedWords.indexWhere((w) => w.word == word);
    if (idx == -1) return;
    final w = state.savedWords[idx];
    try {
      final updated = w.copyWith(
        reviewCount: w.reviewCount + 1,
        nextReviewDate: DateTime.now().add(const Duration(days: 1)),
      );
      await manageVocabulary.updateWordReview(updated);
      final updatedList = [...state.savedWords];
      updatedList[idx] = updated;
      emit(state.copyWith(savedWords: updatedList, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
