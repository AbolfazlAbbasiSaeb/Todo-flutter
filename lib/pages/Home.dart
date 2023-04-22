import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:todo/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:todo/pages/login.dart';
import 'package:todo/pages/todoPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  TextEditingController NameController = TextEditingController();
  TextEditingController NameEditController = TextEditingController();
  String get Name => NameController.text;
  String get NameNew => NameEditController.text;

  StreamController<List<CategoriesData>> _streamController = StreamController();
  Future<void> fetchData() async {
    final user_id = await Helper.sendDataToServer();
    while (true) {
      final response = await http.get(
          Uri.parse('https://api.abolfazlabasi.ir/api/categories/$user_id'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<CategoriesData> Categories = [];
        data.forEach((item) {
          final DataCategories = CategoriesData.fromJson(item);
          Categories.add(DataCategories);
        });
        _streamController.sink.add(Categories);
      }
      await Future.delayed(Duration(seconds: 2));
    }
  }

  EditCategory(String id) async {
    final response = await http.post(
        Uri.parse('https://api.abolfazlabasi.ir/api/category/edit/$id'),
        body: {'name': NameNew});
    if (response.statusCode == 200) {}
  }

  CreateCategory() async {
    final user_id = await Helper.sendDataToServer();
    final response = await http.post(
        Uri.parse("https://api.abolfazlabasi.ir/api/CreateCategory"),
        body: {'name': Name, 'user_id': user_id.toString()});
  }

  DeleteCategory(String id) async {
    final response = await http
        .get(Uri.parse('https://api.abolfazlabasi.ir/api/category/delete/$id'));
    if (response.statusCode == 200) {
      // setState(() {
      //   QuickAlert.show(
      //     context: context,
      //     type: QuickAlertType.success,
      //     text: 'Transaction Completed Successfully!',
      //   );
      // });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () async {
                  await Helper.RemoveToken();
                  Get.offAll(LoginPage());
                },
                child: Icon(Icons.exit_to_app, color: Colors.black)),
          ),
        ],
        title: const Text(
          "پروژه ها",
          style: TextStyle(
            color: Colors.black,
            package: 'persian_fonts',
            fontFamily: 'Vazir',
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<CategoriesData>>(
        stream: _streamController.stream,
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoriesData>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final Data = snapshot.data![index];
                final name = Data.name;
                return GestureDetector(
                  onTap: () {
                    Get.to(TodoPage(Category_id: Data.id));
                  },
                  child: Card(
                    child: ListTile(
                        title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  NameEditController.text = name;
                                });
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 900,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            'ویرایش',
                                            style: TextStyle(
                                              package: 'persian_fonts',
                                              fontFamily: 'Vazir',
                                            ),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: TextField(
                                                controller: NameEditController,
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: const TextStyle(
                                                  package: 'persian_fonts',
                                                  fontFamily: 'Vazir',
                                                ),
                                                decoration: const InputDecoration(
                                                    labelText: 'عنوان',
                                                    border:
                                                        OutlineInputBorder(),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Color.fromARGB(
                                                                    115,
                                                                    80,
                                                                    77,
                                                                    77))),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(15)),
                                                        borderSide: BorderSide(width: 2, color: Color.fromARGB(213, 48, 46, 46))),
                                                    labelStyle: TextStyle(package: 'persian_fonts', fontFamily: 'Vazir', fontSize: 22, color: Colors.black)),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                child: const Text('ویرایش'),
                                                onPressed: () async {
                                                  await EditCategory(Data.id);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              ElevatedButton(
                                                child: const Text('برگشت'),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.edit_square,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  text: 'آیا مطمئن هستید؟',
                                  confirmBtnText: 'خیر',
                                  title: '$name',
                                  cancelBtnTextStyle: const TextStyle(
                                    package: 'persian_fonts',
                                    fontFamily: 'Vazir',
                                  ),
                                  confirmBtnTextStyle: const TextStyle(
                                      package: 'persian_fonts',
                                      fontFamily: 'Vazir',
                                      color: Colors.white),
                                  cancelBtnText: 'بله',
                                  onCancelBtnTap: () async {
                                    await DeleteCategory(Data.id);
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                  // onConfirmBtnTap: () {},
                                  confirmBtnColor: Colors.red,
                                );
                              },
                              child: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          Data.name,
                          style: TextStyle(
                            package: 'persian_fonts',
                            fontFamily: 'Vazir',
                          ),
                        ),
                      ],
                    )),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 700,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                'برای شروع لطفا یک نام برای بورد جدید وارد کنید.',
                                style: TextStyle(
                                  package: 'persian_fonts',
                                  fontFamily: 'Vazir',
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                    controller: NameController,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.emailAddress,
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(
                                      package: 'persian_fonts',
                                      fontFamily: 'Vazir',
                                    ),
                                    decoration: const InputDecoration(
                                        labelText: 'عنوان',
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    115, 80, 77, 77))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(
                                                    213, 48, 46, 46))),
                                        labelStyle: TextStyle(
                                            package: 'persian_fonts',
                                            fontFamily: 'Vazir',
                                            fontSize: 22,
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    child: const Text('افزودن'),
                                    onPressed: () async {
                                      await CreateCategory();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                    child: const Text('برگشت'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(Icons.add_box_rounded,
                      color: Colors.blueAccent, size: 60),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class CategoriesData {
  final String id;
  final String name;
  final String status;
  final String user_id;

  CategoriesData({
    required this.id,
    required this.name,
    required this.status,
    required this.user_id,
  });

  factory CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
        id: json['id'].toString(),
        name: json['name'].toString(),
        status: json['status'].toString(),
        user_id: json['user_id'].toString());
  }
}
