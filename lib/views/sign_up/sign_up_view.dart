
//! Deleted Code
// import 'package:MySchool/views/sign_up/login_view.dart';
// import 'package:flutter/material.dart';
// import 'package:MySchool/widgets/custom_button.dart';
// import 'package:MySchool/widgets/custom_text_field.dart';
// import 'package:MySchool/constants.dart';

// import '../../services/auth_service.dart';

// class SignUpView extends StatelessWidget {
//   const SignUpView({super.key});
//   static String id = "/SignUpView";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor : Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),
//                 const SignUpImage(),
//                 const SizedBox(height: 20),
//                 const HelloText(),
//                 const SizedBox(height: 20),
//                 SignUpForm(),

//                 const HaveAnAccountText(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SignUpImage extends StatelessWidget {
//   const SignUpImage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Image(
//       image: AssetImage("assets/signup_image.png"),
//       height: 121,
//     );
//   }
// }

// class HelloText extends StatelessWidget {
//   const HelloText({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         AppTexts.helloText,
//         style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 16),
//       ),
//     );
//   }
// }


// class SignUpForm extends StatefulWidget {
//   const SignUpForm({super.key});

//   @override
//   _SignUpFormState createState() => _SignUpFormState();
// }
// class _SignUpFormState extends State<SignUpForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _authService = AuthService(); 
//   bool _isLoading = false;
//   bool _obscurePassword = true; 

//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _idNumberController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _idNumberController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);

//       final result = await _authService.signUp(
//         name: _nameController.text.trim(),
//         email: _emailController.text.trim(),
//         idNumber: _idNumberController.text.trim(),
//         password: _passwordController.text.trim(),
//       );

//       setState(() => _isLoading = false);

//       if (result['success'] == true) {
//         Navigator.pushReplacementNamed(context, LoginView.id);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Account created successfully! Please login.'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(result['error']),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           CustomTextFormField(
//             controller: _nameController,
//             hintText: "Name",
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your name';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           CustomTextFormField(
//             controller: _emailController,
//             hintText: "Email",
//             keyboardType: TextInputType.emailAddress,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your email';
//               }
//               if (!value.contains('@') || !value.contains('.')) {
//                 return 'Please enter a valid email';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           CustomTextFormField(
//             controller: _idNumberController,
//             hintText: "ID Number",
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your ID number';
//               }
//               if (value.length < 6) {
//                 return 'ID number must be at least 6 digits';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           CustomTextFormField(
//             controller: _passwordController,
//             obscureText: _obscurePassword,
//               hintText: "Password",
//               suffixIcon: IconButton(
//                 icon: Icon(
//                   _obscurePassword ? Icons.visibility_off_outlined: Icons.visibility_outlined ,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _obscurePassword = !_obscurePassword;
//                   });
//                 },
//               ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your password';
//               }
//               if (value.length < 6) {
//                 return 'Password must be at least 6 characters';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//           _isLoading
//               ? const CircularProgressIndicator()
//               : CustomButton(
//                   onTap: _submitForm,
//                   text: "Sign Up",
//                 ),
//         ],
//       ),
//     );
//   }
// }


// class HaveAnAccountText extends StatelessWidget {
//   const HaveAnAccountText({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only( left: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(AppTexts.haveAccountText),

//           TextButton(
//             onPressed: () {
//               Navigator.pushReplacementNamed(context, LoginView.id);
//             },
//             style: TextButton.styleFrom(
//               padding: EdgeInsets.zero,
//               minimumSize: Size(50, 30),
//             ),
//             child: Text(
//               AppTexts.loginText,
//               style: TextStyle(color: AppColors.kSecondaryColor, fontSize: 13.33),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }