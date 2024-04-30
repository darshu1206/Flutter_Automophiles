import 'package:flutter_splash_login_signup/Model/LOGIN/user.dart';

class LoginApi {

  final User user;
  final bool error;
  final String message;

	LoginApi.fromJsonMap(Map<String, dynamic> map):
		user = User.fromJsonMap(map["user"]),
		error = map["error"],
		message = map["message"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['user'] = user;
		data['error'] = error;
		data['message'] = message;
		return data;
	}
}
