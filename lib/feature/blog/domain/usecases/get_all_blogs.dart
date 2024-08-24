import 'package:fpdart/fpdart.dart';
import 'package:zidiointernshipblogapp/core/error/failures.dart';
import 'package:zidiointernshipblogapp/core/usecase/usecase.dart';
import 'package:zidiointernshipblogapp/feature/blog/domain/entities/blog.dart';
import 'package:zidiointernshipblogapp/feature/blog/domain/repository/blog_repository.dart';

class GetAllBlogs implements Usecase<List<Blog>, Noparams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failures, List<Blog>>> call(Noparams params) async {
    return await blogRepository.getAllBlogs();
  }
}
