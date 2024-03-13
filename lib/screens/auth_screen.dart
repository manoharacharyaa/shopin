import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/colors/colors.dart';
import 'package:shopin/providers/auth.dart';
import 'package:shopin/widgets/custom_formfield.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int? tabVal;
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
  }

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Auth>(context, listen: false).signUp(
      signupEmailController.text,
      signupPasswordController.text,
    );
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Auth>(context, listen: false).login(
      loginEmailController.text,
      loginPasswordController.text,
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    final auth = Provider.of<Auth>(context);
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
                                    obscureText: auth.isVisible ? false : true,
                                    controller: signupPasswordController,
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 5) {
                                        return 'Password is too short!';
                                      }
                                      return null;
                                    },
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        auth.visible();
                                      },
                                      icon: auth.isVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                    onChanged: (_) {
                                      auth.validator(
                                        signupPasswordController.text,
                                        confirmPasswordController.text,
                                      );
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
                                      auth.validator(
                                        signupPasswordController.text,
                                        confirmPasswordController.text,
                                      );
                                    },
                                    suffixIcon:
                                        confirmPasswordController.text.isEmpty
                                            ? null
                                            : auth.isEqual == true
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
                                  CustomButton(
                                    isLoading: _isLoading,
                                    onPressed: () {
                                      _submit();
                                      _signUp();
                                    },
                                    text: 'SignUp',
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
                                  ),
                                  const SizedBox(height: 25),
                                  CustomFormField(
                                    deviceSize: deviceSize,
                                    hintText: 'Password',
                                    obscureText: auth.isVisible ? false : true,
                                    controller: loginPasswordController,
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 5) {
                                        return 'Password is too short!';
                                      }
                                      return null;
                                    },
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        auth.visible();
                                      },
                                      icon: auth.isVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  CustomButton(
                                    isLoading: _isLoading,
                                    onPressed: () {
                                      _submit();
                                      _login();
                                    },
                                    text: 'Login',
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

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.text,
  });

  final bool isLoading;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: MaterialButton(
        onPressed: onPressed,
        height: 50,
        minWidth: double.infinity,
        color: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: white,
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ),
    );
  }
}
