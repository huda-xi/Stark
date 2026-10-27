class SignUpModel {
  final String fname;
  final String lname;
  final String email;
  final String pass;

  SignUpModel({
    required this.email,
    required this.pass,
    required this.fname,
    required this.lname,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      fname: json['firstName'],
      email: json['email'],
      pass: json['password'],
      lname: json['lastName'],
    );
  }
}