import 'package:event_platform_app/core/services/services_locator.dart';
import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/domain/entities/member.dart';
import 'package:event_platform_app/domain/usecases/get_event_byId_usecase.dart';
import 'package:event_platform_app/domain/usecases/register_in_event_usecase.dart';
import 'package:event_platform_app/presentation/screens/event_detail/cubit/event_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  EventDetailCubit() : super(EventDetailInitState());

  static EventDetailCubit get(context) => BlocProvider.of(context);

  final RegisterInEventUsecase _registerInEventUsecase = RegisterInEventUsecase(getIt());

  final GetEventByIdUsecase _getEventByIdUsecase = GetEventByIdUsecase(getIt());

  bool userRegistered = false;

  void registerInEvent(Member member, String eventId, BuildContext context) async {
    emit(EventDetailRegisterInEventLoadingState());
    (await _registerInEventUsecase.execute(member.email, eventId)).fold(
      (failure) {
        print("🛑 error registerInEvent");
        emit(EventDetailRegisterInEventErrorState(failure.messageError));
      },
      (data) async {
        print("✅ registerInEvent");
        userRegistered = true;
        emit(EventDetailRegisterInEventSuccessState());
      },
    );
  }

  Event event = Event(
    id: 'id',
    name: 'name',
    desc: 'desc',
    image: 'image',
    category: 'category',
    dateBegin: 'dateBegin',
    dateEnd: 'dateEnd',
    registeredUsers: [],
  );

  void getEventByid(String id) async {
    emit(EventDetailGetEventByIdLoadingState());

    (await _getEventByIdUsecase.execute(id)).fold(
      (failure) {
        print("🛑 error getEventByid");
        emit(EventDetailGetEventByIdErrorState(failure.messageError));
      },
      (data) {
        event = data;
        emit(EventDetailGetEventByIdSuccessState());
      },
    );
  }
}
