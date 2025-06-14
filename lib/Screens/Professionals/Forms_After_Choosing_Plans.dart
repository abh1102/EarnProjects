import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Model/AllPlansModel.dart';

//
// class ProfessionCheckoutScreen extends StatefulWidget {
//   final Plan plan;
//
//   const ProfessionCheckoutScreen({super.key, required this.plan});
//
//   @override
//   State<ProfessionCheckoutScreen> createState() => _AgencyVerificationScreenState();
// }
//
// class _AgencyVerificationScreenState extends State<ProfessionCheckoutScreen> {
//   final _formKeyStep1 = GlobalKey<FormState>();
//   final _formKeyStep2 = GlobalKey<FormState>();
//
//   final ScrollController _scrollController = ScrollController();
//   int _currentStep = 1;
//
//   // Step 1 controllers
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _cityController = TextEditingController();
//   final _dobController = TextEditingController();
//
//   // Step 2 controllers
//   // final _domainController = TextEditingController();
//   // final _websiteController = TextEditingController();
//   // final _descriptionController = TextEditingController();
//   final _techStackController=TextEditingController();
//   final _YearsOfExperience=TextEditingController();
//   final _ProjectsDescriptions=TextEditingController();
//   final _Portfolio=TextEditingController();
//   final _GitHub=TextEditingController();
//   final _LinkedIn=TextEditingController();
//   String _selectedFrequency = 'Monthly';
//   int _baseProjectCount = 1;
// //Step3controller
//   String? _selectedAvailability;
//   String? _selectedProjectType;
//   String? _selectedLanguageComfort;
//   void _scrollToTop() {
//     _scrollController.animateTo(
//       0,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final plan = widget.plan;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Proffessional View")),
//       body: SingleChildScrollView(
//         controller: _scrollController,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildStepIndicator(),
//
//             _buildPlanCard(plan),
//
//             const SizedBox(height: 20),
//
//             if (_currentStep == 1)
//               _buildStep1Form()
//             else if (_currentStep == 2)
//               _buildStep2Form()
//             else if (_currentStep == 3)
//                 _buildStep3Form()
//               else
//                 _buildStep3Review(),
//
//             const SizedBox(height: 20),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (_currentStep > 1)
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _currentStep--;
//                         _scrollToTop();
//                       });
//                     },
//                     child: const Text("Previous"),
//                   ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_currentStep == 1 && _formKeyStep1.currentState!.validate()) {
//                       setState(() {
//                         _currentStep = 2;
//                         _scrollToTop();
//                       });
//                     } else if (_currentStep == 2 && _formKeyStep2.currentState!.validate()) {
//                       setState(() {
//                         _currentStep = 3;
//                         _scrollToTop();
//                       });
//                     }
//                     else if (_currentStep == 3 && _selectedAvailability != null && _selectedProjectType != null && _selectedLanguageComfort != null){
//                       setState(() {
//                         _currentStep = 4;
//                         _scrollToTop();
//                       });
//                     }
//
//                     else if (_currentStep == 4) {
//
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Proceeding to checkout...")),
//                       );
//                     }
//                   },
//     child: Text(
//     _currentStep == 1
//     ? "Proceed"
//         : _currentStep == 2
//     ? "Proceed"
//         : _currentStep == 3
//     ? "Review your Details"
//         : "Checkout"
//     ),
//                 )],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStepIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(3, (index) {
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: _currentStep == index + 1 ? Colors.purple : Colors.grey.shade300,
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildPlanCard(Plan plan) {
//     final isYearly = _selectedFrequency == 'Yearly';
//     final numberOfProjects = isYearly ? _baseProjectCount * 12 : _baseProjectCount;
//
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(plan.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             Text(plan.tagline, style: const TextStyle(color: Colors.grey)),
//             const SizedBox(height: 8),
//             Text(
//               "Project Worth: ₹${isYearly ? int.parse(plan.price.replaceAll(RegExp(r'[^\d]'), '')) * 12 : plan.price}",
//               style: const TextStyle(fontSize: 16),
//             ),            const SizedBox(height: 4),
//             Text("No of Projects: $numberOfProjects"),
//             const SizedBox(height: 4),
//
//             /// Frequency Dropdown
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Payment frequency:"),
//                 DropdownButton<String>(
//                   value: _selectedFrequency,
//                   items: ['Monthly', 'Yearly'].map((option) {
//                     return DropdownMenuItem(value: option, child: Text(option));
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedFrequency = value!;
//                     });
//                   },
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Total Payable Amount:", style: TextStyle(fontSize: 16)),
//                 Text(
//                   isYearly
//                       ? "₹${int.parse(plan.price.replaceAll(RegExp(r'[^\d]'), '')) * 12}/-"
//                       : "₹${plan.price}/-",
//                   style: const TextStyle(color: Colors.green, fontSize: 18),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildStep1Form() {
//     return Form(
//       key: _formKeyStep1,
//       child: Column(
//         children: [
//           _buildTextField(label: "Full Name", controller: _nameController),
//           _buildTextField(label: "Email", controller: _emailController),
//           _buildPhoneField(),
//           _buildTextField(label: "City", controller: _cityController),
//           _buildDatePickerField(label: "DOB", controller: _dobController),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStep2Form() {
//     return Form(
//       key: _formKeyStep2,
//       child: Column(
//         children: [
//           _buildTextField(label: "Tech Stack", controller: _techStackController),
//           _buildTextField(label: "Years Of Experience", controller: _YearsOfExperience),
//           _buildTextField(label: "Project Description", controller: _ProjectsDescriptions, maxLines: 4),
//           _buildTextField(label: "Portfolio Link", controller: _Portfolio,isOptional:true),
//           _buildTextField(label: "Github Profile", controller: _GitHub,isOptional:true),
//           _buildTextField(label: "LinkedIn Profile", controller: _LinkedIn,isOptional:true),
//           // _buildTextField(label: "Tech Stack", controller: _techStackController),
//         ],
//       ),
//     );
//   }
//   Widget _buildStep3Form() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildDropdownField(
//           label: 'Availability',
//           value: _selectedAvailability,
//           items: ['Part-Time', 'Full-Time', 'Freelance'],
//           onChanged: (val) => setState(() => _selectedAvailability = val),
//         ),
//         _buildDropdownField(
//           label: 'Preferred Project Type',
//           value: _selectedProjectType,
//           items: ['Web Development', 'Mobile Apps', 'AI/ML', 'Design'],
//           onChanged: (val) => setState(() => _selectedProjectType = val),
//         ),
//         _buildDropdownField(
//           label: 'Language Comfort',
//           value: _selectedLanguageComfort,
//           items: ['English', 'Hindi', 'Other'],
//           onChanged: (val) => setState(() => _selectedLanguageComfort = val),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStep3Review() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Review below details before proceeding",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//             const SizedBox(height: 12),
//             _buildReviewRow("Name:-", _nameController.text),
//             _buildReviewRow("Email:-", _emailController.text),
//             _buildReviewRow("Mobile Number:-", _phoneController.text),
//             _buildReviewRow("Date of Birth:-", _dobController.text),
//             _buildReviewRow("City:-", _cityController.text),
//             _buildReviewRow("Tech Stack:-", _techStackController.text),
//             _buildReviewRow("Years Of Experience:-", _YearsOfExperience.text),
//             _buildReviewRow("Projects Description:-", _ProjectsDescriptions.text),
//             _buildReviewRow("Portfolio Link:-", _Portfolio.text),
//             _buildReviewRow("Github Profile:-", _GitHub.text),
//             _buildReviewRow("LinkedIn Profile:-", _LinkedIn.text),
//
//             _buildReviewRow("Availability:-", _selectedAvailability ?? ''),
//             _buildReviewRow("Preferred Project Type:-", _selectedProjectType ?? ''),
//             _buildReviewRow("Language Comfort:-", _selectedLanguageComfort ?? ''),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildReviewRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Row(
//         children: [
//           Expanded(flex: 3, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
//           Expanded(flex: 5, child: Text(value)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     bool isOptional = false,
//     int maxLines = 1,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         validator: (val) {
//           if (isOptional) return null;
//           return (val == null || val.isEmpty) ? "Enter $label" : null;
//         },
//       ),
//     );
//   }
//
//
//   Widget _buildPhoneField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: DropdownButtonFormField<String>(
//               items: const [
//                 DropdownMenuItem(value: "+91", child: Text("IN (+91)")),
//               ],
//               value: "+91",
//               onChanged: (val) {},
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child:
//             TextFormField(
//               controller: _phoneController,
//               keyboardType: TextInputType.number,
//               maxLength: 10,
//               inputFormatters: [
//                 FilteringTextInputFormatter.digitsOnly,
//                 LengthLimitingTextInputFormatter(10),
//               ],
//               decoration: const InputDecoration(
//                 labelText: "Phone Number",
//                 border: OutlineInputBorder(),
//                 counterText: "", // to hide character count
//               ),
//               validator: (val) {
//                 if (val == null || val.isEmpty) return "Enter phone number";
//                 if (val.length != 10) return "Enter a valid 10-digit phone number";
//                 return null;
//               },
//             ),
//
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDatePickerField({
//     required String label,
//     required TextEditingController controller,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: controller,
//         readOnly: true,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//           suffixIcon: const Icon(Icons.calendar_today),
//         ),
//         onTap: () async {
//           final pickedDate = await showDatePicker(
//             context: context,
//             initialDate: DateTime(2000),
//             firstDate: DateTime(1950),
//             lastDate: DateTime.now(),
//           );
//           if (pickedDate != null) {
//             controller.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
//           }
//         },
//       ),
//     );
//   }
//   Widget _buildDropdownField({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: DropdownButtonFormField<String>(
//         value: value,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//         items: items
//             .map((item) => DropdownMenuItem(value: item, child: Text(item)))
//             .toList(),
//         onChanged: onChanged,
//         validator: (val) => val == null || val.isEmpty ? 'Select $label' : null,
//       ),
//     );
//   }
//
//}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class Plan {
//   final String title;
//   final String tagline;
//   final String price;
//
//   Plan({required this.title, required this.tagline, required this.price});
// }
//
class ProfessionCheckoutScreen extends StatefulWidget {
  final Plan plan;

  const ProfessionCheckoutScreen({super.key, required this.plan});

  @override
  State<ProfessionCheckoutScreen> createState() => _ProfessionCheckoutScreenState();
}

class _ProfessionCheckoutScreenState extends State<ProfessionCheckoutScreen> {
  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();
  int _currentStep = 1;

  // Step 1 controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _dobController = TextEditingController();

  // Step 2 controllers
  final _techStackController = TextEditingController();
  final _yearsOfExperience = TextEditingController();
  final _projectsDescriptions = TextEditingController();
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
        return _buildReview();
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
            } else if (_currentStep == 3 && (_selectedAvailability != null && (_selectedProjectType != null || _otherProjectTypeController.text.isNotEmpty) && _selectedLanguageComfort != null)) {
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
          _buildTextField("Tech Stack", _techStackController),
          _buildTextField("Years of Experience", _yearsOfExperience, keyboard: TextInputType.number),
          _buildTextField("Project Description", _projectsDescriptions, maxLines: 4),
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
        _buildDropdown("Preferred Project Type", _isOtherProjectType ? null : _selectedProjectType, ['Web', 'Mobile', 'AI/ML', 'Design', 'Other'], (val) {
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
      _buildReviewRow("Tech Stack", _techStackController.text),
      _buildReviewRow("Experience", _yearsOfExperience.text),
      _buildReviewRow("Project Description", _projectsDescriptions.text),
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
}