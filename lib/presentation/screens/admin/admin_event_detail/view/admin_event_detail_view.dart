import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/presentation/resources/color_manager.dart';
import 'package:event_platform_app/presentation/resources/styles_manager.dart';
import 'package:event_platform_app/presentation/resources/values_manager.dart';
import 'package:event_platform_app/presentation/resources/widgets.dart';
import 'package:event_platform_app/presentation/screens/admin/admin_write_email/view/admin_write_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminEventDetailView extends StatelessWidget {
  Event event;
  AdminEventDetailView({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: AppPadding.p30.sp),
              child: customElevatodButton(
                event.registeredUsers.isEmpty ? "no registered users" : "Write Email",
                event.registeredUsers.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminWriteEmailView(
                                event: event,
                              ),
                            ));
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
  }
}
