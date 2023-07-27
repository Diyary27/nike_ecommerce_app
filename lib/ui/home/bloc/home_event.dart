part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeStarted extends HomeEvent {
  final bool isRefresh;

  HomeStarted({required this.isRefresh});
}
