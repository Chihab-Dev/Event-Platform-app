import 'package:event_platform_app/presentation/resources/color_manager.dart';
import 'package:event_platform_app/presentation/resources/strings_manager.dart';
import 'package:event_platform_app/presentation/resources/styles_manager.dart';
import 'package:event_platform_app/presentation/resources/values_manager.dart';
import 'package:event_platform_app/presentation/resources/widgets.dart';
import 'package:event_platform_app/presentation/screens/admin/admin_main/view/admin_main_view.dart';
import 'package:event_platform_app/presentation/screens/event_detail/view/event_details_view.dart';
import 'package:event_platform_app/presentation/screens/main/cubit/main_cubit.dart';
import 'package:event_platform_app/presentation/screens/main/cubit/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..getAllEvents()
        ..getUserById(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if (state is MaingetAllEventsErrorState) {
            errorToast(state.error).show(context);
          }
        },
        builder: (context, state) {
          var cubit = MainCubit.get(context);
          var list = cubit.eventsList;

          return state is MaingetAllEventsLoadingState
              ? loadingScreen()
              : Scaffold(
                  backgroundColor: ColorManager.white,
                  appBar: AppBar(
                    backgroundColor: ColorManager.blue,
                    title: Text(
                      'Events',
                      style: getlargeStyle(color: ColorManager.white),
                    ),
                    actions: [
                      if (cubit.member.id == AppStrings.adminId)
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminMainView(
                                    list: list,
                                  ),
                                ));
                          },
                          icon: Icon(
                            Icons.admin_panel_settings,
                            color: ColorManager.white,
                          ),
                        )
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppPadding.p18,
                      left: AppPadding.p18,
                      right: AppPadding.p18,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: AppPadding.p18),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(AppPadding.p8),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              var event = list[index];
                              return eventContainer(
                                event,
                                () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EventDetailsView(
                                          event: event,
                                          member: cubit.member,
                                        ),
                                      ));
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
