import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/articles/article_modle.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// handles hoem functions such fetching articles and fetching user profile and ...

class HomeRepository {
  final CollectionReference _articleRef = FirebaseFirestore.instance
      .collection(FirebaseConstants.articlesCollection);
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection(FirebaseConstants.usersCollection);
// fetch the all articles exists
  Future<RawData> fetchAllPost() async {
    try {
      QuerySnapshot result = await _articleRef.get();
      if (result.docs.isNotEmpty) {
        List<Map<String, dynamic>> rawData =
            result.docs.map((e) => e.data() as Map<String, dynamic>).toList();
        List<Article> articles =
            rawData.map((e) => Article.fromJson(e)).toList();
        return RawData(
            operationResult: OperationResult.success, data: articles);
      } else {
        return RawData(
            operationResult: OperationResult.fail, data: 'sth went wrong');
      }
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

  Future<RawData> fetchSavedArticle(String userUid) async {
    try {
      DocumentSnapshot result = await _userRef.doc(userUid).get();
      if (result.exists) {
        Map<String, dynamic> rawData = result.data() as Map<String, dynamic>;
        List<Article> savedArticle = rawData['savedArticles'];
        return RawData(
            operationResult: OperationResult.success, data: savedArticle);
      } else {
        return RawData(
            operationResult: OperationResult.fail, data: 'sth went wrong');
      }
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }
}
