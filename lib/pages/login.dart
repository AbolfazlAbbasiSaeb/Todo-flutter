import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Helper.dart';
import 'package:todo/pages/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String get email => emailController.text;
  String get password => passwordController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'ورود',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Vazir',
              fontSize: 19,
              fontWeight: FontWeight.bold,
              package: 'persian_fonts'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "برای ادامه لطفا موارد زیر را تکمیل کنید",
                  style: TextStyle(
                      package: 'persian_fonts',
                      fontFamily: 'Vazir',
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                ),
              )
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              controller: emailController,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                package: 'persian_fonts',
                fontFamily: 'Vazir',
              ),
              decoration: const InputDecoration(
                  labelText: 'ایمیل',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(115, 80, 77, 77))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(213, 48, 46, 46))),
                  labelStyle: TextStyle(
                      package: 'persian_fonts',
                      fontFamily: 'Vazir',
                      fontSize: 22,
                      color: Colors.black)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              controller: passwordController,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.visiblePassword,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                package: 'persian_fonts',
                fontFamily: 'Vazir',
              ),
              decoration: InputDecoration(
                  labelText: 'کلمه عبور',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(115, 80, 77, 77))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(213, 48, 46, 46))),
                  labelStyle: TextStyle(
                      package: 'persian_fonts',
                      fontFamily: 'Vazir',
                      fontSize: 22,
                      color: Colors.black)),
            ),
          )
        ]),
      ),
      bottomNavigationBar: ButtonBar(
          alignment: MainAxisAlignment.center,
          buttonPadding: const EdgeInsets.all(50),
          children: [
            Container(
              height: 50,
              width: 500,
              child: ElevatedButton(
                  onPressed: () {
                    Helper.Login(email, password);
                  },
                  child: const Text(
                    'ورود',
                    style: TextStyle(
                        package: 'persian_fonts',
                        fontFamily: 'Vazir',
                        fontSize: 20),
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: 500,
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(SignUpPage());
                  },
                  child: const Text(
                    'ثبت نام',
                    style: TextStyle(
                        package: 'persian_fonts',
                        fontFamily: 'Vazir',
                        fontSize: 20),
                  )),
            )
          ]),
    );
  }
}
