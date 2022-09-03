import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/articles/article_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRepository {
  final CollectionReference _articleRef =
      FirebaseFirestore.instance.collection(DatabaseConstants.usersCollection);
  // handles hoem functions such fetching articles and fetching user profile and ...
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
}
