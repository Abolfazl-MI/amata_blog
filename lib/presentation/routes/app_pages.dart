import 'package:beamer/beamer.dart';
import 'package:blog_app/Blocs/auth_bloc/auth_bloc.dart';
import 'package:blog_app/Blocs/home_bloc/home_bloc.dart';
import 'package:blog_app/Blocs/profile_cubit/profile_cubit.dart';
import 'package:blog_app/Blocs/saved_article/saved_article_cubit.dart';
import 'package:blog_app/Blocs/splash_cubit/splash_cubit.dart';
import 'package:blog_app/presentation/routes/app_route_names.dart';
import 'package:blog_app/presentation/screens/articles/article_detail_screen.dart';
import 'package:blog_app/presentation/screens/articles/saved_articles_list.dart';
import 'package:blog_app/presentation/screens/auth/forgetpassword_screen.dart';
import 'package:blog_app/presentation/screens/splash/splash_screen.dart';
import 'package:blog_app/presentation/screens/auth/complete_userinfo_screen.dart';
import 'package:blog_app/presentation/screens/user_profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/screens.dart';

class AppPages {
  static Map<String, Widget Function(BuildContext)> routes = {
    AppRouteNames.splashScreen: (context) => BlocProvider(
          create: (context) => SplashCubit()..cheackUserLogin(),
          child: SplashScreen(),
        ),
    AppRouteNames.homeScreen: (context) => BlocProvider(
        create: (context) => HomeBloc()..add(LoadAllArticleEvent()),
        child: HomeScreen()),
    AppRouteNames.loginScreen: (context) =>
        BlocProvider(create: (context) => AuthBloc(), child: LoginScreen()),
    AppRouteNames.signUpScreen: (context) =>
        BlocProvider(create: (context) => AuthBloc(), child: SignUpScreen()),
    AppRouteNames.completeInfoScreen: (context) => CompleteUserInformation(),
    AppRouteNames.forgetPassScreen: (context) => ForgetPasswordScreen(),
    AppRouteNames.savedArticleListScreen: (context) => BlocProvider(
        create: (context) => SavedArticleCubit()..getUserSavedArticles(),
        child: const SavedArticleScreen()),
    AppRouteNames.articleDetailScreen: (context) => const ArticleDetailScreen(), 
    AppRouteNames.profileScreen:(context)=> BlocProvider(
      create: (context)=>ProfileCubit()..getUserInformation(),
      child: const ProfileScreen(),
    )
  };
}
