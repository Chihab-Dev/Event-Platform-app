abstract class EventDetailState {}

final class EventDetailInitState extends EventDetailState {}

final class EventDetailRegisterInEventLoadingState extends EventDetailState {}

final class EventDetailRegisterInEventSuccessState extends EventDetailState {}

final class EventDetailRegisterInEventErrorState extends EventDetailState {
  final String error;

  EventDetailRegisterInEventErrorState(this.error);
}

final class EventDetailGetEventByIdLoadingState extends EventDetailState {}

final class EventDetailGetEventByIdSuccessState extends EventDetailState {}

final class EventDetailGetEventByIdErrorState extends EventDetailState {
  final String error;

  EventDetailGetEventByIdErrorState(this.error);
}
