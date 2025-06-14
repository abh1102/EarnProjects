import 'package:earnprojects/Screens/StudentPlans/Students.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class StudentVerificationDialog extends StatefulWidget {
  const StudentVerificationDialog({super.key});

  @override
  State<StudentVerificationDialog> createState() => _StudentVerificationDialogState();
}

class _StudentVerificationDialogState extends State<StudentVerificationDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController collegeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  String? fileName;
  PlatformFile? uploadedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        uploadedFile = result.files.first;
        fileName = uploadedFile!.name;
      });
    }
  }

  // void _submit() {
  //   if (_formKey.currentState!.validate() && uploadedFile != null) {
  //     Navigator.pop(context, {
  //       'college': collegeController.text,
  //       'city': cityController.text,
  //       'state': stateController.text,
  //       'pincode': pincodeController.text,
  //       'file': uploadedFile,
  //     });
  //   } else if (uploadedFile == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Please upload an ID card or marksheet.")),
  //     );
  //   }
  // }
  void _submit() {
    if (_formKey.currentState!.validate() && uploadedFile != null) {
      Navigator.pop(context); // Close the dialog first

      // Then use a post-frame callback to navigate after dialog is closed
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StudentScreen()),
        );
      });
    } else if (uploadedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload an ID card or marksheet.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      backgroundColor: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth > 500 ? 500.0 : constraints.maxWidth * 0.95;

          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Student Verification',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(collegeController, 'College Name'),
                      _buildTextField(cityController, 'City'),
                      _buildTextField(stateController, 'State'),
                      _buildTextField(pincodeController, 'Pincode', keyboardType: TextInputType.number),
                      const SizedBox(height: 16),
                      const Text("Upload ID Card / Marksheet", style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _pickFile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4D90FE),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("Choose File", style: TextStyle(color: Colors.white)),
                          ),
                          Text(
                            fileName ?? 'No file chosen',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4D90FE),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        validator: (value) => value == null || value.isEmpty ? '$label is required' : null,
      ),
    );
  }
}
