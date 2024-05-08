import 'package:flutter/material.dart';
import 'package:se7ety/core/functions/email_validate.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/app_text_style.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isVisable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Image.asset(
          'assets/logo.png',
          height: 200,
        ),
        const SizedBox(height: 20),
        Text(
          'سجل حساب جديد كـ ',
          style: getTitleStyle(),
        ),
        const SizedBox(height: 30),
        TextFormField(
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
          // controller: _emailController,
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
        )
      ])),
    );
  }
}
