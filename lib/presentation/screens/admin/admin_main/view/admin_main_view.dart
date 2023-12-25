// ignore_for_file: must_be_immutable

import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/presentation/resources/color_manager.dart';
import 'package:event_platform_app/presentation/resources/strings_manager.dart';
import 'package:event_platform_app/presentation/resources/styles_manager.dart';
import 'package:event_platform_app/presentation/resources/values_manager.dart';
import 'package:event_platform_app/presentation/resources/widgets.dart';
import 'package:event_platform_app/presentation/screens/admin/admin_event_detail/view/admin_event_detail_view.dart';
import 'package:flutter/material.dart';

class AdminMainView extends StatelessWidget {
  List<Event> list = [];
  AdminMainView({required this.list, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.blue,
        title: Text(
          AppStrings.admin,
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
                            builder: (context) => AdminEventDetailView(
                              event: event,
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
  }
}
