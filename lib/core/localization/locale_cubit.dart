import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newslingo/data/datasources/local/user_local_datasource.dart';

class LocaleCubit extends Cubit<Locale> {
  final UserLocalDataSource _localDataSource;

  LocaleCubit(this._localDataSource) : super(const Locale('ar'));

  Future<void> loadLocale() async {
    final saved = await _localDataSource.getLocale();
    if (saved != null) {
      emit(Locale(saved));
    }
  }

  Future<void> setLocale(Locale locale) async {
    await _localDataSource.saveLocale(locale.languageCode);
    emit(locale);
  }

  Future<void> setLanguageCode(String code) async {
    await _localDataSource.saveLocale(code);
    emit(Locale(code));
  }
}
