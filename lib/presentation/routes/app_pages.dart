import 'package:beamer/beamer.dart';
import 'package:blog_app/logic/auth_bloc/auth_bloc.dart';
import 'package:blog_app/presentation/routes/app_route_names.dart';
import 'package:blog_app/presentation/screens/splash/splash_screen.dart';
import 'package:blog_app/presentation/screens/userInfo/complete_userinfo_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/screens.dart';

class AppPages {
  static final routerDelagate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        // AppRouteNames.splashScreen: (context, state, data) => SplashScreen(),
        AppRouteNames.homeScreen: (context, state, data) => HomeScreen(),
        AppRouteNames.loginScree: (context, state, data) =>
            BlocProvider(create: (context) => AuthBloc(), child: LoginScreen()),
        '/': (context, state, data) => BlocProvider(
            create: (context) => AuthBloc(), child: SignUpScreen()),
        AppRouteNames.completeInfoScreen:(context,state,data)=>CompleteUserInformation()
      },
    ),
  );
}
