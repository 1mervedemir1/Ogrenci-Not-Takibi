import 'package:flutter/material.dart';
import 'package:flutter_egitim_demo/models/student.dart';
import 'package:flutter_egitim_demo/validation/student_validator.dart';

class studentAdd extends StatefulWidget{
  List<Student> students;  // su 3 satırlık kısmı yeni öğrenciyi listeye ekleyip göstermek için yazdık
  studentAdd(List<Student> students) {
    this.students=students;
  }
  @override
  State<StatefulWidget> createState() {
    return _studentAddState(students);
  }
}
class _studentAddState extends State with StudentValidationMixin{
  List<Student> students; //buraya da yapıyoruz üstteki işlemi

  var student=Student.withOut();
  var formKey=GlobalKey<FormState>();  //bu bana tüm formların içine erişmemi sağlar key e atarım yani

  _studentAddState(List<Student> students) {
    this.students=students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Ekleme Sayfası"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              buildFirstNameField(),
              buildLastNameField(),
              buildGradeField(),
              buildSubmitButton()
            ],
          ),
        ),
      ),
    );


  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Adı: ", hintText: "merve"), //ilk kısım istenilen şeyi belirtecek ikincisi yardım gibi kullanıcıya
      validator: validateFirstName,
      onSaved: (String value){
        student.firstName=value;
      },
    );
  }
  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Soyadı: ", hintText: "demir"), //ilk kısım istenilen şeyi belirtecek ikincisi yardım gibi kullanıcıya
      validator: validateLastName,
      onSaved: (String value){
        student.lastName=value;
      },
    );
  }
  Widget buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrencinin Aldığı Not: ", hintText: "0-100"), //ilk kısım istenilen şeyi belirtecek ikincisi yardım gibi kullanıcıya
      validator: validateGrade,
      onSaved: (String value){
        student.grade=int.parse(value);
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: (){
        if(formKey.currentState.validate()){ // değerler kurallara uyuyorsa validator e yani şuraya bakıyor
          formKey.currentState.save(); //onSaved lerin içindekileri yap
          students.add(student);
          saveStudent();
          Navigator.pop(context); // ekledikten sonra beni otomatik anasayfaya gönderecek
        }
      },
    );
  }

  void saveStudent() {
    print(student.firstName);
    print(student.lastName);
    print(student.grade);
  }

}