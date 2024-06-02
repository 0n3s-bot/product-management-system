
import 'package:pms/app_router/app_router.dart';

class CoreModule {
  late AppRouter appRouter = AppRouter();
  CoreModule._();
  static final instance = CoreModule._();
  AppRouter getAppRouter() {
    return appRouter;
  }
}
