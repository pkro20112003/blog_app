import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:zidiointernshipblogapp/core/theme/app_pallete.dart';
import 'package:zidiointernshipblogapp/feature/blog/presentation/widgets/blog_editor.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddNewBlogPage(),
      );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.done_rounded),
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                DottedBorder(
                    color: AppPallete.borderColor,
                    child: Container(
                        height: 150,
                        width: double.infinity,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.folder_open,
                              size: 50,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Select Image",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ))),
                const SizedBox(height: 15),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        'Technology',
                        'Business',
                        'programming',
                        'Entertainment'
                      ]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Chip(
                                label: Text(e),
                                side: const BorderSide(
                                  color: AppPallete.borderColor,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )),
                BlogEditor(controller: titleController, hintText: 'Blog title'),
                SizedBox(height: 15),
                BlogEditor(
                    controller: contentController, hintText: 'Blog Content'),
              ],
            ),
          ),
        ));
  }
}
