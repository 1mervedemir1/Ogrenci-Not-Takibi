class StudentValidationMixin {

  String validateFirstName(String value){
    if(value.length<5){
      return "İsim en az 5 karakterli olmalıdır";
    }
  }
  String validateLastName(String value){
    if(value.length<5){
      return "Soyisim en az 5 karakterli olmalıdır";
    }
  }
  String validateGrade(String value){
    var grade=int.parse(value);
    if(grade<0  || grade>100){
      return "Lütfen doğru aralıkta not giriniz";
    }
  }
}