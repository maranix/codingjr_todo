import 'package:flutter/material.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({
    super.key,
    required this.onAdd,
  });

  final Function(String title, String note) onAdd;

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _titleController;
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();

    // Initializing form key and text controllers in the state
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    // Disposing text controllers and form key when the state is disposed
    _titleController.dispose();
    _noteController.dispose();
    _formKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Add Todo'),
      contentPadding: const EdgeInsets.all(14),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title cannot be empty';
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Title'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Note cannot be empty';
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Note'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Validating the form and calling onAdd if validation passes
                if (_formKey.currentState?.validate() ?? false) {
                  widget.onAdd(
                    _titleController.text.trim(),
                    _noteController.text.trim(),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ],
    );
  }
}
