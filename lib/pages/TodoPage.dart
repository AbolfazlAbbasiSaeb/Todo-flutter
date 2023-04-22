import 'dart:async';
import 'dart:convert';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:todo/Helper.dart';
import 'package:http/http.dart' as http;

class TodoPage extends StatefulWidget {
  final String Category_id;
  const TodoPage({super.key, required this.Category_id});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  TextEditingController NameController = TextEditingController();
  TextEditingController NameEditController = TextEditingController();
  TextEditingController DescriptionEditController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();

  String get Name => NameController.text;
  String get Description => DescriptionController.text;
  String get NameNew => NameEditController.text;
  String get NewDescription => DescriptionEditController.text;
  StreamController<List<TodosData>> _streamController = StreamController();
  Future<void> fetchData() async {
    // final user_id = await Helper.sendDataToServer();
    final category_id = widget.Category_id;
    while (true) {
      final response = await http
          .get(Uri.parse('https://api.abolfazlabasi.ir/api/todo/$category_id'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<TodosData> Categories = [];
        data.forEach((item) {
          final DataCategories = TodosData.fromJson(item);
          Categories.add(DataCategories);
        });
        _streamController.sink.add(Categories);
      }
      await Future.delayed(Duration(seconds: 2));
    }
  }

  EditTodo(String id) async {
    final response = await http.post(
        Uri.parse('https://api.abolfazlabasi.ir/api/todo/edit/$id'),
        body: {'title': NameNew, 'description': NewDescription});
    if (response.statusCode == 200) {}
  }

  ChangeStatus(String id, String status) async {
    final response = await http.post(
        Uri.parse('https://api.abolfazlabasi.ir/api/todo/$id'),
        body: {'status': status});
    if (response.statusCode == 200) {}
  }

  CreateTodo() async {
    // final user_id = await Helper.sendDataToServer();
    final Category_id = widget.Category_id;
    final response = await http
        .post(Uri.parse("https://api.abolfazlabasi.ir/api/CreateTodo"), body: {
      'title': Name,
      'category_id': Category_id.toString(),
      'description': Description
    });
  }

  DeleteTodo(String id) async {
    final response = await http
        .get(Uri.parse('https://api.abolfazlabasi.ir/api/todo/delete/$id'));
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
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "میز کار",
          style: TextStyle(
            color: Colors.black,
            package: 'persian_fonts',
            fontFamily: 'Vazir',
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<TodosData>>(
        stream: _streamController.stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<TodosData>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final Data = snapshot.data![index];
                final name = Data.title;
                final description = Data.description;
                var status;
                if (Data.status == "0") {
                  status = "هنوز انجام نشده";
                } else if (Data.status == "1") {
                  status = "درحال انجام";
                } else if (Data.status == "2") {
                  status = "انجام شده";
                }
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  Data.description,
                                  style: TextStyle(
                                    color: Colors.black,
                                    package: 'persian_fonts',
                                    fontFamily: 'Vazir',
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 100,
                                child: ElevatedButton(
                                  child: const Text('برگشت'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Card(
                    child: ListTile(
                        subtitle: Text(
                          status.toString(),
                          style: TextStyle(
                            package: 'persian_fonts',
                            fontFamily: 'Vazir',
                            fontSize: 15,
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "وضعیت: $status",
                                                  style: TextStyle(
                                                    package: 'persian_fonts',
                                                    fontFamily: 'Vazir',
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  if (Data.status != "2")
                                                    Container(
                                                      height: 40,
                                                      width: 100,
                                                      child: ElevatedButton(
                                                        child: const Text(
                                                            'انجام شده'),
                                                        onPressed: () async {
                                                          await ChangeStatus(
                                                              Data.id, "2");
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  if (Data.status != "1" &&
                                                      Data.status != "2")
                                                    Container(
                                                      height: 40,
                                                      width: 100,
                                                      child: ElevatedButton(
                                                        child: const Text(
                                                            'درحال انجام'),
                                                        onPressed: () async {
                                                          await ChangeStatus(
                                                              Data.id, "1");
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Container(
                                                height: 40,
                                                width: 100,
                                                child: ElevatedButton(
                                                  child: const Text('برگشت'),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(Icons.more_horiz_rounded,
                                      color: Colors.green),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      NameEditController.text = name;
                                      DescriptionEditController.text =
                                          Data.description;
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
                                                textDirection:
                                                    TextDirection.rtl,
                                                textAlign: TextAlign.right,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: TextField(
                                                    controller:
                                                        NameEditController,
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType
                                                        .emailAddress,
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
                                                                color: Color
                                                                    .fromARGB(
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: TextField(
                                                    controller:
                                                        DescriptionEditController,
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: const TextStyle(
                                                      package: 'persian_fonts',
                                                      fontFamily: 'Vazir',
                                                    ),
                                                    decoration: const InputDecoration(
                                                        labelText: 'توضیحات',
                                                        border:
                                                            OutlineInputBorder(),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color: Color.fromARGB(
                                                                    115, 80, 77, 77))),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                            borderSide: BorderSide(
                                                                width: 2,
                                                                color: Color.fromARGB(213, 48, 46, 46))),
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
                                                      await EditTodo(Data.id);
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
                                  width: 10,
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
                                        await DeleteTodo(Data.id);
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
                              Data.title,
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
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, bottom: 10),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                    controller: NameController,
                                    textAlign: TextAlign.center,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, bottom: 10),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                    controller: DescriptionController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.emailAddress,
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(
                                      package: 'persian_fonts',
                                      fontFamily: 'Vazir',
                                    ),
                                    decoration: const InputDecoration(
                                        labelText: 'توضیحات',
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
                                      await CreateTodo();
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

class TodosData {
  final String id;
  final String title;
  final String status;
  final String description;
  final String category_id;

  TodosData({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.category_id,
  });

  factory TodosData.fromJson(Map<String, dynamic> json) {
    return TodosData(
        id: json['id'].toString(),
        title: json['title'].toString(),
        status: json['status'].toString(),
        category_id: json['category_id'].toString(),
        description: json['description'].toString());
  }
}
