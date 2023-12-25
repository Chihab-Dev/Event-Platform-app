import 'package:event_platform_app/core/services/app_preferences.dart';
import 'package:event_platform_app/core/services/services_locator.dart';
import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/domain/entities/member.dart';
import 'package:event_platform_app/domain/repository/repository.dart';
import 'package:event_platform_app/domain/usecases/get_all_events.dart';
import 'package:event_platform_app/domain/usecases/get_user_byId_usecase.dart';
import 'package:event_platform_app/presentation/screens/main/cubit/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitState());

  static MainCubit get(context) => BlocProvider.of(context);

  final GetAllEventsUsecase _getAllEventsUsecase = GetAllEventsUsecase(getIt<Repository>());

  List<Event> eventsList = [];

  final GetUserByIdUsecase _getUserByIdUsecase = GetUserByIdUsecase(getIt());

  final AppPrefrences _appPrefrences = AppPrefrences(getIt());

  Member member = Member(id: '', fullName: '', email: '');

  void getUserById() async {
    (await _getUserByIdUsecase.execute(_appPrefrences.getUserId()!)).fold(
      (failure) {
        print("🛑 error getUserById");
      },
      (data) {
        print("✅ getUserById");
        member = data;
        print(data.fullName);
      },
    );
  }

  void getAllEvents() async {
    emit(MaingetAllEventsLoadingState());
    (await _getAllEventsUsecase.execute()).fold(
      (failure) {
        print('🛑 error getAllEvents');
        emit(MaingetAllEventsErrorState(failure.messageError));
      },
      (data) {
        print('✅ getAllEvents');
        eventsList = data;
        emit(MaingetAllEventsSuccessState());
      },
    );
  }
}
