import 'package:demo_course_video/core/utils/colors.dart';
import 'package:demo_course_video/core/utils/dimens.dart';
import 'package:flutter/material.dart';

class PlayListItemWidget extends StatelessWidget {
  const PlayListItemWidget({super.key, required this.title, required this.subTitle, required this.index, this.isViewed = false, this.isPlaying = false, required this.onTap, required this.isPreviouslyViewed, this.progressValue = 0.0, required this.videoCounter});

  final String title;
  final String subTitle;
  final int index;
  final int videoCounter;
  final bool isViewed;
  final bool isPlaying;
  final bool isPreviouslyViewed;
  final double progressValue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: DeviceDimens.width*0.03),
        color: isPlaying ? AppColor.meditationColor.withOpacity(.1) : Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // margin: EdgeInsets.only(left: DeviceDimens.width*0.03, right: DeviceDimens.width*0.06),
              alignment: Alignment.center,
              width: DeviceDimens.width*0.09,
              child: Text(
                videoCounter.toString(),
                style: TextStyle(
                  fontWeight: isPlaying ? FontWeight.bold : FontWeight.w400,
                  color: isPlaying ? AppColor.meditationColor :AppColor.black
                ),
              ),
            ),
      
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: DeviceDimens.width*0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: DeviceDimens.width*0.045,
                          fontWeight: isPlaying ? FontWeight.bold :FontWeight.w400,
                          color: isPlaying ? AppColor.meditationColor : AppColor.black
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                
                    SizedBox(
                      child: Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: DeviceDimens.width*0.035,
                          color: AppColor.blueGrey.withOpacity(.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ),
      
            SizedBox(width: DeviceDimens.width*0.05,),

            buildStatusIcon(),
          ],
        ),
      ),
    );
  }
  
  Widget buildStatusIcon() {
    if (isPreviouslyViewed && isPlaying == false && isViewed == false) {
      return Container(
        margin: EdgeInsets.only(right: DeviceDimens.width * 0.03),
        alignment: Alignment.center,
        child: SizedBox(
          height: 19,
          width: 19,
          child: CircularProgressIndicator(
            color: AppColor.meditationColor,
            strokeAlign: BorderSide.strokeAlignCenter,
            value: progressValue,
            strokeWidth: 2,
            backgroundColor: AppColor.grey.withOpacity(.3),
          ),
        ),
      );
    } else if (isViewed == false && isPreviouslyViewed == false && isPlaying == false) {
      return Container(
        margin: EdgeInsets.only(right: DeviceDimens.width * 0.03),
        alignment: Alignment.center,
        child: Icon(
          Icons.circle_outlined,
          color: AppColor.grey.withOpacity(.3),
          size: 22,
        ),
      );
    } else if (isViewed && isPlaying == false) {
      return Container(
        margin: EdgeInsets.only(right: DeviceDimens.width * 0.03),
        alignment: Alignment.center,
        child: const Icon(
          Icons.check_circle_rounded,
          color: AppColor.green,
          size: 22,
        ),
      );
    } else if (isPlaying) {
      return Container(
        margin: EdgeInsets.only(right: DeviceDimens.width * 0.03),
        alignment: Alignment.center,
        child: const Icon(
          Icons.pause_circle_outline,
          color: AppColor.meditationColor,
          size: 22,
        ),
      );
    }

    return const SizedBox();
  }

}