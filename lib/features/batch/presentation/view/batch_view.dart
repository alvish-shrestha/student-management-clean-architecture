import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/core/common/snackbar/my_snackbar.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_bloc.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_event.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_state.dart';

class BatchView extends StatelessWidget {
  BatchView({super.key});
  final batchNameController = TextEditingController();

  final _batchViewFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _batchViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: batchNameController,
                decoration: const InputDecoration(labelText: 'Batch Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter batch name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_batchViewFormKey.currentState!.validate()) {
                    final batchName = batchNameController.text.trim();

                    context.read<BatchViewBloc>().add(AddBatch(batchName));

                    // Optionally clear the input field
                    batchNameController.clear();
                  }
                },
                child: Text('Add Batch'),
              ),
              SizedBox(height: 10),

              // SizedBox(height: 10),
              BlocBuilder<BatchViewBloc, BatchViewState>(
                builder: (context, state) {
                  if (state.batches.isEmpty) {
                    return Center(child: Text("No Batches Added Yet"));
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
                        itemCount: state.batches.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.batches[index].batchName),
                            subtitle: Text(state.batches[index].batchId!),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<BatchViewBloc>().add(
                                  DeleteBatch(state.batches[index].batchId!),
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
