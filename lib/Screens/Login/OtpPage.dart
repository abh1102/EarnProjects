import 'dart:async';
import 'package:earnprojects/Screens/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../Services/OtpServices.dart';
import '../../Services/SignUpServices.dart';
class OtpScreen extends StatefulWidget {
  final String email; // Changed from phoneNumber to email
  final VoidCallback? onVerificationSuccess; // Callback for successful verification

  const OtpScreen({
    super.key,
    required this.email,
    this.onVerificationSuccess,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.length != 6) return;

    setState(() => _isVerifying = true);

    try {
      final response = await OtpService.verifyOtp(widget.email, _otpController.text);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email verified successfully!')),
        );

        // ✅ Callback
        widget.onVerificationSuccess?.call();

        // ✅ Navigate back
        Navigator.pop(context); // or Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification failed: ${response.data['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isVerifying = false);
    }
  }



  // void _resendOtp() async {
  //   try {
  //     // Call your API to resend OTP
  //     final response = await ApiService().resendOtp(email: widget.email);
  //
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         _secondsRemaining = 30;
  //         _startTimer();
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('OTP resent successfully!')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: ${e.toString()}')),
  //     );
  //   }
  // }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xF0F7FBFF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "OTP sent to",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.email, color: Colors.blue), // Changed from phone icon
                                    const SizedBox(width: 6),
                                    Text(
                                      widget.email, // Changed from phoneNumber to email
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Pinput(
                                  controller: _otpController,
                                  length: 6,
                                  defaultPinTheme: defaultPinTheme,
                                  onChanged: (value) {
                                    setState(() {}); // Rebuild to update button state
                                  },
                                ),
                                const SizedBox(height: 24),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text(
                                //       _secondsRemaining > 0
                                //           ? "Resend OTP in $_secondsRemaining seconds"
                                //           : "Didn't receive OTP?",
                                //       style: const TextStyle(color: Colors.grey),
                                //     ),
                                //     if (_secondsRemaining == 0)
                                //       // TextButton(
                                //       //   // onPressed: _resendOtp,
                                //       //   child: const Text(
                                //       //     "Resend",
                                //       //     style: TextStyle(color: Colors.blue),
                                //       //   ),
                                //       // ),
                                //   ],
                                // ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                    onPressed: (_otpController.text.length == 6 && !_isVerifying) ? _verifyOtp : null,


                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    minimumSize: const Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    disabledBackgroundColor: Colors.blue.withOpacity(0.2),
                                  ),
                                  child: _isVerifying
                                      ? const CircularProgressIndicator(color: Colors.white)
                                      : const Text(
                                    "Verify OTP",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
