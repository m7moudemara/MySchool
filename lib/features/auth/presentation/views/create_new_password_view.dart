import 'package:MySchool/core/app_session.dart';
import 'package:MySchool/features/auth/data/repositories/mock_reset_password_repository.dart';
import 'package:MySchool/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:MySchool/features/auth/presentation/views/login_view.dart';
import 'package:MySchool/features/main_wrapper/domain/entities/user_role.dart';
import 'package:MySchool/features/main_wrapper/presentation/views/main_wrapper_view.dart';
import 'package:MySchool/features/school/data/models/parent_model.dart';
import 'package:MySchool/features/school/data/models/student_model.dart';
import 'package:MySchool/features/school/data/models/teacher_model.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../main_wrapper/presentation/widgets/custom_button.dart';
import '../../../school/presentation/widgets/custom_text_field.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});
  static String id = '/CreateNewPasswordView';

  @override
  _CreateNewPasswordViewState createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late String userId;
  final _newPasswordController = TextEditingController();
  late final ResetPasswordUseCase _resetPasswordUseCase;
  late bool isFirstLogin;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
   final args = ModalRoute.of(context)?.settings.arguments;
if (args != null && args is Map<String, dynamic>) {
  userId = args['userId'] ?? '';
  isFirstLogin = args['isFirstLogin'] ?? false;
}
  }

  @override
  void initState() {
    super.initState();
    _resetPasswordUseCase = ResetPasswordUseCase(MockResetPasswordRepository());
  }

  bool _showPassword = false;
  bool _showConfirmationDialog = false;

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _showSuccessDialog() {
    setState(() {
      _showConfirmationDialog = true;
    });

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, LoginView.id);
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Create New Password"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Create New Password",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Your new password must be different from your previous password",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _newPasswordController,
                      hintText: "New Password",
                      obscureText: !_showPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm New Password",
                      obscureText: !_showPassword,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _showPassword,
                          onChanged: (value) {
                            _togglePasswordVisibility();
                          },
                        ),
                        const Text("Show Password"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      onTap: () async {
                        if (_newPasswordController.text !=
                            _confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match"),
                            ),
                          );
                          return;
                        }

                        final dio = Dio();
                        try {
                          await dio.put(
                            "https://67f2952eec56ec1a36d38b8a.mockapi.io/myschool/users/$userId",
                            data: {
                              "password": _newPasswordController.text,
                            "is_first_login" : false,  
                              },
                          );
   if (isFirstLogin) {
          final user = AppSession.currentUser;
          if (user != null) {
        UserType userType;
    
    if (user is Student) {
      userType = UserType.student;
    } else if (user is Teacher) {
      userType = UserType.teacher;
    } else if (user is Parent) {
      userType = UserType.parent;
    } else {
      userType = UserType.student; 
    }
          
          
          Navigator.pushReplacementNamed(
            context,
            MainWrapperView.id,
            arguments: RouteArguments(role: userType),
          );
        } else {
          _showSuccessDialog();
        }}
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    },
  text: isFirstLogin ? "Set Password" : "Reset Password",
),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            if (_showConfirmationDialog)
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Image.asset(
                      "assets/congratulation.png",
                    
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
