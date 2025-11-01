import 'package:core/core.dart';

final locator = GetIt.instance;
void setupLocatorCore() {
  locator.registerSingleton<Htreq>(Htreq());
  locator.registerSingleton<Repositories>(Repositories(locator<Htreq>()));
  locator<Htreq>().setBaseUrl(Endpoints.baseUrl);
}
