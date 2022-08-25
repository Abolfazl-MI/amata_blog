import 'package:blog_app/gen/assets.gen.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:flutter/material.dart';

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
              UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(color: SolidColors.gray),
                accountEmail: Text('test'),
                accountName: Text('test'),
                currentAccountPicture: CircleAvatar(
                  child: Center(
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              Card(
                color: SolidColors.gray,
                child: ListTile(
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
              )
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
    return Padding(
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
        ));
  }

  ListView _filterBar(List<String> fakeCategories) {
    return ListView.builder(
      itemCount: fakeCategories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: ((context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: 100,
            height: 30,
            child: Card(
              color: SolidColors.darkGrey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  fakeCategories[index],
                  style: TextStyle(color: SolidColors.red),
                )),
              ),
            ),
          ))),
    );
  }
}

class _articleListView extends StatelessWidget {
  const _articleListView({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height * 0.7,
        // color: Colors.green,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 20,
            itemBuilder: ((context, index) {
              return Card(
                color: SolidColors.darkGrey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListTile(
                    title: Text(
                      'this is test text aricles',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text('ti sis fskjdklasjkldj'),
                    trailing: Container(
                        color: Colors.amber,
                        child: Image.asset(Assets.images.amataLogo.path)),
                  ),
                ),
              );
            })));
  }
}
