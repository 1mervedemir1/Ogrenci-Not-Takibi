import 'package:flutter/material.dart';
import 'package:flutter_egitim_demo/models/student.dart';
import 'package:flutter_egitim_demo/validation/student_validator.dart';

class studentEdit extends StatefulWidget{
  Student selectedStudents;  // su 3 satırlık kısmı yeni öğrenciyi listeye ekleyip göstermek için yazdık
  studentEdit(Student selectedStudents) {
    this.selectedStudents=selectedStudents;
  }
  @override
  State<StatefulWidget> createState() {
    return _studentAddState(selectedStudents);
  }
}
class _studentAddState extends State with StudentValidationMixin{
  Student selectedStudents; //buraya da yapıyoruz üstteki işlemi

  var student=Student.withOut();
  var formKey=GlobalKey<FormState>();  //bu bana tüm formların içine erişmemi sağlar key e atarım yani

  _studentAddState(Student selectedStudents) {
    this.selectedStudents=selectedStudents;
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
      initialValue: selectedStudents.firstName, //güncelleye tıkladığında hazırda kaydedilmiş verileri gelecek
      decoration: InputDecoration(labelText: "Öğrenci Adı: ", hintText: "merve"), //ilk kısım istenilen şeyi belirtecek ikincisi yardım gibi kullanıcıya
      validator: validateFirstName,
      onSaved: (String value){
        selectedStudents.firstName=value;
      },
    );
  }
  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudents.lastName,
      decoration: InputDecoration(labelText: "Öğrenci Soyadı: ", hintText: "demir"), //ilk kısım istenilen şeyi belirtecek ikincisi yardım gibi kullanıcıya
      validator: validateLastName,
      onSaved: (String value){
        selectedStudents.lastName=value;
      },
    );
  }
  Widget buildGradeField() {
    return TextFormField(
      initialValue: selectedStudents.grade.toString(),
      decoration: InputDecoration(labelText: "Öğrencinin Aldığı Not: ", hintText: "0-100"), //ilk kısım istenilen şeyi belirtecek ikincisi yardım gibi kullanıcıya
      validator: validateGrade,
      onSaved: (String value){
        selectedStudents.grade=int.parse(value);
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: (){
        if(formKey.currentState.validate()){ // değerler kurallara uyuyorsa validator e yani şuraya bakıyor
          formKey.currentState.save(); //onSaved lerin içindekileri yap
          saveStudent();
          Navigator.pop(context); // ekledikten sonra beni otomatik anasayfaya gönderecek
        }
      },
    );
  }

  void saveStudent() {
    print(selectedStudents.firstName);
    print(selectedStudents.lastName);
    print(selectedStudents.grade);
  }

}