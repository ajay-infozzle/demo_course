import 'package:demo_course_video/core/utils/colors.dart';
import 'package:demo_course_video/core/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoaderWidget extends StatelessWidget {
  const HomeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: DeviceDimens.width,
        height: DeviceDimens.height,
        color: AppColor.white,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(.6),
          highlightColor: AppColor.appbar.withOpacity(.001),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  color: Colors.grey.withOpacity(.2),
                ), 
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: DeviceDimens.width*0.03, vertical: DeviceDimens.width*0.03),
                height: 30,
                color: Colors.grey.withOpacity(.2),
              ),
              Container(
                margin: EdgeInsets.only(left: DeviceDimens.width*0.03, right: DeviceDimens.width*0.1,bottom:  DeviceDimens.width*0.03),
                height: 20,
                color: Colors.grey.withOpacity(.2),
              ),

              SizedBox(height: DeviceDimens.width*0.06,),

              Expanded(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: DeviceDimens.width*0.03),
                      height: 50,
                      color: Colors.grey.withOpacity(.2),
                    );
                  }, 
                  separatorBuilder: (context, index) => SizedBox(height: DeviceDimens.width*0.03,), 
                  itemCount: 7
                ) 
              )
            ],
          ),
        ),
      ),
    );
  }
}