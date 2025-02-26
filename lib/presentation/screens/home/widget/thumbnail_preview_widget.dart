import 'package:demo_course_video/core/utils/colors.dart';
import 'package:demo_course_video/core/utils/dimens.dart';
import 'package:flutter/material.dart';

class ThumbnailPreviewWidget extends StatelessWidget {
  const ThumbnailPreviewWidget({super.key, required this.title, required this.thumbnailUrl, required this.onPlay});
  final String title;
  final String thumbnailUrl;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceDimens.width,
      color: AppColor.black,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Image.network(
                thumbnailUrl,
                fit: BoxFit.cover,
              )
            ),
        
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: onPlay,
                  child: Icon(
                    Icons.play_circle_outline,
                    color: AppColor.black,
                    size: DeviceDimens.height*0.075,
                  ),
                ),
              ),
            ),
        
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Container(
            //       margin: EdgeInsets.symmetric(horizontal: DeviceDimens.width*0.03, vertical: DeviceDimens.width*0.02),
            //       padding: EdgeInsets.symmetric(horizontal: DeviceDimens.width*0.01),
            //       decoration: BoxDecoration(
            //         color: AppColor.white.withOpacity(.4),
            //         borderRadius: BorderRadius.circular(5)
            //       ),
            //       child: Text(
            //         title,
            //         style: const TextStyle(
            //           color: AppColor.black,
            //         ),
            //         maxLines: 1,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}