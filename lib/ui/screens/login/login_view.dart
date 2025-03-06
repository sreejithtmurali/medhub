import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';
import '../../../constants/assets.gen.dart';
import '../../tools/screen_size.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, viewModel, child) {
        return Scaffold(

          body: SafeArea(

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            backgroundImage: AssetImage("assets/images/logo.png"),
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                
                     SizedBox(height: MediaQuery.of(context).size.height/8),
                
                    // Login Title
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                
                    const SizedBox(height: 8),
                
                    // Subtitle
                    const Text(
                      'Keep your Medical Records with MedHub\nStay Healthy Stay Safe',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                
                    const SizedBox(height: 32),
                
                    // Form
                    Form(
                      key: viewModel.formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email Label
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                
                          const SizedBox(height: 8),
                
                          // Email Field
                          TextFormField(
                            validator: (value) => viewModel.validateEmail(value),
                            controller: viewModel.namecontroller,


                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "enter your email",
                              prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                
                          const SizedBox(height: 16),
                
                          // Password Label
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                
                          const SizedBox(height: 8),
                
                          // Password Field
                          TextFormField(
                            validator: (value) {
                              return value!.length >= 6 ? null : "Enter valid password";
                            },
                            controller: viewModel.password,
                            obscureText: viewModel.isviewable,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "password",
                              prefixIcon: const Icon(Icons.lock_outlined, color: Colors.grey),
                              suffixIcon: IconButton(
                                icon:  Icon(!viewModel.isviewable?Icons.visibility_off:Icons.remove_red_eye, color: Colors.grey),
                                onPressed: () {
                                  viewModel.togglepass();
                                },
                              ),
                
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                
                          const SizedBox(height: 40),
                
                          // Sign In Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              onPressed: () {
                                viewModel.login();
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                
                          const SizedBox(height: 16),
                
                          // Forgot Password
                          // Center(
                          //   child: TextButton(
                          //     onPressed: () {
                          //       // Handle forgot password
                          //     },
                          //     child: const Text(
                          //       'Forgot password?',
                          //       style: TextStyle(
                          //         color: Colors.blue,
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                
                    // const Spacer(),
                
                    // Sign Up Link
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                viewModel.navRegister();
                              },
                              child: const Text(
                                'Sign up here',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
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
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}


