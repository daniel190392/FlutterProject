import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/domain/respositories/respositories.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

// void main() {
//   late KeychainAuthenticationRepository sut;
//   const exampleKey = 'exampleKey';

//   setUp(() {
//     WidgetsFlutterBinding.ensureInitialized();
//     sut = KeychainAuthenticationRepository();
//   });

//   tearDown(() {
//     sut.clear();
//   });

//   group('Set and Get Bool value from keychain', () {
//     test('execute with success result', () async {
//       // GIVEN
//       const value = true;

//       // WHEN
//       await sut.setValueWith(exampleKey, value);
//       final result = await sut.getBoolWith(exampleKey);

//       // THEN
//       expect(result, result);
//     });

//     test('execute with failed result', () async {
//       try {
//         // WHEN
//         await sut.getBoolWith(exampleKey);
//         fail('expected key not founded');
//       } catch (exception) {
//         // THEN
//         if (exception is ErrorServiceModel) {
//           expect(exception.message, 'key not founded');
//         } else {
//           fail('expected other error');
//         }
//       }
//     });
//   });
// }
