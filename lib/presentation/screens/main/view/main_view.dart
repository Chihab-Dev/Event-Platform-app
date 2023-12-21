import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/presentation/resources/color_manager.dart';
import 'package:event_platform_app/presentation/resources/styles_manager.dart';
import 'package:event_platform_app/presentation/resources/values_manager.dart';
import 'package:event_platform_app/presentation/resources/widgets.dart';
import 'package:event_platform_app/presentation/screens/event_detail/view/event_details_view.dart';
import 'package:event_platform_app/presentation/screens/main/cubit/main_cubit.dart';
import 'package:event_platform_app/presentation/screens/main/cubit/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..getAllEvents()
        ..getUserById(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
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

  Widget eventContainer(Event event, Function()? onTap) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p20.sp),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            color: ColorManager.whiteGrey,
          ),
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: AppSize.s200.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppPadding.p18.sp),
                    color: ColorManager.red,
                    image: DecorationImage(
                      image: NetworkImage(event.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s14.sp),
                Text(
                  event.name,
                  style: getlargeStyle(color: ColorManager.blue),
                ),
                SizedBox(height: AppSize.s8.sp),
                Text(
                  event.desc,
                  style: getMeduimStyle(color: ColorManager.blue),
                ),
                SizedBox(height: AppSize.s8.sp),
                Row(
                  children: [
                    const Icon(Icons.developer_board),
                    const SizedBox(width: AppSize.s10),
                    Text(
                      event.category,
                      style: getMeduimStyle(color: ColorManager.greenBlue),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.s8.sp),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: ColorManager.blue,
                    ),
                    const SizedBox(width: AppSize.s10),
                    Text(
                      event.dateBegin,
                      style: getMeduimStyle(color: ColorManager.greenBlue),
                    ),
                    const SizedBox(width: AppSize.s10),
                    Text(
                      event.dateEnd,
                      style: getMeduimStyle(color: ColorManager.greenBlue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
