class Student{
  int id;
  String firstName;
  String lastName;
  int grade;
  String _status; //başına çizgi eklemek o kullanılmıyor demek

  Student.withId(int id,String firstName, String lastName, int grade){
    this.id=id;
    this.firstName=firstName;
    this.lastName=lastName;
    this.grade=grade;
    //this.status="Geçti!";
  }

  Student (String firstName, String lastName, int grade){
    this.firstName=firstName;
    this.lastName=lastName;
    this.grade=grade;
    //this.status="Geçti!";
  }

  Student.withOut(){ } // parametre almaz hiç çağırıldığında


  String get getStatus{
    String message="";
    if(this.grade>=50){
      message="geçti";
    }
    else{
      message="kaldı";
    }
    return message;
  }
}
