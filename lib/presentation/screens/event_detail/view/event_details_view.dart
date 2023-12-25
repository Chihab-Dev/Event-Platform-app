// ignore_for_file: must_be_immutable

import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/domain/entities/member.dart';
import 'package:event_platform_app/presentation/resources/color_manager.dart';
import 'package:event_platform_app/presentation/resources/styles_manager.dart';
import 'package:event_platform_app/presentation/resources/values_manager.dart';
import 'package:event_platform_app/presentation/resources/widgets.dart';
import 'package:event_platform_app/presentation/screens/event_detail/cubit/event_detail_cubit.dart';
import 'package:event_platform_app/presentation/screens/event_detail/cubit/event_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailsView extends StatelessWidget {
  Event event;
  Member member;

  EventDetailsView({required this.event, required this.member, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventDetailCubit()..getEventByid(event.id),
      child: BlocConsumer<EventDetailCubit, EventDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = EventDetailCubit.get(context);
          return state is EventDetailGetEventByIdLoadingState
              ? loadingScreen()
              : Scaffold(
                  backgroundColor: ColorManager.white,
                  body: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: AppPadding.p30),
                          child: state is EventDetailRegisterInEventLoadingState
                              ? CircularProgressIndicator(
                                  color: ColorManager.blue,
                                )
                              : customElevatodButton(
                                  (cubit.event.registeredUsers.contains(member.email) || cubit.userRegistered == true)
                                      ? 'registered'
                                      : "register",
                                  (cubit.event.registeredUsers.contains(member.email) || cubit.userRegistered == true)
                                      ? null
                                      : () {
                                          cubit.registerInEvent(member, event.id, context);
                                        },
                                ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: AppSize.s400.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppPadding.p30.sp),
                                image: DecorationImage(
                                  image: NetworkImage(event.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(AppPadding.p12.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.name,
                                    style: getlargeStyle(
                                      color: ColorManager.blue,
                                    ),
                                  ),
                                  SizedBox(height: AppSize.s16.sp),
                                  Row(
                                    children: [
                                      const Icon(Icons.developer_board),
                                      const SizedBox(width: AppSize.s10),
                                      Text(
                                        event.category,
                                        style: getMeduimStyle(color: ColorManager.greenBlue),
                                      ),
                                      const Spacer(),
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
                                  SizedBox(height: AppSize.s16.sp),
                                  Text(
                                    event.desc,
                                    maxLines: 10,
                                    style: getMeduimStyle(
                                      color: ColorManager.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: AppSize.s250.sp),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
