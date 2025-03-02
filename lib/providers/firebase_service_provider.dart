import 'package:bond/app/default_firebase_options.dart';
import 'package:bond/features/update_app/models/update_app_default_value.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:one_studio_core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FirebaseServiceProvider extends ServiceProvider {
  @override
  Future<void> register(GetIt it) async {
    final packageInfo = await PackageInfo.fromPlatform();
    it.registerSingleton(packageInfo);

    final firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    it.registerSingleton(firebaseApp);

    it.registerLazySingleton(
      () => FirebaseRemoteConfig.instance
        ..setConfigSettings(
          RemoteConfigSettings(
            fetchTimeout: UpdateAppDefaultValue.fetchTimeout,
            minimumFetchInterval: UpdateAppDefaultValue.minimumFetchInterval,
          ),
        )
        ..setDefaults(UpdateAppDefaultValue.defaultParameters),
    );
  }
}
