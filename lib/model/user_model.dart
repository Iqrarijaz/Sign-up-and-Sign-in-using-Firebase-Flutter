class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;

  UserModel({this.uid, this.email, this.firstName, this.secondName});

  //receving data from sever
  factory UserModel.fromMAp(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        secondName: map['secondName']);
  }
  //sending data to server
  Map<String,dynamic> toMap()
  {
    return {
      'uid':uid,
      'email':email,
      'firstName':firstName,
      'secondName':secondName
    };
  }

}
