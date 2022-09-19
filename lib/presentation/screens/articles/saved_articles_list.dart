import 'package:blog_app/Blocs/saved_article/saved_article_cubit.dart';
import 'package:blog_app/presentation/routes/app_route_names.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SavedArticleScreen extends StatelessWidget {
  const SavedArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: SolidColors.kindGray,
          title: Text('Saved Article'),
          centerTitle: true,
        ),
        body: BlocBuilder<SavedArticleCubit, SavedArticleState>(
          builder: (context, state) {
            if (state is SavedArticleLoadingState) {
              return Center(
                child: SpinKitDoubleBounce(
                  color: SolidColors.red,
                ),
              );
            }
            if (state is SavedArticleErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                showDialog(
                    context: context, builder: (context) => AlertDialog());
              });
            }
            if (state is SavedArticleLoadedState) {
              print('loaded article');
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: state.savedArticles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: SolidColors.kindGray,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                AppRouteNames.articleDetailScreen,
                                arguments: state.savedArticles[index]);
                          },
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              BlocProvider.of<SavedArticleCubit>(context)
                                  .removeArticle(state.savedArticles[index]);
                            },
                          ),
                          title: Text(
                            state.savedArticles[index].title!,
                            style: TextStyle(color: Colors.white),
                          ),
                          leading: CachedNetworkImage(
                            imageUrl: state.savedArticles[index].coverImageUrl!,
                            placeholder: ((context, url) => SpinKitDoubleBounce(
                                  color: SolidColors.red,
                                )),
                            errorWidget: ((context, url, error) => Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 20,
                                  color: SolidColors.red,
                                )),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ));
  }
}
