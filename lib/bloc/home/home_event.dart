part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class AddActiveBox extends HomeEvent {
  final ActiveBox activeBox;

  AddActiveBox({required this.activeBox});
}

final class ResetBox extends HomeEvent {
  ResetBox();
}
