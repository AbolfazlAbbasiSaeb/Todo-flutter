import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController FullnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String get fullname => FullnameController.text;
  String get mobile => mobileController.text;
  String get email => emailController.text;
  String get password => passwordController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'ثبت نام',
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
              controller: FullnameController,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.text,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                package: 'persian_fonts',
                fontFamily: 'Vazir',
              ),
              decoration: const InputDecoration(
                  labelText: 'نام و نام خانوادگی',
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
              controller: mobileController,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                package: 'persian_fonts',
                fontFamily: 'Vazir',
              ),
              decoration: const InputDecoration(
                  labelText: 'شماره موبایل',
                  suffix: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text("+98 | ",
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            package: 'persian_fonts',
                            fontFamily: 'Vazir',
                            fontSize: 16)),
                  ),
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
                    Helper.SignUp(fullname, mobile, email, password);
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
