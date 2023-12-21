import 'package:event_platform_app/core/services/services_locator.dart';
import 'package:event_platform_app/domain/entities/member.dart';
import 'package:event_platform_app/domain/usecases/register_in_event_usecase.dart';
import 'package:event_platform_app/presentation/screens/event_detail/cubit/event_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  EventDetailCubit() : super(EventDetailInitState());

  static EventDetailCubit get(context) => BlocProvider.of(context);

  final RegisterInEventUsecase _registerInEventUsecase = RegisterInEventUsecase(getIt());

  bool userRegistered = false;

  void registerInEvent(Member member, String eventId) async {
    emit(EventDetailRegisterInEventLoadingState());
    (await _registerInEventUsecase.execute(member.email, eventId)).fold(
      (failure) {
        print("🛑 error registerInEvent");
        emit(EventDetailRegisterInEventErrorState(failure.messageError));
      },
      (data) {
        print("✅ registerInEvent");
        userRegistered = true;
        emit(EventDetailRegisterInEventSuccessState());
      },
    );
  }
}
