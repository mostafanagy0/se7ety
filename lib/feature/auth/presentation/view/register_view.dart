import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/functions/email_validate.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/app_text_style.dart';
import 'package:se7ety/core/widgets/custom_error_daylog.dart';
import 'package:se7ety/core/widgets/custom_looding_dilog.dart';
import 'package:se7ety/feature/auth/presentation/view/doctor_register_data.dart';
import 'package:se7ety/feature/auth/presentation/view/login_view.dart';
import 'package:se7ety/feature/auth/presentation/view_model/auth_cubit.dart';
import 'package:se7ety/feature/auth/presentation/view_model/auth_states.dart';
import 'package:se7ety/feature/patient/home/presentation/nav_bar.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.index});
  final int index;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayName = TextEditingController();

  bool isVisable = true;
  String handelUserType(int index) {
    return index == 0 ? 'دكتور ' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccesState) {
          if (widget.index == 0) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const DoctorUplodeData(),
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
          ShowErrorDilog(context, state.error);
        } else {
          showLoaderDialog(context);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Form(
                key: _key,
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'سجل حساب جديد كـ "${handelUserType(widget.index)}"',
                        style: getTitleStyle(),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _displayName,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          hintText: 'الاسم',
                          hintStyle: getbodyStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return 'من فضلك ادخل الاسم';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          hintText: 'Mostafa@example.com',
                          prefixIcon: Icon(Icons.email_rounded),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل الايميل';
                          } else if (!emailValidate(value)) {
                            return 'من فضلك ادخل الايميل صحيحا';
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
                            hintText: '*********',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisable = !isVisable;
                                  });
                                },
                                icon: Icon((isVisable)
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off_rounded)),
                            prefixIcon: const Icon(Icons.lock)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 25),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                context.read<AuthCubit>().resisterDoctore(
                                    _emailController.text,
                                    _displayName.text,
                                    _passwordController.text);
                              } else {
                                context.read<AuthCubit>().resisterPatient(
                                    _displayName.text,
                                    _emailController.text,
                                    _passwordController.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.color1,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(25))),
                            child: Text(
                              "تسجيل حساب",
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
                                  'لدي حساب ؟',
                                  style: getbodyStyle(color: AppColors.black),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            LoginView(index: widget.index),
                                      ));
                                    },
                                    child: Text(
                                      'سجل دخول',
                                      style:
                                          getbodyStyle(color: AppColors.color1),
                                    ))
                              ])),
                    ]))),
          ),
        ),
      ),
    );
  }
}
