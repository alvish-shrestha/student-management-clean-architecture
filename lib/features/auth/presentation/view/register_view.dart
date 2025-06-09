import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:student_management/core/common/snackbar/my_snackbar.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_bloc.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_state.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_bloc.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_state.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: 'kiran');
  final _lnameController = TextEditingController(text: 'rana');
  final _phoneController = TextEditingController(text: '123456789');
  final _usernameController = TextEditingController(text: 'kiran');
  final _passwordController = TextEditingController(text: 'kiran123');

  final ValueNotifier<BatchEntity?> _selectedBatch = ValueNotifier(null);
  final ValueNotifier<List<CourseEntity>> _selectedCourses = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  // Profile Image Picker
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.grey[300],
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CircleAvatar(
                        backgroundImage: const AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                    ),
                  ),
                  _gap,
                  // First Name
                  TextFormField(
                    controller: _fnameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter first name'
                        : null,
                  ),
                  _gap,
                  // Last Name
                  TextFormField(
                    controller: _lnameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter last name'
                        : null,
                  ),
                  _gap,
                  // Phone Number
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone No'),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter phoneNo'
                        : null,
                  ),
                  _gap,
                  // Batch Dropdown
                  BlocBuilder<BatchViewBloc, BatchViewState>(
                    builder: (context, state) {
                      return ValueListenableBuilder<BatchEntity?>(
                        valueListenable: _selectedBatch,
                        builder: (context, selectedBatch, _) {
                          return DropdownButtonFormField<BatchEntity>(
                            value: selectedBatch,
                            items: state.batches
                                .map(
                                  (batch) => DropdownMenuItem(
                                    value: batch,
                                    child: Text(batch.batchName),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) => _selectedBatch.value = value,
                            decoration: const InputDecoration(
                              labelText: 'Select Batch',
                            ),
                            validator: (value) =>
                                (value == null) ? 'Please select batch' : null,
                          );
                        },
                      );
                    },
                  ),
                  _gap,
                  // Course MultiSelect
                  BlocBuilder<CourseViewBloc, CourseViewState>(
                    builder: (context, courseState) {
                      if (courseState.isLoading) {
                        return const CircularProgressIndicator();
                      }

                      return ValueListenableBuilder<List<CourseEntity>>(
                        valueListenable: _selectedCourses,
                        builder: (context, selectedCourses, _) {
                          return MultiSelectDialogField<CourseEntity>(
                            title: const Text('Select course'),
                            items: courseState.courses
                                .map(
                                  (course) => MultiSelectItem(
                                    course,
                                    course.courseName,
                                  ),
                                )
                                .toList(),
                            initialValue: selectedCourses,
                            listType: MultiSelectListType.CHIP,
                            buttonText: const Text(
                              'Select course',
                              style: TextStyle(color: Colors.black),
                            ),
                            buttonIcon: const Icon(Icons.search),
                            onConfirm: (values) => _selectedCourses.value =
                                List<CourseEntity>.from(values),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black87),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                ? 'Please select courses'
                                : null,
                          );
                        },
                      );
                    },
                  ),
                  _gap,
                  // Username
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter username'
                        : null,
                  ),
                  _gap,
                  // Password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter password'
                        : null,
                  ),
                  _gap,
                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          // Access form values
                          final batch = _selectedBatch.value;
                          final courses = _selectedCourses.value;
                          final username = _usernameController.text;

                          debugPrint("Batch: ${batch?.batchName}");
                          debugPrint(
                            "Courses: ${courses.map((e) => e.courseName).toList()}",
                          );
                          debugPrint("Username: $username");

                          // Use your custom snackbar function
                          showMySnackBar(
                            context: context,
                            message: 'User created',
                            color: Colors.green, // optional
                          );
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
