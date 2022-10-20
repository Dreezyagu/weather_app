import 'package:get_it/get_it.dart';
import 'package:weather_app/DI/cubit_module.dart';
import 'package:weather_app/DI/service_module.dart';

final GetIt injector = GetIt.instance;

void init() {
  servicesInit(injector);
  cubitsInit(injector);
}
