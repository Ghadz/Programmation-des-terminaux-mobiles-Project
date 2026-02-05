import 'package:flutter/material.dart';
import 'package:spacex/core/services/music_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/routing/app_router.dart';
import 'package:spacex/core/routing/routes.dart';
import 'package:spacex/core/utils/dependency_injection.dart';
import 'package:spacex/features/home/logic/get_profile_data/get_profile_data_cubit.dart';

class SpacexApp extends StatelessWidget {
  final AppRouter appRouter;

  const SpacexApp({
    required this.appRouter,
    super.key,
  });

  // @override
  // State<SpacexApp> createState() => _SpacexAppState();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<GetProfileDataCubit>(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'TR',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}

// class _SpacexAppState extends State<SpacexApp> {
//   late MusicService _musicService;
//
//   @override
//   void initState() {
//     super.initState();
//     _musicService = MusicService();
//     _startBackgroundMusic();
//   }
//
//   void _startBackgroundMusic() {
//     // YouTube URL: https://www.youtube.com/watch?v=kpz8lpoLvrA
//     // ⚠️ IMPORTANT: YouTube doesn't allow direct MP3 extraction
//     // Solution options:
//     // 1. Download the audio as MP3 from youtube-dl
//     // 2. Host it on your own server
//     // 3. Use a music hosting service like Firebase Storage
//
//     // For now, use a placeholder URL (replace with actual audio URL)
//     String audioUrl = 'assets/Audios/audiobgmusic.mp3';
//
//     _musicService.playBackgroundMusic(
//       audioPath: audioUrl,
//       volume: 0.3, // 30% volume
//     );
//   }
//
//   @override
//   void dispose() {
//     _musicService.stopMusic();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: Colors.black,
//       )
//     );
//   }
// }