import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zidiointernshipblogapp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:zidiointernshipblogapp/core/common/widget/loader.dart';
import 'package:zidiointernshipblogapp/core/theme/app_pallete.dart';
import 'package:zidiointernshipblogapp/core/utils/Show_snackbar.dart';
import 'package:zidiointernshipblogapp/core/utils/pick_image.dart';
import 'package:zidiointernshipblogapp/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:zidiointernshipblogapp/feature/blog/presentation/pages/blog_page.dart';
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
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
            BlogUpload(
                posterId: posterId,
                title: titleController.text.trim(),
                content: contentController.text.trim(),
                image: image!,
                topics: selectedTopics),
          );
    }
  }

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
              onPressed: () {
                uploadBlog();
              },
              icon: const Icon(Icons.done_rounded),
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailures) {
              ShowSnackBar(context, state.error);
            } else if (state is BlogUploadSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                BlogPage.route(),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      image != null
                          ? GestureDetector(
                              onTap: selectImage,
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  )),
                            )
                          : GestureDetector(
                              onTap: () {
                                selectImage();
                              },
                              child: DottedBorder(
                                  color: AppPallete.borderColor,
                                  child: Container(
                                      height: 150,
                                      width: double.infinity,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                            ),
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
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedTopics.contains(e)) {
                                          selectedTopics.remove(e);
                                        } else {
                                          selectedTopics.add(e);
                                        }

                                        setState(() {});
                                      },
                                      child: Chip(
                                        color: selectedTopics.contains(e)
                                            ? const WidgetStatePropertyAll(
                                                AppPallete.gradient1)
                                            : null,
                                        label: Text(e),
                                        side: const BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          )),
                      BlogEditor(
                          controller: titleController, hintText: 'Blog title'),
                      SizedBox(height: 15),
                      BlogEditor(
                          controller: contentController,
                          hintText: 'Blog Content'),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
