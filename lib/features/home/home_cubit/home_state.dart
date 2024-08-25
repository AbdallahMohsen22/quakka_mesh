part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class AppChangeChosePageState extends HomeState {}
class AppChangeLanguageStates extends HomeState {}
class LatestNewsLoading extends HomeState {}

