import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';
import 'package:zidiointernshipblogapp/core/error/Exception.dart';
import 'package:zidiointernshipblogapp/core/error/failures.dart';
import 'package:zidiointernshipblogapp/feature/blog/data/datasources/blog_remote_data_source.dart';
import 'package:zidiointernshipblogapp/feature/blog/data/model/blog_model.dart';
import 'package:zidiointernshipblogapp/feature/blog/domain/entities/blog.dart';
import 'package:zidiointernshipblogapp/feature/blog/domain/repository/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failures, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );
      blogModel = blogModel.copyWith(
        imageUrl: imageUrl,
      );
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
