import 'package:demo_course_video/core/routes/app_routes.dart';
import 'package:demo_course_video/core/utils/dimens.dart';
import 'package:demo_course_video/core/utils/service_locator.dart';
import 'package:demo_course_video/presentation/cubit/home/home_cubit.dart';
import 'package:demo_course_video/presentation/cubit/internet/internet_cubit.dart';
import 'package:demo_course_video/presentation/cubit/video-player/video_player_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import 'presentation/widget/internet_indicator_widget.dart';

void main() async{
  await entryPoint();
}

Future<void> entryPoint() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  setupLocator();
  runApp(MyApp(key: GlobalKey(debugLabel: "MyAppKey"),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceDimens(context);

    return MultiBlocProvider(
      key: GlobalKey(debugLabel: "MultiBlocProviderKey"),
      providers: [
        BlocProvider(key: GlobalKey(debugLabel: "InternetProviderKey"), create: (context) => getIt<InternetCubit>()),
        BlocProvider(key: GlobalKey(debugLabel: "HomeProviderKey"), create: (context) => getIt<HomeCubit>()),
        BlocProvider(key: GlobalKey(debugLabel: "VideoProviderKey"), create: (context) => getIt<VideoPlayerCubit>()),
      ],
      child: Builder(builder: (context) {
        // print(">>build provider: ${_providerKey.toString()}");
        return MediaQuery(
          data:MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: MaterialApp.router(
            // key: _key,
            debugShowCheckedModeBanner: false,
            title: 'Demo Course Video',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            routerConfig: AppRoutes.router,
            builder: (context, child) {
              return Scaffold(
                body: Stack(
                  children: [
                    if (child != null) child,
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        child: const InternetIndicatorWidget(), 
                        onTap: () async {
                          await GetIt.instance.reset();
                          await entryPoint();

                          // restartApp();
                        },
                      ),
                    ),
                  ],
                ),
              ); 
            },
          ),
        );
      }),
    );
  }
}

//~ for native way
// void restartApp() async{
//   const platform = MethodChannel('APP_RESTART_CHANNEL');
//   await platform.invokeMethod('restartApp');
// }
