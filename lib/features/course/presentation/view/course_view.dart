import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/core/common/snackbar/my_snackbar.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_bloc.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_event.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_state.dart';

class CourseView extends StatelessWidget {
  CourseView({super.key});
  final courseNameController = TextEditingController();
  final _courseViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _courseViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: courseNameController,
                decoration: const InputDecoration(labelText: 'Course Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter course name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_courseViewFormKey.currentState!.validate()) {
                    final courseName = courseNameController.text.trim();
                    context.read<CourseViewBloc>().add(AddCourse(courseName));
                    // Optionally clear the input field
                    courseNameController.clear();
                  }
                },
                child: Text('Add Course'),
              ),
              SizedBox(height: 10),
              BlocBuilder<CourseViewBloc, CourseViewState>(
                builder: (context, state) {
                  if (state.courses.isEmpty) {
                    return Center(child: Text("No Courses Added Yet"));
                  } else if (state.isLoading) {
                    return CircularProgressIndicator();
                  } else if (state.error != null) {
                    return showMySnackBar(
                      context: context,
                      message: state.error!,
                      color: Colors.red,
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.courses.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.courses[index].courseName),
                            subtitle: Text(state.courses[index].courseId!),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<CourseViewBloc>().add(
                                  DeleteCourse(state.courses[index].courseId!),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
