import'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Model/AllPlansModel.dart';
import '../PdfController/Pdf.dart';
class StudentsCheckoutScreen extends StatefulWidget {
  final Plan plan;

  const StudentsCheckoutScreen({super.key, required this.plan});

  @override
  State<StudentsCheckoutScreen> createState() => _ProfessionCheckoutScreenState();
}

class _ProfessionCheckoutScreenState extends State<StudentsCheckoutScreen> {
  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();
  int _currentStep = 1;
  bool _acceptedDeclaration = false;
  bool _acceptedTerms = false;
  // Step 1 controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _dobController = TextEditingController();
  final _declarationKey = GlobalKey();
  final _termsKey = GlobalKey();
  // Step 2 controllers
  final _College = TextEditingController();
  final _Course = TextEditingController();
  final _YearOfStudy=TextEditingController();
  final _TechStack = TextEditingController();
  final _portfolio = TextEditingController();
  final _gitHub = TextEditingController();
  final _linkedIn = TextEditingController();

  // Step 3 selections
  String? _selectedAvailability;
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
        title: const Text("Professional Checkout"),
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
          onPressed: (_currentStep == 4 &&
              (!_acceptedDeclaration || !_acceptedTerms))
              ? null
              : () {
            if (_currentStep == 1 && _formKeyStep1.currentState!.validate()) {
              setState(() => _currentStep++);
            } else if (_currentStep == 2 && _formKeyStep2.currentState!.validate()) {
              setState(() => _currentStep++);
            } else if (_currentStep == 3 &&
                (_selectedAvailability != null &&
                    (_selectedProjectType != null || _otherProjectTypeController.text.isNotEmpty) &&
                    _selectedLanguageComfort != null)) {
              setState(() => _currentStep++);
            } else if (_currentStep == 4) {
              // Scroll checks and final submission
              if (!_acceptedDeclaration) {
                _scrollToKey(_declarationKey);
                return;
              }
              if (!_acceptedTerms) {
                _scrollToKey(_termsKey);
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Proceeding to checkout...")),
              );
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
          _buildTextField("Full Name", _nameController),
          _buildTextField("Email", _emailController, keyboard: TextInputType.emailAddress),
          _buildPhoneField(),
          _buildTextField("City", _cityController),
          _buildDateField("Date of Birth", _dobController),
        ],
      ),
    );
  }

  Widget _buildForm2() {
    return Form(
      key: _formKeyStep2,
      child: Column(
        children: [
          _buildTextField("College", _College),
          _buildTextField("Course", _Course),
          _buildTextField("Year Of Study", _YearOfStudy, keyboard: TextInputType.number),
          _buildTextField("Tech Stack", _TechStack,),

          _buildTextField("Portfolio Link", _portfolio, optional: true),
          _buildTextField("GitHub Profile", _gitHub, optional: true),
          _buildTextField("LinkedIn Profile", _linkedIn, optional: true),
        ],
      ),
    );
  }

  Widget _buildForm3() {
    return Column(
      children: [
        _buildDropdown("Availability", _selectedAvailability, ['Part-Time', 'Full-Time', 'Freelance'], (val) => setState(() => _selectedAvailability = val)),
        _buildProjectTypeSelector(),
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
      _buildReviewRow("Full Name", _nameController.text),
      _buildReviewRow("Email", _emailController.text),
      _buildReviewRow("Phone", _phoneController.text),
      _buildReviewRow("City", _cityController.text),
      _buildReviewRow("DOB", _dobController.text),

      _buildReviewRow("College", _College.text),
      _buildReviewRow("Course", _Course.text),
      _buildReviewRow("Tech Stack", _TechStack.text),
      _buildReviewRow("Portfolio", _portfolio.text),
      _buildReviewRow("GitHub", _gitHub.text),
      _buildReviewRow("LinkedIn", _linkedIn.text),
      _buildReviewRow("Availability", _selectedAvailability ?? ''),
      _buildReviewRow("Project Type", _isOtherProjectType ? _otherProjectTypeController.text : (_selectedProjectType ?? '')),
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

  Widget _buildDropdown(String label, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
        validator: (val) => val == null ? 'Select $label' : null,
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