import 'package:beamer/beamer.dart';
import 'package:blog_app/data/models/articles/article_modle.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Article article = ModalRoute.of(context)!.settings.arguments as Article;
    print(article.title);
    return WillPopScope(
        onWillPop: () async {
          await context.beamBack();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: SolidColors.kindGray,
            title: Text(article.title!),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: article.coverImageUrl!,
                placeholder: (context, url) => SpinKitDoubleBounce(
                  color: SolidColors.red,
                ),
                errorWidget: ((context, url, error) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 35,
                          color: SolidColors.red,
                        ),
                      ),
                    )),
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  article.body!,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }
}
