import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_egitim_demo/models/student.dart';
import 'package:flutter_egitim_demo/screens/student_add.dart';
import 'package:flutter_egitim_demo/screens/student_edit.dart';


String mesaj="Öğrenci Takip Sistemi";
void main() {

  runApp(MaterialApp(
    home: myApp()
  ));
}

class myApp extends StatefulWidget{ //flexible işlemleri için stateful u seçmelisin
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  String durumMesaj="";

  String notmesaj1="";
  Student selectedStudent=Student.withId(0,"","", 0); //genelde işyerleri böyle yazıyormuş en başta erişebilmek için sorunsuz

  List<Student> students=[new Student.withId(1,"beyza", "yaldız", 52),new Student.withId(2,"ipek", "yaşar", 10)];

  //var kisiler=["merve demir","selim demir","neslihan demir","sabri demir"];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(mesaj),
      ),
      body: buildBody(context), //yeni metot oluşturduk buildbody
    );
  }



  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded( //List yapısı olunca bunu koymayınca düzgün çalışmıyor hata veriyor
            child: ListView.builder( //builder yapısında da itemcount ve itembuilder koymak zorundasın
                itemCount: students.length,
                itemBuilder: (BuildContext context, int i){
                  return ListTile( //bu ListTile denilen şey alttaki özellikleri sağlayabiliyor kolayca
                    leading: CircleAvatar(backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2018/06/27/07/45/student-3500990_960_720.jpg")), //foto
                    title: Text(students[i].firstName+" "+students[i].lastName),
                    subtitle: Text("Öğrencinin aldığı not: "+students[i].grade.toString()+" ["+students[i].getStatus+"]"),
                    trailing: buildStatusIcon(students[i].grade), //icon istersen
                    onTap: (){ //tıklayınca ne olsun?
                      setState(() {
                        selectedStudent= students[i];
                      });
                      print(selectedStudent.firstName); //bu run kısmında görünecek sadece
                    },
                  );
                }
            )
        ),

        Text("Öğreci: "+selectedStudent.firstName), //buton üzeri

        Row( //birden çok yanyana buton olacağı için row içine yazarsın
          children: [
            Flexible( //buton görüntü detayları bunun içinde
              fit: FlexFit.tight,
              flex: 1, //buton size
                child: RaisedButton(
                  color: Colors.amberAccent, //buton color
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 1), //üstteki ve alttakinin arasındaki boşluk
                      Text("Yeni Kayıt"),
                    ],
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> studentAdd(students))); //add e verdiğimiz parametre tamamen studentadd deki baştaki 3 satılık koddan dolayı
                  },
                ),

            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(width: 1),
                    Text("Güncelle"),
                  ],
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> studentEdit(selectedStudent)));
                },
              ),

            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.amberAccent,
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 1),
                    Text("Sil"),
                  ],
                ),
                onPressed: (){
                  setState(() {
                    students.remove(selectedStudent);
                  });

                  String mesaj=selectedStudent.firstName+" silindi";
                  mesajGoster(context,mesaj);
                },
              ),

            ),
          ],
        ),
      ],
    );
  }

  void mesajGoster(BuildContext context,String mesaj){
    var alert= AlertDialog(
      title: Text("İşlem Sonucu"),
      content: Text(mesaj),
    );
    showDialog(context: context,builder: (BuildContext context)=>alert);
  }

  Widget buildStatusIcon(int grade) { //geçip geçmediği durumunun iconları
    if(grade>=60){
      return Icon(Icons.done);
    }
    else if(grade>=45 ){
      return Icon(Icons.warning_amber_outlined);
    }
    else{
      return Icon(Icons.dangerous);
    }
  }
}


