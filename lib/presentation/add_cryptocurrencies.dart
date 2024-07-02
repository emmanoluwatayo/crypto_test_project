// // screens/add_crypto_screen.dart
// import 'package:crypto_test_project/api_riverpod/repo.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../model/crypto_model.dart';

// class AddCryptoScreen extends ConsumerWidget {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _quantityController = TextEditingController();

//   AddCryptoScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(title: const  Text('Add Cryptocurrency')),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const  InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the name of the cryptocurrency';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _quantityController,
//                 decoration: const InputDecoration(labelText: 'Quantity'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the quantity';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState?.validate() ?? false) {
//                     final crypto = Crypto(
//                       id: DateTime.now().toString(),
//                       name: _nameController.text,
//                       quantity: double.parse(_quantityController.text),
//                     );
//                     ref.read(portfolioProvider.notifier).addCrypto(crypto);
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: const Text('Add'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
