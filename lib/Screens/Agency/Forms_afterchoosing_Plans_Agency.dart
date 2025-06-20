import'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Model/AllPlansModel.dart';
import '../PdfController/Pdf.dart';
class AgencyCheckoutScreen extends StatefulWidget {
  final Plan plan;

  const AgencyCheckoutScreen({super.key, required this.plan});

  @override
  State<AgencyCheckoutScreen> createState() => _ProfessionCheckoutScreenState();
}

class _ProfessionCheckoutScreenState extends State<AgencyCheckoutScreen> {
  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();
  int _currentStep = 1;
  bool _acceptedDeclaration = false;
  bool _acceptedTerms = false;
  final _declarationKey = GlobalKey();
  final _termsKey = GlobalKey();
  // Step 1 controllers
  final _AgencynameController = TextEditingController();
  final _Website = TextEditingController();
  final _Location = TextEditingController();
  final _phoneController = TextEditingController();
  List<String> _allCoreServices = ['Web Development', 'App Development', 'Design', 'Marketing', 'Other'];
  List<String> _selectedCoreServices = [];

  // Step 2 controllers
  final _TeamSize = TextEditingController();
  final _POC = TextEditingController();
  final _POC_Email=TextEditingController();
  final _TechStack = TextEditingController();
final _CoreService=TextEditingController();
  final _linkedIn = TextEditingController();

  // Step 3 selections
  String? _BudgetRange;
  String? CoreServices;
  String? SalesHelp;
  String? CommunicationTools;
  final _PastClients=TextEditingController();
  String? _selectedProjectType;
  String? _selectedLanguageComfort;
  String _selectedFrequency = 'Monthly';
  int _baseProjectCount = 1;
  bool _isOtherProjectType = false;
  final _otherProjectTypeController = TextEditingController();

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final plan = widget.plan;
    final isYearly = _selectedFrequency == 'Yearly';
    final totalPrice = isYearly ? int.parse(plan.price.replaceAll(RegExp(r'\D'), '')) * 12 : int.parse(plan.price.replaceAll(RegExp(r'\D'), ''));
    final projectCount = isYearly ? _baseProjectCount * 12 : _baseProjectCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Agency Checkout"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepIndicator(),
            _buildPlanCard(plan, totalPrice, projectCount),
            const SizedBox(height: 20),
            _getStepContent(),
            const SizedBox(height: 20),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentStep == index + 1 ? Colors.deepPurple : Colors.grey.shade300,
          ),
        );
      }),
    );
  }

  Widget _buildPlanCard(Plan plan, int totalPrice, int projectCount) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(plan.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(plan.tagline, style: const TextStyle(color: Colors.grey)),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Payment Frequency:"),
                DropdownButton<String>(
                  value: _selectedFrequency,
                  items: ['Monthly', 'Yearly'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (val) => setState(() => _selectedFrequency = val!),
                )
              ],
            ),
            const SizedBox(height: 6),
            Text("Projects Included: $projectCount"),
            const SizedBox(height: 6),
            Text("Total Payable: ₹$totalPrice", style: const TextStyle(color: Colors.green, fontSize: 18))
          ],
        ),
      ),
    );
  }

  Widget _getStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildForm1();
      case 2:
        return _buildForm2();
      case 3:
        return _buildForm3();
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReview(),
            const SizedBox(height: 16),
            KeyedSubtree(
              key: _declarationKey,  // 🔹 track this section for scroll
              child: _buildDeclarationCard(),
            ),
            const SizedBox(height: 12),
            KeyedSubtree(
              key: _termsKey,        // 🔹 track this section for scroll
              child: _buildTermsCheckbox(),
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentStep > 1)
          OutlinedButton(
            onPressed: () {
              if (_currentStep == 4) {
                setState(() => _currentStep = 1);
                _scrollToTop();
              } else {
                setState(() => _currentStep--);
              }
            },
            child: Text(_currentStep == 4 ? "Edit Your Details" : "Back"),
          ),
        ElevatedButton(
          onPressed: () {
            if (_currentStep == 1 && _formKeyStep1.currentState!.validate()) {
              setState(() => _currentStep++);
            } else if (_currentStep == 2 && _formKeyStep2.currentState!.validate()) {
              setState(() => _currentStep++);
            } else if (_currentStep == 3 && (_selectedProjectType != null || _otherProjectTypeController.text.isNotEmpty)) {
    setState(() => _currentStep++);

            } else if (_currentStep == 4) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Proceeding to checkout...")));
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          child: Text(_currentStep == 4 ? "Checkout" : "Continue"),
        )
      ],
    );
  }

  Widget _buildForm1() {
    return Form(
      key: _formKeyStep1,
      child: Column(
        children: [
          _buildTextField("Agency Name", _AgencynameController),
          _buildTextField("Website", _Website),
          _buildTextField('Location',_Location),

        ],
      ),
    );
  }

  Widget _buildForm2() {
    return Form(
      key: _formKeyStep2,
      child: Column(
        children: [
          _buildDropdown("Team Size", _TeamSize.text.isEmpty ? null : _TeamSize.text, ['1-4', '4-8', '8-15', '15+'], (val) {
            setState(() {
              _TeamSize.text = val ?? '';
            });
          }),          _buildTextField("POC Name", _POC, keyboard: TextInputType.emailAddress),
          _buildTextField('POC Email',_POC_Email),
           _buildPhoneField(),
          _buildTextField("Tech Stack", _TechStack),
          _buildDropdown(
            "Core Services",
            CoreServices,
            ['Web Development', 'App Development', 'Design', 'Marketing', 'Other'],
                (val) => setState(() => CoreServices = val),
          ),

          // _buildDateField("Core Service", _CoreService),
          _buildTextField("LinkedIn Profile", _linkedIn, optional: true),
        ],
      ),
    );
  }

  Widget _buildForm3() {
    return Column(
      children: [
        _buildTextField("Past Client", _PastClients),
        _buildProjectTypeSelector(),
        _buildDropdown("Communication Tools", CommunicationTools, ['Slack', 'WhatsApp', 'Emails','Microsoft Teams','Other'], (val) => setState(() => CommunicationTools = val)),
        _buildDropdown("Sales Help Required", SalesHelp, ['Yes', 'No'], (val) => setState(() => SalesHelp = val)),
        // _buildDropdown("Budget Range", _BudgetRange, ['< ₹50,000', '₹50,000 - ₹1L', '₹1L - ₹5L', '> ₹5L'], (val) => setState(() => _BudgetRange = val)),
        _buildDropdown("Language Comfort", _selectedLanguageComfort, ['English', 'Hindi', 'Other'], (val) => setState(() => _selectedLanguageComfort = val)),
      ],
    );
  }
  Widget _buildProjectTypeSelector() {
    return Column(
      children: [
        _buildDropdown("Preferred Learning Area", _isOtherProjectType ? null : _selectedProjectType, ['Frontend', 'Backend', 'FullStack', 'UI/UX', 'Devops','Other'], (val) {
          if (val == 'Other') {
            setState(() {
              _isOtherProjectType = true;
              _selectedProjectType = null;
            });
          } else {
            setState(() {
              _isOtherProjectType = false;
              _selectedProjectType = val;
            });
          }
        }),
        if (_isOtherProjectType)
          _buildTextField("Other Project Type", _otherProjectTypeController)
      ],
    );
  }

  Widget _buildReview() {
    List<Widget> rows = [
      _buildReviewRow("Agency Name", _AgencynameController.text),
      _buildReviewRow("Website", _Website.text),
      _buildReviewRow("Location", _Location.text),
      _buildReviewRow("Team Size", _TeamSize.text),
      _buildReviewRow("POC Name", _POC.text),
      _buildReviewRow("Phone", _phoneController.text),
      _buildReviewRow("POC Email", _POC_Email.text),
      _buildReviewRow("Core Services", CoreServices!),
      _buildReviewRow("Past Client", _PastClients.text),
      _buildReviewRow("Communication Tools", CommunicationTools!),
      _buildReviewRow("Sales Help", SalesHelp!),
      _buildReviewRow("LinkedIn", _linkedIn.text),
      _buildReviewRow("Language", _selectedLanguageComfort ?? ''),
    ];

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.deepPurple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("\u{1F4CB} Review Your Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const SizedBox(height: 10),
            ...rows,
          ],
        ),
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text("$label:", style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }
  Widget _buildDeclarationCard() {
    return Card(
      color: Colors.deepPurple.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Declarations", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const SizedBox(height: 8),
            CheckboxListTile(
              value: _acceptedDeclaration,
              onChanged: (val) => setState(() => _acceptedDeclaration = val!),
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text("All the information I have provided is accurate and complete to the best of my knowledge."),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool optional = false, TextInputType keyboard = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (val) {
          if (optional) return null;
          return (val == null || val.isEmpty) ? "Enter $label" : null;
        },
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
        decoration: const InputDecoration(
          labelText: "Phone Number",
          border: OutlineInputBorder(),
        ),
        validator: (val) => val != null && val.length == 10 ? null : "Enter valid 10-digit number",
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            controller.text = "${picked.day}-${picked.month}-${picked.year}";
          }
        },
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items, ValueChanged<String?> onChanged, {TextEditingController? otherController}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) {
              if (val == 'Other') {
                // Clear the selection but keep track that "Other" was chosen
                onChanged(null);
              } else {
                onChanged(val);
              }
            },
            validator: (val) {
              if (items.contains('Other') && value == null && (otherController == null || otherController!.text.isEmpty)) {
                return 'Please select an option or enter custom value';
              }
              return null;
            },
          ),
          if (items.contains('Other') && value == null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextFormField(
                controller: otherController,
                decoration: InputDecoration(
                  labelText: 'Please specify your $label',
                  border: const OutlineInputBorder(),
                ),
                validator: (val) {
                  if (items.contains('Other') && value == null && (val == null || val.isEmpty)) {
                    return 'Please enter your custom $label';
                  }
                  return null;
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return CheckboxListTile(
      value: _acceptedTerms,
      onChanged: (val) => setState(() => _acceptedTerms = val!),
      controlAffinity: ListTileControlAffinity.leading,
      title: Row(
        children: [
          const Text("I agree to the "),
          GestureDetector(
            onTap: () {
              PDFDownloadService.downloadPDF(
                context,
                assetPath: 'assets/Terms-and-Conditions.pdf',
                fileName: 'terms_and_conditions.pdf',

              );
            },
            // onTap: () {
            //   // 🔹 Handle your PDF generation or viewing here
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(content: Text("Opening Terms & Conditions PDF...")),
            //   );
            // },
            child: const Text(
              "Terms and Conditions",
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }


}
