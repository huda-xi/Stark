class LogInModel {
  String? accessToken;
  String? expiresAtUtc;
  String? refreshToken;

  LogInModel({this.accessToken, this.expiresAtUtc, this.refreshToken});

  LogInModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expiresAtUtc = json['expiresAtUtc'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['expiresAtUtc'] = this.expiresAtUtc;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
