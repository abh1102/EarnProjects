import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProfessionalVerificationDialog extends StatefulWidget {
  const ProfessionalVerificationDialog({super.key});

  @override
  State<ProfessionalVerificationDialog> createState() => _ProfessionalVerificationDialogState();
}

class _ProfessionalVerificationDialogState extends State<ProfessionalVerificationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _employerController = TextEditingController();
  final _designationController = TextEditingController();
  final _emailController = TextEditingController();
  final _experienceController = TextEditingController();
  final _linkedinController = TextEditingController();
  String? _employmentType;
  PlatformFile? _selectedFile;

  final List<String> _employmentTypes = ['Full-time', 'Part-time', 'Freelancer', 'Contract'];

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please upload a document")));
        return;
      }

      Navigator.pop(context, {
        'employer': _employerController.text,
        'designation': _designationController.text,
        'email': _emailController.text,
        'employmentType': _employmentType,
        'experience': _experienceController.text,
        'file': _selectedFile,
        'linkedin': _linkedinController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Professional Verification",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _buildTextField("Current Employer Name", _employerController),
                const SizedBox(height: 16),

                _buildTextField("Designation / Job Title", _designationController),
                const SizedBox(height: 16),

                _buildTextField(
                  "Work Email (Company Email)",
                  _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Required";
                    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                    return emailRegex.hasMatch(value) ? null : "Enter valid email";
                  },
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Employment Type",
                    border: OutlineInputBorder(),
                  ),
                  value: _employmentType,
                  items: _employmentTypes
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (val) => setState(() => _employmentType = val),
                  validator: (value) => value == null ? 'Please select employment type' : null,
                ),
                const SizedBox(height: 16),

                _buildTextField(
                  "Years of Experience",
                  _experienceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Required";
                    return int.tryParse(value) != null ? null : "Enter valid number";
                  },
                ),
                const SizedBox(height: 16),

                OutlinedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.upload_file),
                  label: Text(_selectedFile?.name ?? "Choose File"),
                ),
                const SizedBox(height: 8),

                _buildTextField(
                  "LinkedIn Profile (Optional)",
                  _linkedinController,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final urlPattern = r'^https?:\/\/(www\.)?linkedin\.com\/.*$';
                      if (!RegExp(urlPattern).hasMatch(value)) return "Enter valid LinkedIn URL";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D90FE),
                    ),
                    child: const Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator ?? (value) => (value == null || value.isEmpty) ? "Required" : null,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
