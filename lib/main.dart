import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app/app.dart';
import 'package:movies_app/app/cubit/language_cubit.dart';
import 'package:movies_app/features/auth/presentation/auth_scope.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/watchlist/presentation/cubit/history_cubit.dart';
import 'package:movies_app/features/watchlist/presentation/cubit/watch_list_cubit.dart';
import 'package:movies_app/features/watchlist/data/firestore_watch_list_service.dart';
import 'package:movies_app/firebase_options.dart';
import 'package:movies_app/utils/app_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPrefs.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider(
      create: (_) => LanguageCubit(),
      child: AuthScope(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<WatchListCubit>(
              lazy: false,
              create: (context) => WatchListCubit(
                FirestoreWatchListService(),
                userIds: _userIds(context.read<AuthCubit>()),
              ),
            ),
            BlocProvider<HistoryCubit>(
              lazy: false,
              create: (context) => HistoryCubit(
                FirestoreWatchListService('history'),
                userIds: _userIds(context.read<AuthCubit>()),
              ),
            ),
          ],
          child: const MyApp(),
        ),
      ),
    ),
  );
}

Stream<String?> _userIds(AuthCubit authCubit) {
  late StreamController<String?> controller;
  StreamSubscription<AuthState>? subscription;
  controller = StreamController<String?>(
    onListen: () {
      controller.add(authCubit.state.user?.uid);
      subscription = authCubit.stream.listen(
        (state) => controller.add(state.user?.uid),
      );
    },
    onCancel: () => subscription?.cancel(),
  );
  return controller.stream;
}
