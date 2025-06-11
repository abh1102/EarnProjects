import 'package:flutter/material.dart';
class AgencyVerificationDialog extends StatefulWidget {
  const AgencyVerificationDialog({super.key});

  @override
  State<AgencyVerificationDialog> createState() => _AgencyVerificationDialogState();
}

class _AgencyVerificationDialogState extends State<AgencyVerificationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _domainController = TextEditingController();
  final _addressController = TextEditingController();
  final _stateController = TextEditingController();
  final _pinController = TextEditingController();

  String? selectedService;
  String? selectedEmployeeCount;

  final List<String> services = ['IT Services', 'Marketing', 'Design', 'Consulting'];
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

                _boxedField(_buildTextField("Company Domain *", _domainController, hint: "e.g. www.example.com")),
                const SizedBox(height: 16),

                _boxedField(
                  DropdownButtonFormField<String>(
                    value: selectedService,
                    items: services.map((service) {
                      return DropdownMenuItem(value: service, child: Text(service));
                    }).toList(),
                    onChanged: (value) => setState(() => selectedService = value),
                    validator: (value) => value == null ? 'Please select service' : null,
                    decoration: const InputDecoration(
                      labelText: "Services Offered *",
                      border:InputBorder.none,
                      contentPadding: EdgeInsets.zero
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                _boxedField(_buildTextField("Full Address *", _addressController)),
                const SizedBox(height: 16),

                _boxedField(_buildTextField("State *", _stateController)),
                const SizedBox(height: 16),

                _boxedField(_buildTextField("PIN Code *", _pinController, keyboardType: TextInputType.number)),
                const SizedBox(height: 16),

                _boxedField(
                  DropdownButtonFormField<String>(
                    value: selectedEmployeeCount,
                    items: employeeCounts.map((count) {
                      return DropdownMenuItem(value: count, child: Text(count));
                    }).toList(),
                    onChanged: (value) => setState(() => selectedEmployeeCount = value),
                    validator: (value) => value == null ? 'Please select employee count' : null,
                    decoration: const InputDecoration(
                      labelText: "No. of Employees *",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop({
                          'domain': _domainController.text,
                          'service': selectedService,
                          'address': _addressController.text,
                          'state': _stateController.text,
                          'pin': _pinController.text,
                          'employeeCount': selectedEmployeeCount,
                        });
                      }
                    },
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

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        String? hint,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) => (value == null || value.isEmpty) ? "Required" : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: InputBorder.none, // ← removes the inner border
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _boxedField(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

