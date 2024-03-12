import 'package:flutter/material.dart';
import 'package:shopin/colors/colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int? tabVal;
  bool isVisible = false;
  bool isEqual = false;
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();

    // setState(() {
    //   _isLoading = true;
    // });
    // setState(() {
    //   _isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 19, 71, 243),
                  Color.fromARGB(255, 1, 23, 221),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          Center(
            child: Container(
              height: tabVal == 1
                  ? deviceSize.height * 0.45
                  : deviceSize.height * 0.55,
              width: deviceSize.width * 0.90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 212, 227, 255).withOpacity(0.5),
                    const Color.fromARGB(255, 204, 222, 238).withOpacity(0.5),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Form(
                key: _formKey,
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        onTap: (value) {
                          setState(() {
                            tabVal = value;
                          });
                        },
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        dividerColor: Colors.transparent,
                        indicatorColor: white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: 40),
                        tabs: [
                          Text(
                            'SignUp',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Login',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  CustomFormField(
                                    deviceSize: deviceSize,
                                    hintText: 'Email',
                                    keyboardType: TextInputType.emailAddress,
                                    controller: signupEmailController,
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Invalid email!';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  CustomFormField(
                                    deviceSize: deviceSize,
                                    hintText: 'Password',
                                    obscureText: isVisible ? false : true,
                                    controller: signupPasswordController,
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 5) {
                                        return 'Password is too short!';
                                      }
                                      return null;
                                    },
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      icon: isVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                    onChanged: (_) {
                                      if (signupEmailController.text !=
                                          confirmPasswordController.text) {
                                        setState(() {
                                          isEqual = false;
                                        });
                                      } else {
                                        setState(() {
                                          isEqual = true;
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  CustomFormField(
                                    deviceSize: deviceSize,
                                    hintText: 'Confirm Password',
                                    obscureText: true,
                                    controller: confirmPasswordController,
                                    validator: (value) {
                                      if (value !=
                                          signupPasswordController.text) {
                                        return 'Passwords do not match!';
                                      }
                                      return null;
                                    },
                                    onChanged: (_) {
                                      if (signupPasswordController.text !=
                                          confirmPasswordController.text) {
                                        setState(() {
                                          isEqual = false;
                                        });
                                      } else {
                                        setState(() {
                                          isEqual = true;
                                        });
                                      }
                                    },
                                    suffixIcon:
                                        confirmPasswordController.text.isEmpty
                                            ? null
                                            : isEqual == true
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: green,
                                                  )
                                                : const Icon(
                                                    Icons.cancel_rounded,
                                                    color: red,
                                                  ),
                                  ),
                                  const SizedBox(height: 50),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: MaterialButton(
                                      onPressed: _submit,
                                      height: 50,
                                      minWidth: deviceSize.width,
                                      color: Colors.black38,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'SignUp',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  CustomFormField(
                                    deviceSize: deviceSize,
                                    hintText: 'Email',
                                    controller: loginEmailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Invalid email!';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _authData['email'] = value!;
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  CustomFormField(
                                    deviceSize: deviceSize,
                                    hintText: 'Password',
                                    obscureText: isVisible ? false : true,
                                    controller: loginPasswordController,
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 5) {
                                        return 'Password is too short!';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _authData['password'] = value!;
                                    },
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      icon: isVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: MaterialButton(
                                      onPressed: _submit,
                                      height: 50,
                                      minWidth: deviceSize.width,
                                      color: Colors.black38,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Login',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
        ],
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.deviceSize,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.onPressed,
    this.icon,
    this.suffixIcon,
    this.keyboardType,
    this.onSaved,
    this.validator,
    this.onChanged,
  });

  final String hintText;
  final Size deviceSize;
  final bool obscureText;
  final TextEditingController controller;
  final void Function()? onPressed;
  final IconData? icon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: white,
                ),
              ),
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              suffixIcon: suffixIcon,
            ),
            cursorColor: white,
            cursorErrorColor: Colors.red,
            onSaved: onSaved,
            validator: validator,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
