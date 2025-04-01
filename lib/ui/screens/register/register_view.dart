import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'register_viewmodel.dart';
import '../../../constants/assets.gen.dart';
import '../../tools/screen_size.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      onViewModelReady: (m){

      },
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          //   leading: IconButton(
          //     icon: const Icon(Icons.menu, color: Colors.blue),
          //     onPressed: () {},
          //   ),
          //   actions: [
          //     Padding(
          //       padding: const EdgeInsets.only(right: 16.0),
          //       child: CircleAvatar(
          //         backgroundColor: Colors.blue.shade500,
          //         child: const Icon(Icons.chat, color: Colors.white),
          //       ),
          //     ),
          //   ],
          // ),
          body: Container(
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [Colors.white, Colors.blue.shade100],
              //   stops: [0.0, 1.0],
              // ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Center(
                    child: Form(
                      key: viewModel.formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        //  const SizedBox(height: 8),
                          // Title
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Subtitle
                          const Text(
                            'Stay safe & Stay Healthy with MedHub',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Email Field
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            validator: (value) => viewModel.validateName(value),
                            controller: viewModel.namecontroller,
                            decoration: InputDecoration(
                              hintText: "Enter your name",
                              prefixIcon: const Icon(Icons.person, color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),

                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),

                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 8),
                          TextFormField(
                            validator: (value) => viewModel.validateEmail(value),
                            controller: viewModel.emailctrlr,
                            decoration: InputDecoration(
                              hintText: "nick@gmail.com",
                              prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),

                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),

                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),

                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Phone',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 8),
                          TextFormField(
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            validator: (value) => viewModel.validatePhone(value),
                            controller: viewModel.phnctrlr,
                            decoration: InputDecoration(
                              hintText: "phone",
                              prefixIcon: const Icon(Icons.phone, color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),

                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),

                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),

                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                         // const SizedBox(height: 8),

                          // Password Field
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            validator: (value) => viewModel.validatePassword(value),
                            controller: viewModel.password,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "password",
                              prefixIcon: const Icon(Icons.lock_outlined, color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),

                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),

                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),

                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Confirm Password Field (new field to match UI)
                          const Text(
                            'Confirm password',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            validator: (value) => viewModel.validateConfirmPassword(value, viewModel.password.text),
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outlined, color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                               
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                               
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                               
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Terms and Conditions Checkbox
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: viewModel.accept,
                                  onChanged: (value) {
                                     viewModel.accept=value!;
                                     viewModel.notifyListeners();
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'I agree with the ',
                                    style: const TextStyle(color: Colors.black54),
                                    children: [
                                      TextSpan(
                                        text: 'Terms and Condition',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      TextSpan(
                                        text: ' and the ',
                                        style: const TextStyle(color: Colors.black54),
                                      ),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Sign Up Button
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
                                viewModel.register();
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Already have an account link
                          InkWell(
                            onTap: (){
                              viewModel.navlogin();
                            },
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Already have an account? ',
                                  style: const TextStyle(color: Colors.black54),
                                  children: [
                                    TextSpan(
                                      text: 'Login',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Hidden fields to maintain the original functionality
                          Opacity(
                            opacity: 0,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    return value!.length >= 2 ? null : "Enter valid name";
                                  },
                                  controller: viewModel.namecontroller,
                                ),
                                TextFormField(
                                  maxLength: 10,
                                  validator: (value) {
                                    return value!.length < 10 ? "Enter valid phone" : null;
                                  },
                                  controller: viewModel.phnctrlr,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => RegisterViewModel(),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
//
// import 'register_viewmodel.dart';
// import '../../../constants/assets.gen.dart';
// import '../../tools/screen_size.dart';
//
// class RegisterView extends StatelessWidget {
//   const RegisterView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<RegisterViewModel>.reactive(
//       builder: (context, viewModel, child) {
//      return   Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.green[200],
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Center(
//                 child: Form(
//                   key: viewModel.formkey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Assets.images.logo.image(
//                           height: 100,
//                           width: 100
//
//                       ),
//                       Center(child: Text("Register Now",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w900),),),
//                       SizedBox(height: 24,),
//                       TextFormField(
//                         validator: (value) {
//                           return value!.length >= 2 ? null : "Enter valid name";
//                         },
//                         controller: viewModel.namecontroller,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "name",
//                             labelText: "name"),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       TextFormField(
//
//                         maxLength: 10,
//                         validator: (value) {
//                           return value!.length < 10 ? "Enter valid phone" : null;
//                         },
//                         controller: viewModel.phnctrlr,
//                         decoration: InputDecoration(
//                             counterText: "",
//                             border: OutlineInputBorder(),
//                             hintText: "phone",
//                             labelText: "phone"),
//                       ),
//
//                       SizedBox(
//                         height: 5,
//                       ),
//                       TextFormField(
//                         validator: (value) {
//                           return value!.length >= 2 ? null : "Enter valid email";
//                         },
//                         controller: viewModel.emailctrlr,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "email",
//                             labelText: "email"),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       TextFormField(
//                         validator: (value) {
//                           return value!.length >= 2 ? null : "Enter valid password";
//                         },
//                         controller: viewModel.password,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "Password",
//                             labelText: "Password"),
//                       ),
//                       SizedBox(height: 32,),
//                       Container(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.greenAccent,
//
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5)
//                                 )
//                             ),
//                             onPressed: () async {
//                               viewModel.register();
//                             },
//                             child: Text("Register Now",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       viewModelBuilder: () => RegisterViewModel(),
//     );
//   }
// }
