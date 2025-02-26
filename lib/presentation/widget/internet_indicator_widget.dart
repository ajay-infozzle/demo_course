import 'package:demo_course_video/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/internet/internet_cubit.dart';


class InternetIndicatorWidget extends StatelessWidget {
  const InternetIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, bool>(
      builder: (context, hasInternet) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          height: hasInternet ? 30 : 20,
          width: double.infinity,
          color: hasInternet ? AppColor.green :Colors.red,
          child: Center(
            child:  Text(
               hasInternet ? "Internet Connected" :"Oops! No Internet",
              style: const TextStyle(
                color: AppColor.white,
                fontSize: 12
              ),
            ),
          ),
        );
      },
    );
  }
}
