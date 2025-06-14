import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../Forms/AgencyVerification.dart';
import '../Forms/ProfessionalVerifications.dart';
import '../Forms/StudentsVerificartions.dart';
import '../Preferences/Preference.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigit = false;
  bool hasSpecialChar = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String? selectedRole;

  final roles = ['Student', 'Professional', 'Agency'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  void _updatePasswordRules(String value) {
    setState(() {
      hasMinLength = value.length >= 8;
      hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
      hasLowercase = RegExp(r'[a-z]').hasMatch(value);
      hasDigit = RegExp(r'\d').hasMatch(value);
      hasSpecialChar = RegExp(r'[!@#\$&*~%^()\-_=+{};:,<.>?]').hasMatch(value);
    });
  }
  void _submit() {
    final isFormValid = _formKey.currentState!.validate();
    final isRoleValid = validateRole() == null;

    if (isFormValid && isRoleValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      // Proceed with navigation or API call
    } else {
      setState(() {}); // Refresh for role validation
    }
  }

  String? validateRole() {
    if (selectedRole == null) return 'Please select a category';
    return null;
  }

  @override
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    children: roles.map((role) {
                      final isSelected = selectedRole == role;
                      return ChoiceChip(
                        label: Text(role),
                        selected: isSelected,
                        onSelected: (_) => setState(() => selectedRole = role),
                        selectedColor: const Color(0xFFBFAAF2),
                        backgroundColor: const Color(0xFFF3EFFF),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      );
                    }).toList(),
                  ),
                  if (validateRole() != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 12),
                      child: Text(
                        validateRole()!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: width > 600 ? 600 : null,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF4D90FE)),
                      ),
                      const SizedBox(height: 30),

                      // Username
                      TextFormField(
                        controller: _nameController,
                        validator: ValidationUtils.validateName,
                        onChanged: (_) {
                          _formKey.currentState!.validate();
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Phone
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text("+91", style: TextStyle(fontSize: 16)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 8,
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              validator: ValidationUtils.validatePhone,
                              onChanged: (_) {
                                _formKey.currentState!.validate();
                                setState(() {});
                              },
                              decoration: const InputDecoration(
                                counterText: "",
                                hintText: "Mobile Number",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        validator: ValidationUtils.validateEmail,
                        onChanged: (_) {
                          _formKey.currentState!.validate();
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: const OutlineInputBorder(),
                          suffixIcon: TextButton(
                            onPressed: () {},
                            child: const Text("Verify", style: TextStyle(color:Color(0xFF4D90FE))),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: obscurePassword,
                        validator: ValidationUtils.validatePassword,
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                          _updatePasswordRules(value);
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: Color(0xFF4D90FE),
                            ),
                            onPressed: () => setState(() => obscurePassword = !obscurePassword),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Password rules
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRuleText('Minimum 8 characters', hasMinLength),
                          _buildRuleText('At least 1 uppercase letter', hasUppercase),
                          _buildRuleText('At least 1 lowercase letter', hasLowercase),
                          _buildRuleText('At least 1 digit', hasDigit),
                          _buildRuleText('At least 1 special character', hasSpecialChar),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Confirm Password
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: obscureConfirmPassword,
                        validator: (value) => ValidationUtils.validateConfirmPassword(
                          value,
                          _passwordController.text,
                        ),
                        onChanged: (_) {
                          _formKey.currentState!.validate();
                        },
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                              color: Color(0xFF4D90FE),
                            ),
                            onPressed: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            final isFormValid = _formKey.currentState!.validate();
                            final isRoleValid = validateRole() == null;

                            if (isFormValid && isRoleValid) {
                              // Step 1: Show Preference Dialog
                              final preferenceResult = await showDialog(
                                context: context,
                                builder: (_) => const PreferenceDialog(),
                              );

                              if (preferenceResult == null) return;

                              // Step 2: Role-specific verification
                              dynamic verificationResult;

                              if (selectedRole == 'Student') {
                                verificationResult = await showDialog(
                                  context: context,
                                  builder: (_) => const StudentVerificationDialog(),
                                );
                              } else if (selectedRole == 'Professional') {
                                verificationResult = await showDialog(
                                  context: context,
                                  builder: (_) => const ProfessionalVerificationDialog(),
                                );
                              } else if (selectedRole == 'Agency') {
                                verificationResult = await showDialog(
                                  context: context,
                                  builder: (_) => const AgencyVerificationDialog(),
                                );
                              }

                              if (verificationResult == null) return;

                              // ✅ You now have full form + preference + role-verification data
                              print("Form Data:");
                              print("Name: ${_nameController.text}");
                              print("Phone: ${_phoneController.text}");
                              print("Email: ${_emailController.text}");
                              print("Role: $selectedRole");

                              print("Preference:");
                              print("Selected: ${preferenceResult['selected']}");
                              print("Custom Input: ${preferenceResult['custom']}");

                              print("Verification:");
                              print(verificationResult); // You can handle each role’s fields differently if needed

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Signup Successful!")),
                              );
                            } else {
                              setState(() {});
                            }
                          },


                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4D90FE),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleText(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: isValid ? Colors.green : Colors.red, fontSize: 13),
        ),
      ],
    );
  }

}

//
//
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//
//   bool obscurePassword = true;
//   bool obscureConfirmPassword = true;
//   String? selectedRole ;
//
//   final roles = ['Student', 'Professional', 'Agency'];
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   void _submit() {
//     final isFormValid = _formKey.currentState!.validate();
//     final isRoleValid = validateRole() == null;
//
//     if (isFormValid && isRoleValid) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Processing Data')),
//       );
//     } else {
//       setState(() {}); // To refresh UI for role error
//     }
//   }
//   String? validateRole() {
//     if (selectedRole == null) {
//       return 'Please select a category';
//     }
//     return null;
//   }
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Wrap(
//                     alignment: WrapAlignment.center,
//                     spacing: 8,
//                     children: roles.map((role) {
//                       final isSelected = selectedRole == role;
//                       return ChoiceChip(
//                         label: Text(role),
//                         selected: isSelected,
//                         onSelected: (_) => setState(() => selectedRole = role),
//                         selectedColor: const Color(0xFFBFAAF2),
//                         backgroundColor: const Color(0xFFF3EFFF),
//                         labelStyle: TextStyle(
//                           color: isSelected ? Colors.white : Colors.black54,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   if (validateRole() != null)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0, left: 12),
//                       child: Text(
//                         validateRole()!,
//                         style: const TextStyle(color: Colors.red, fontSize: 12),
//                       ),
//                     ),
//                 ],
//               ),
//
//               const SizedBox(height: 30),
//               Container(
//                 width: width > 600 ? 600 : null,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: const [
//                     BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
//                   ],
//                 ),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       const Text(
//                         "Sign Up",
//                         style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF7B1FA2)),
//                       ),
//                       const SizedBox(height: 30),
//                       TextFormField(
//                         controller: _nameController,
//                         validator: ValidationUtils.validateName,
//                         onChanged: (_) {
//                           _formKey.currentState!.validate();
//                           setState(() {});
//                         },
//                         decoration: const InputDecoration(
//                           labelText: "Username",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFF5F5F5),
//                               border: Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: const Text(
//                               "+91",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: TextFormField(
//                               controller: _phoneController,
//                               keyboardType: TextInputType.number,
//                               maxLength: 10,
//                               validator: ValidationUtils.validatePhone,
//                               onChanged: (_) {
//                                 _formKey.currentState!.validate();
//                                 setState(() {});
//                               },
//                               decoration: const InputDecoration(
//                                 counterText: "", // hides character count
//                                 hintText: "Mobile Number",
//                                 border: OutlineInputBorder(),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         controller: _emailController,
//                         validator: ValidationUtils.validateEmail,
//                         onChanged: (_) {
//                           _formKey.currentState!.validate();
//                           setState(() {});
//                         },
//                         decoration: InputDecoration(
//                           labelText: "Email",
//                           border: const OutlineInputBorder(),
//                           suffixIcon: TextButton(
//                             onPressed: () {},
//                             child: const Text("Verify", style: TextStyle(color: Colors.deepPurple)),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextFormField(
//                               controller: _passwordController,
//                               obscureText: obscurePassword,
//                               validator: ValidationUtils.validatePassword,
//                               onChanged: (_) {
//                                 _formKey.currentState!.validate();
//                                 setState(() {});
//                               },
//                               decoration: InputDecoration(
//                                 labelText: "Password",
//                                 border: const OutlineInputBorder(),
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     obscurePassword ? Icons.visibility_off : Icons.visibility,
//                                     color: Colors.deepPurple,
//                                   ),
//                                   onPressed: () => setState(() => obscurePassword = !obscurePassword),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: TextFormField(
//                               controller: _confirmPasswordController,
//                               obscureText: obscureConfirmPassword,
//                               validator: (value) => ValidationUtils.validateConfirmPassword(value, _passwordController.text),
//                               onChanged: (_) {
//                                 _formKey.currentState!.validate();
//                                 setState(() {});
//                               },
//                               decoration: InputDecoration(
//                                 labelText: "Confirm Password",
//                                 border: const OutlineInputBorder(),
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
//                                     color: Colors.deepPurple,
//                                   ),
//                                   onPressed: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 30),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: _submit,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF8E24AA),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                           ),
//                           child: const Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.white)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }