import 'package:flutter/material.dart';

import '../Forms/StudentsVerificartions.dart';
import 'package:flutter/material.dart';

class PreferenceDialog extends StatefulWidget {
  const PreferenceDialog({super.key});

  @override
  State<PreferenceDialog> createState() => _PreferenceDialogState();
}

class _PreferenceDialogState extends State<PreferenceDialog> {
  final List<String> options = [
    "Web Development (Frontend / Backend / Full-stack)",
    "Mobile App Development",
    "UI/UX Design",
    "Graphic Design / Branding",
    "SEO / SEM",
    "Social Media Management",
    "Content Writing / Copywriting",
    "Video Editing",
    "Animation",
    "Chatbox Integration",
    "Digital Marketing",
    "Data Analysis / Power BI / Excel",
    "Virtual Assistant / Admin Support",
    "Python",
    "Java",
    "Others"
  ];

  List<String> selectedOptions = [];
  String? otherInput;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Select Your Preferences",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Select up to 3 areas of expertise"),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) {
                final isSelected = selectedOptions.contains(option);
                return ChoiceChip(
                  label: Text(option, textAlign: TextAlign.center),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (isSelected) {
                        selectedOptions.remove(option);
                        if (option == "Others") otherInput = null;
                      } else {
                        if (selectedOptions.length < 3) {
                          selectedOptions.add(option);
                        }
                      }
                    });
                  },
                  selectedColor: Color(0xFF4D90FE),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Color(0xFF4D90FE),
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color:Color(0xFF4D90FE)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (selectedOptions.contains("Others"))
              TextFormField(
                onChanged: (value) => otherInput = value,
                decoration: const InputDecoration(
                  labelText: "Enter your preference",
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedOptions.isEmpty
                    ? null
                    : () {
                  // Just close this dialog and pass data to parent
                  Navigator.pop(context, {
                    "selected": selectedOptions,
                    "custom": otherInput,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4D90FE),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Next", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class PreferenceDialog extends StatefulWidget {
//   const PreferenceDialog({super.key});
//
//   @override
//   State<PreferenceDialog> createState() => _PreferenceDialogState();
// }
//
// class _PreferenceDialogState extends State<PreferenceDialog> {
//   final List<String> options = [
//     "Web Development (Frontend / Backend / Full-stack)",
//     "Mobile App Development",
//     "UI/UX Design",
//     "Graphic Design / Branding",
//     "SEO / SEM",
//     "Social Media Management",
//     "Content Writing / Copywriting",
//     "Video Editing",
//     "Animation",
//     "Chatbox Integration",
//     "Digital Marketing",
//     "Data Analysis / Power BI / Excel",
//     "Virtual Assistant / Admin Support",
//     "Python",
//     "Java",
//     "Others"
//   ];
//
//   List<String> selectedOptions = [];
//   String? otherInput;
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             const Text(
//               "Select Your Preferences",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             const Text("Select up to 3 areas of expertise"),
//             const SizedBox(height: 20),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: options.map((option) {
//                 final isSelected = selectedOptions.contains(option);
//                 return ChoiceChip(
//                   label: Text(option, textAlign: TextAlign.center),
//                   selected: isSelected,
//                   onSelected: (selected) {
//                     setState(() {
//                       if (isSelected) {
//                         selectedOptions.remove(option);
//                         if (option == "Others") otherInput = null;
//                       } else {
//                         if (selectedOptions.length < 3) {
//                           selectedOptions.add(option);
//                         }
//                       }
//                     });
//                   },
//                   selectedColor: Colors.deepPurple,
//                   labelStyle: TextStyle(
//                     color: isSelected ? Colors.white : Colors.deepPurple,
//                   ),
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     side: const BorderSide(color: Colors.deepPurple),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 20),
//             if (selectedOptions.contains("Others"))
//               TextFormField(
//                 onChanged: (value) => otherInput = value,
//                 decoration: const InputDecoration(
//                   labelText: "Enter your preference",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             const SizedBox(height: 30),
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//               onPressed: selectedOptions.isEmpty
//               ? null
//         : () {
//     Navigator.pop(context, {
//     'selected': selectedOptions,
//     'custom': otherInput,
//     });
//     }
//
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.deepPurple,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text("Next", style: TextStyle(color: Colors.white)),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

