import 'package:flutter/material.dart';

import '../../Model/AllPlansModel.dart';

 class StudentCardsPlan extends StatelessWidget {
   final Plan plan;
   const StudentCardsPlan ({super.key, required this.plan});

   @override
   Widget build(BuildContext context) {
     return Stack(
       children: [
         Container(
           padding: const EdgeInsets.all(16),
           decoration: BoxDecoration(
             border: Border.all(
               color: plan.isPopular ? Colors.deepPurple : Colors.grey.shade300,
             ),
             borderRadius: BorderRadius.circular(12),
           ),
           child: Column(
             mainAxisSize: MainAxisSize.min, // Important to make height dynamic
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 plan.title,
                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
               ),
               const SizedBox(height: 4),
               Text(
                 plan.tagline,
                 style: const TextStyle(color: Colors.black54),
               ),
               const SizedBox(height: 8),
               Text(
                 plan.price,
                 style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
               ),
               if (plan.discount.isNotEmpty)
                 Text(
                   plan.discount,
                   style: const TextStyle(color: Colors.green),
                 ),
               const SizedBox(height: 10),
               const Text(
                 'Features Include:',
                 style: TextStyle(fontWeight: FontWeight.w600),
               ),
               const SizedBox(height: 6),
               Column(
                 children: plan.features
                     .map(
                       (f) => Padding(
                     padding: const EdgeInsets.symmetric(vertical: 2),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Icon(Icons.check_circle, size: 16, color: Colors.green),
                         const SizedBox(width: 6),
                         Expanded(
                           child: Text(
                             f,
                             style: const TextStyle(fontSize: 13),
                           ),
                         ),
                       ],
                     ),
                   ),
                 )
                     .toList(),
               ),
               const SizedBox(height: 16),
               SizedBox(
                 width: double.infinity,
                 child: ElevatedButton(
                   onPressed: plan.onTap,
                   style: ElevatedButton.styleFrom(
                     backgroundColor: plan.isPopular ? Colors.deepPurple : Colors.grey[800],
                     minimumSize: const Size.fromHeight(40),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(8),
                     ),
                   ),
                   child: Text(plan.isPopular ? 'Get Started' : 'Choose Plan',style: TextStyle(color: Colors.white,),),
                 ),
               ),
             ],
           ),
         ),
         if (plan.isPopular)
           Positioned(
             right: 0,
             child: Container(
               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
               decoration: const BoxDecoration(
                 color: Colors.deepPurple,
                 borderRadius: BorderRadius.only(
                   topRight: Radius.circular(12),
                   bottomLeft: Radius.circular(12),
                 ),
               ),
               child: const Text(
                 'Most Popular',
                 style: TextStyle(color: Colors.white, fontSize: 12),
               ),
             ),
           ),
       ],
     );
   }
 }
