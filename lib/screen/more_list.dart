import 'package:flutter/material.dart';
import 'package:quizz_app/screen/add_list.dart';
import 'package:quizz_app/widget/items.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editscreen.dart';

//Đây là màn hình đầu tiên này
class Morelist extends StatefulWidget {
  static const String routeName = "/list";
  const Morelist({super.key});

  @override
  State<Morelist> createState() => _MorelistState();
}

class _MorelistState extends State<Morelist> {
  //Khởi tạo list rỗng gồm nhiều item mang kiểu dữ liệu String
  List<TodoModel> todolist = [];

  List<Color> colors = [
    Colors.pinkAccent,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.purple,
  ];

  @override
  void initState() {
    super.initState();
    // _getToDoListFromPref();
  }

  // Future<void> _getToDoListFromPref() async {
  //   //dòng 36 bắt buộc phải có nếu muốn truy cập tới "SharedPreferences".
  //   //dòng 36 như kiểu, gọi chủ nhà mở cửa nhà kho ấy :D
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     //dòng này thì lấy dữ liệu từ "nhà kho" có từ khóa "todolist"
  //     //và gán nó cho titles, nếu ko có từ khóa đó thì gán là list rỗng "[]"
  //     //từ khóa ở đây phải trùng với từ khóa bạn gọi setStringList bên dưới.
  //     titles = prefs.getStringList("todolist") ?? [];
  //     contents = prefs.getStringList("contentList") ?? [];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 90),
          child: const Text(
            'Home',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddList(onAdd: (todoCuaKhang) {
                    setState(() {
                      todolist.add(todoCuaKhang);
                    });
                  })));
        },
        child: const Icon(Icons.add),
      ),
      body: todolist.isNotEmpty
          ? Column(children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: todolist.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 80,
                          decoration: BoxDecoration(
                              color: colors[(index % colors.length)]
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: ListTile(
                              //Widget Text cần biến mang kiểu dữ liệu là String,
                              //nên phải truyền biến mang dữ liệu String vào, ở đây là titles[index]
                              title: Text(todolist[index].title),
                              subtitle: Text(todolist[index].content),
                              leading: const Icon(Icons.person),
                              trailing: SizedBox(
                                width: 200,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(

                                        ///từ khóa [async] và [await], xem thêm hàm bất đồng bộ :D chứ khó nói
                                        ///bth là hàm sẽ đi từ trên xuống dưới, nhưng với async await
                                        ///, thì nó sẽ đợi đến khi dòng await thực hiện xong rồi mới đi tiếp.
                                        onTap: () async {
                                          //như ở đây, nó đợi dòng 83 chạy xong, rồi mới thực hiện tiếp
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return EditScreen(
                                                  todo: todolist[index],
                                                );
                                              },
                                            ),
                                          );
                                          // ignore: avoid_print
                                          print("result $result");
                                          if (result != null) {
                                            var resultMap =
                                                result as Map<String, String>;
                                            // kiểm tra khác null, tức là dòng 83 có dữ liệu trả về,
                                            // thì mình mới thực hiện trong {}
                                            setState(() {
                                             todolist[index] =
                                                  resultMap["title"]! as TodoModel;
                                         
                                            });
                                            final pref = await SharedPreferences
                                                .getInstance();
                                            pref.setStringList(
                                                "todolist", title);
                                            pref.setStringList(
                                                "contentList", content);
                                          }
                                        },
                                        child: const Icon(Icons.edit)),
                                    InkWell(
                                        onTap: () async {
                                          setState(() {
                                            todolist.removeAt(index);
                                          });
                                          // final pref = await SharedPreferences
                                          //     .getInstance();
                                          // pref.setStringList(
                                          //     "todolist", todolist);
                                          // pref.setStringList(
                                          //     "contentList", todolist);
                                        },
                                        child: const Icon(Icons.delete)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })))
            ])
          : const Center(
              child: Text("No Record Found"),
            ),
    );
  }
}
