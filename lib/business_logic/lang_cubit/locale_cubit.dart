import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mr_monitor3/data/language_code_helper/language_cache_helper.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleInitial());
  Future<void> getSavedLanguage()async{
    final String cachedLanguageCode=await LanguageCacheHelper().getCachedLanguageCode();
    emit(ChangeLocaleState(Locale(cachedLanguageCode)));
  }
  Future<void> changeLanguage(String languageCode)async{
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    emit(ChangeLocaleState(Locale(languageCode)));
  }
}
