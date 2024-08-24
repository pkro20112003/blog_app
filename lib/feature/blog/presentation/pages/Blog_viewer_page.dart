import 'package:flutter/material.dart';
import 'package:zidiointernshipblogapp/core/utils/calculate_reading_time.dart';
import 'package:zidiointernshipblogapp/core/utils/format_date.dart';
import 'package:zidiointernshipblogapp/feature/blog/domain/entities/blog.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewerPage(
          blog: blog,
        ),
      );
  final Blog blog;
  const BlogViewerPage({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'By ${blog.posterName}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                      '${formatDateBydMMMYYYY(blog.updatedAt)}. ${calculateReadingTime(blog.content)} min',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(blog.imageUrl),
                  ),
                  const SizedBox(height: 20),
                  Text(blog.content, style: TextStyle(fontSize: 16))
                ],
              ),
            ),
          ),
        ));
  }
}