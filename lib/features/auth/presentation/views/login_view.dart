// import 'package:MySchool/core/di/get_it.dart';
// import 'package:MySchool/core/widgets/custom_snack_bar.dart';
// import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
// import 'package:MySchool/features/auth/presentation/widgets/hello_text.dart';
// import 'package:MySchool/features/auth/presentation/widgets/login_form.dart';
// import 'package:MySchool/features/auth/presentation/widgets/login_image.dart';
// import 'package:MySchool/features/main_wrapper/domain/entities/user_role.dart';
// import 'package:MySchool/features/auth/presentation/views/create_new_password_view.dart';
// import 'package:MySchool/features/school/data/models/parent_model.dart';
// import 'package:MySchool/features/school/data/models/student_model.dart';
// import 'package:MySchool/features/school/data/models/teacher_model.dart';
// import 'package:MySchool/features/school/domain/entities/user_type.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:MySchool/routes/app_routes.dart';
// import 'package:MySchool/features/main_wrapper/presentation/views/main_wrapper_view.dart';
// import '../cubit/login/login_cubit.dart';
// import '../cubit/login/login_state.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});
//   static String id = '/LoginView';

//   @override
//   _LoginViewState createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final _formKey = GlobalKey<FormState>();
//   final _idNumberController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   @override
//   void dispose() {
//     _idNumberController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _onSubmit(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       context.read<LoginCubit>().login(
//         idNumber: _idNumberController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: BlocConsumer<LoginCubit, LoginState>(
//           listener: (context, state) {
//             //! Error State
//             if (state is LoginFailure) {
//                CustomSnackBar.show(context, state.error ,type: SnackBarType.error);
//             }
//             //! Success
//             if (state is LoginSuccess) {
//               CustomSnackBar.show(context, "Login Success" ,type: SnackBarType.success);
//               final userJson = state.userJson;
//               final role = parseUserRole(userJson['role']);
//               late IUser user;

//               if (role == UserRole.student) {
//                 user = Student.fromJson(userJson);
//               } else if (role == UserRole.teacher) {
//                 user = Teacher.fromJson(userJson);
//               } else {
//                 user = Parent.fromJson(userJson);
//               }

//               getIt<UserCubit>().setUser(user);

//               Navigator.pushReplacementNamed(
//                 context,
//                 MainWrapperView.id,
//                 arguments: RouteArguments(role: parseUserType(role)),
//               );
//             }
//             if (state is FirstLoginRequired) {
//               CustomSnackBar.show(context, "Plesse Change Your Password Now !" ,type: SnackBarType.warning);
//               Navigator.pushReplacementNamed(
//                 context,
//                 CreateNewPasswordView.id,
//                 arguments: {
//                   'userId': state.userJson['id'],
//                   'isFirstLogin': true,
//                 },
//               );
//             }
//           },
//           builder: (context, state) {
//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     const LoginImage(),
//                     const SizedBox(height: 20),
//                     const HelloText(),
//                     const SizedBox(height: 20),
//                     LoginForm(
//                       formKey: _formKey,
//                       idNumberController: _idNumberController,
//                       passwordController: _passwordController,
//                       isLoading: state is LoginLoading,
//                       obscurePassword: _obscurePassword,
//                       onPasswordVisibilityToggle: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                       onSubmit: () async => _onSubmit(context),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:MySchool/constants/strings.dart';
import 'package:MySchool/core/di/get_it.dart';
import 'package:MySchool/core/widgets/custom_snack_bar.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/auth/presentation/widgets/hello_text.dart';
import 'package:MySchool/features/auth/presentation/widgets/login_form.dart';
import 'package:MySchool/features/auth/presentation/widgets/login_image.dart';
import 'package:MySchool/features/main_wrapper/domain/entities/user_role.dart';
import 'package:MySchool/features/auth/presentation/views/create_new_password_view.dart';
import 'package:MySchool/features/school/data/models/parent_model.dart';
import 'package:MySchool/features/school/data/models/student_model.dart';
import 'package:MySchool/features/school/data/models/teacher_model.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/routes/app_routes.dart';
import 'package:MySchool/features/main_wrapper/presentation/views/main_wrapper_view.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = '/LoginView';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _idNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _idNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    final url = Uri.parse('$baseUrl/api/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "user_name": _idNumberController.text.trim(),
        "password": _passwordController.text.trim(),
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const LoginImage(),
                const SizedBox(height: 20),
                const HelloText(),
                const SizedBox(height: 20),
                LoginForm(
                  formKey: _formKey,
                  idNumberController: _idNumberController,
                  passwordController: _passwordController,
                  isLoading: false,
                  // isLoading: state is LoginLoading,
                  obscurePassword: _obscurePassword,
                  onPasswordVisibilityToggle: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  onSubmit: () async => _onSubmit(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
