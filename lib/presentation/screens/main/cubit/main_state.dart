abstract class MainState {}

final class MainInitState extends MainState {}

final class MaingetAllEventsLoadingState extends MainState {}

final class MaingetAllEventsSuccessState extends MainState {}

final class MaingetAllEventsErrorState extends MainState {
  final String error;

  MaingetAllEventsErrorState(this.error);
}
