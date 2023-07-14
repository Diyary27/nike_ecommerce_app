import 'package:nike_ecommerce_app/common/http_client.dart';
import 'package:nike_ecommerce_app/data/comment.dart';
import 'package:nike_ecommerce_app/data/source/comment_data_source.dart';

final commentRepository =
    CommentRepository(CommentRemoteDataSource(httpClient));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll(int productId);
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository(this.dataSource);

  @override
  Future<List<CommentEntity>> getAll(int productId) =>
      dataSource.getAll(productId: productId);
}
