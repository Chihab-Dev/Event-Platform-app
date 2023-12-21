abstract class EventDetailState {}

final class EventDetailInitState extends EventDetailState {}

final class EventDetailRegisterInEventLoadingState extends EventDetailState {}

final class EventDetailRegisterInEventSuccessState extends EventDetailState {}

final class EventDetailRegisterInEventErrorState extends EventDetailState {
  final String error;

  EventDetailRegisterInEventErrorState(this.error);
}

final class EventDetailGetUseByIdLoadingState extends EventDetailState {}

final class EventDetailGetUseByIdSuccessState extends EventDetailState {}

final class EventDetailGetUseByIdErrorState extends EventDetailState {
  final String error;

  EventDetailGetUseByIdErrorState(this.error);
}
