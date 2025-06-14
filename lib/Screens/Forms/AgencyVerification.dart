import 'package:earnprojects/Screens/Agency/Agency.dart';
import 'package:flutter/material.dart';
import 'package:earnprojects/Screens/Agency/Agency.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AgencyVerificationDialog extends StatefulWidget {
  const AgencyVerificationDialog({super.key});

  @override
  State<AgencyVerificationDialog> createState() => _AgencyVerificationDialogState();
}

class _AgencyVerificationDialogState extends State<AgencyVerificationDialog> {
  final _formKey = GlobalKey<FormState>();

  final _domainController = TextEditingController();
  final _serviceController = TextEditingController();
  final _addressController = TextEditingController();
  final _stateController = TextEditingController();
  final _pinController = TextEditingController();

  String? selectedEmployeeCount;
  final List<String> employeeCounts = ['1-10', '11-50', '51-200', '200+'];

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
                  "Agency / Company Verification",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _buildTextField("Company Domain *", _domainController),
                const SizedBox(height: 16),

                _buildTextField(
                   "Services Offered *",
                  _serviceController,
                  hintText: "e.g. Web development, IT services",
                ),
                const SizedBox(height: 16),

                _buildTextField("Full Address *", _addressController),
                const SizedBox(height: 16),

                _buildTextField("State *", _stateController),
                const SizedBox(height: 16),

                _buildTextField("PIN Code *", _pinController, keyboardType: TextInputType.number),
                const SizedBox(height: 16),

                _buildDropdownField(
                  label: "No. of Employees *",
                  value: selectedEmployeeCount,
                  items: employeeCounts,
                  onChanged: (val) => setState(() => selectedEmployeeCount = val),
                  validator: (val) => val == null ? 'Please select employee count' : null,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AgencyScreen()),
                          );
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D90FE),
                    ),
                    child: const Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        String? Function(String?)? validator,
        String? hintText,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator ?? (value) {
        return value == null || value.isEmpty ? "Required" : null;
      },
      decoration: InputDecoration(
        labelText: label,
        helperText: hintText, // replaces hintText for better visibility
        border: const OutlineInputBorder(),
      ),
    );
  }


  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

// Dummy screen for navigation

