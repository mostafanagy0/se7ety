// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/functions/email_validate.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/app_text_style.dart';
import 'package:se7ety/core/widgets/custom_error_daylog.dart';
import 'package:se7ety/core/widgets/custom_looding_dilog.dart';
import 'package:se7ety/feature/auth/presentation/view/register_view.dart';
import 'package:se7ety/feature/auth/presentation/view_model/auth_cubit.dart';
import 'package:se7ety/feature/auth/presentation/view_model/auth_states.dart';
import 'package:se7ety/feature/doctor/home/nav_bar.dart';
import 'package:se7ety/feature/patient/home/presentation/nav_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.index});
  final int index;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isVisable = true;

  String handelUserType() {
    return widget.index == 0 ? 'دكتور ' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (State is AuthSuccesState) {
          if (widget.index == 0) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const DoctorMainPage(),
                ),
                (route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const patientMainPage(),
                ),
                (route) => false);
          }
        } else if (state is AuthFailerState) {
          Navigator.of(context).pop();
          ShowErrorDilog(context, state.error);
        } else {
          showLoaderDialog(context);
        }
      },
      child: Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _key,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Column(children: [
                          Image.asset(
                            'assets/logo.png',
                            height: 200,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'سجل دخول الان كـ' "${handelUserType()}",
                            style: getTitleStyle(),
                          ),
                          const SizedBox(height: 39),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.end,
                            decoration: const InputDecoration(
                              hintText: 'Mostafa@example.com',
                              prefixIcon: Icon(Icons.email_rounded),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك ادخل الايميل';
                              } else if (!emailValidate(value)) {
                                return 'من فضلك اخل ايميل صحيح ';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            textAlign: TextAlign.end,
                            style: TextStyle(color: AppColors.black),
                            obscureText: isVisable,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: '********',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisable = !isVisable;
                                    });
                                  },
                                  icon: Icon((isVisable)
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off_rounded)),
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' من فضلك ادخل كلمه السر ';
                              } else {
                                return null;
                              }
                            },
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(top: 5, right: 10),
                            child: Text(
                              'نسيت كلمة السر ؟',
                              style: getsmallStyle(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_key.currentState!.validate()) {
                                    await context.read<AuthCubit>().login(
                                        _emailController.text,
                                        _passwordController.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.color1,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: Text(
                                  "تسجيل الدخول",
                                  style: getTitleStyle(color: AppColors.white),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ليس لدي حساب ؟',
                                  style: getbodyStyle(color: AppColors.black),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterView(),
                                      ));
                                    },
                                    child: Text(
                                      'سجل الان',
                                      style:
                                          getbodyStyle(color: AppColors.color1),
                                    ))
                              ],
                            ),
                          ),
                        ]))))),
      ),
    );
  }
}
