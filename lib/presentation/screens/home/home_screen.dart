import 'package:beamer/beamer.dart';
import 'package:blog_app/Blocs/home_bloc/home_bloc.dart';
import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/repositories/auth_repository.dart';
import 'package:blog_app/data/repositories/user_repository.dart';
import 'package:blog_app/gen/assets.gen.dart';
import 'package:blog_app/presentation/routes/app_route_names.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Amata Blog'),
          // automaticallyImplyLeading: false,
          backgroundColor: SolidColors.darkGrey,
        ),
        drawer: Drawer(
          backgroundColor: SolidColors.darkGrey,
          child: Column(
            children: [
              BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                /* UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(color: SolidColors.gray),
                  accountEmail: Text('test'),
                  accountName: Text('test'),
                  currentAccountPicture: CircleAvatar(
                    child: Center(
                      child: Icon(Icons.person),
                    ),
                  ),
                ), */
                if (state is HomeLoadedState) {
                  print(state.amataUser?.profileUrl);
                  return UserAccountsDrawerHeader(
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(color: SolidColors.gray),
                      accountEmail: Text(state.amataUser!.emailAddrress!),
                      accountName: state.amataUser!.userName != null
                          ? Text(state.amataUser!.userName!)
                          : null,
                      currentAccountPicture: state.amataUser?.profileUrl != null
                          ? CachedNetworkImage(
                              imageUrl: state.amataUser!.profileUrl!,
                              placeholder: (context, url) =>
                                  SpinKitDoubleBounce(
                                color: SolidColors.red,
                              ),
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                backgroundColor: SolidColors.kindGray,
                                child: Center(
                                  child: Icon(Icons.person_outline_outlined),
                                ),
                              ),
                              imageBuilder: ((context, imageProvider) =>
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                        )),
                                  )),
                            )
                          : Icon(Icons.person));
                }
                return Text('');
              }),
              // UserAccountsDrawerHeader(
              //   margin: EdgeInsets.zero,
              //   decoration: BoxDecoration(color: SolidColors.gray),
              //   accountEmail: Text('test'),
              //   accountName: Text('test'),
              //   currentAccountPicture: CircleAvatar(
              //     child: Center(
              //       child: Icon(Icons.person),
              //     ),
              //   ),
              // ),
              Card(
                color: SolidColors.gray,
                child: ListTile(
                  onTap: () {
                    context.beamToNamed(AppRouteNames.savedArticleListScreen);
                  },
                  leading: Icon(
                    Icons.save_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Saved Articles',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Card(
                color: SolidColors.gray,
                child: ListTile(
                  leading: Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Card(
                color: SolidColors.gray,
                child: ListTile(
                  leading: Icon(
                    Icons.article_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    'My Articles',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  AuthRepository().logOut().then((value) {
                    if (value.operationResult == OperationResult.success) {
                      context
                          .beamToReplacementNamed(AppRouteNames.signUpScreen);
                    }
                  });
                },
                child: Card(
                  color: SolidColors.gray,
                  child: ListTile(
                    leading: Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: _bultBody(context));
  }

  _bultBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<String> fakeCategories = [
      'all',
      'It',
      'Technology',
      'comercial',
      'education'
    ];
    return BlocConsumer<HomeBloc, HomeState>(
      listener: ((context, state) async {
        if (state is HomeArticleSavedState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Article saved to your reading list')));
          });
        }
        if (state is ArticleSaveErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${state.error}}')));
          });
        }
      }),
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Center(
            child: SpinKitDoubleBounce(
              color: SolidColors.red,
            ),
          );
        }

        if (state is HomeLoadedState) {
          return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: state.articles.length.toDouble(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text('Your Lists',
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  Container(
                    width: width,
                    height: height * 0.8,
                    // color: Colors.green,
                    child: ListView.builder(
                      itemCount: state.articles.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          child: SizedBox(
                            width: width,
                            height: 120,
                            child: Card(
                              color: SolidColors.kindGray,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          state.articles[index].title!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  // UserRepository().updateCredentials(user: await FirebaseAuth.instance.currentUser!, userName: 'abolfazl', profileImage: 'https://files.virgool.io/upload/users/10548/posts/hagwlg7mwqq4/nsve5akdotnh.jpeg',)
                                                  BlocProvider.of<HomeBloc>(
                                                          context)
                                                      .add(SaveArticleEvent(
                                                    state.articles[index],
                                                  ));
                                                },
                                                icon: Icon(
                                                  Icons.post_add_outlined,
                                                  color: Colors.white,
                                                )),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.share_outlined,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            SpinKitDoubleBounce(
                                          color: SolidColors.red,
                                        ),
                                        imageUrl: state
                                            .articles[index].coverImageUrl!,
                                        errorWidget: ((context, url, error) =>
                                            Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              size: 20,
                                              color: SolidColors.red,
                                            )),
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            )),
                                          );
                                        },
                                      ),
                                      // child: Image.network(
                                      //     state.articles[index].coverImageUrl!),
                                    )
                                  ]),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ));
        }
        if (state is HomeErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                content: Text(state.error),
              ),
            );
          });
        }
        return Container();
      },
    );
  }

  /* Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Your Lists', style: Theme.of(context).textTheme.headline2),
              Container(
                width: width,
                height: 50,
                // color: Colors.red,
                child: _filterBar(fakeCategories),
              ),
              _articleListView(width: width, height: height)
            ],
          )), */

}

// class _articleListView extends StatelessWidget {
//   const _articleListView({
//     Key? key,
//     required this.width,
//     required this.height,
//   }) : super(key: key);

//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
