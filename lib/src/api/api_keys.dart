import 'package:get_it/get_it.dart';

/// To get an API key, sign up here:
/// https://home.openweathermap.org/users/sign_up
///
GetIt sl = GetIt.instance;


void setupInjection() {
  sl.registerSingleton<String>('5bdec13c25b820e7e456c4191f4af978', instanceName: 'api_key');
}
