import 'package:beamer/beamer.dart';
import 'package:blog_app/Blocs/auth_bloc/auth_bloc.dart';
import 'package:blog_app/Blocs/home_bloc/home_bloc.dart';
import 'package:blog_app/Blocs/splash_cubit/splash_cubit.dart';
import 'package:blog_app/presentation/routes/app_route_names.dart';
import 'package:blog_app/presentation/screens/auth/forgetpassword_screen.dart';
import 'package:blog_app/presentation/screens/splash/splash_screen.dart';
import 'package:blog_app/presentation/screens/auth/complete_userinfo_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/screens.dart';

class AppPages {
  static final routerDelagate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        AppRouteNames.splashScreen: (context, state, data) => BlocProvider(
            create: (context) => SplashCubit()..cheackUserLogin(),
            child: SplashScreen()),
        AppRouteNames.homeScreen: (context, state, data) =>
            BlocProvider(create: (context) => HomeBloc()..add(LoadAllArticleEvent()), child: HomeScreen()),
        AppRouteNames.loginScree: (context, state, data) =>
            BlocProvider(create: (context) => AuthBloc(), child: LoginScreen()),
        AppRouteNames.signUpScreen: (context, state, data) => BlocProvider(
            create: (context) => AuthBloc(), child: SignUpScreen()),
        AppRouteNames.completeInfoScreen: (context, state, data) =>
            CompleteUserInformation(),
        AppRouteNames.forgetPassScreen: (context, state, data) =>
            ForgetPasswordScreen()
      },
    ),
  );
}
