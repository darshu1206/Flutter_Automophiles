import 'package:flutter_splash_login_signup/Model/Temp/temp.dart';

class TempListApi {

  final List<Temp> temp;
  final bool error;
  final String message;

	TempListApi.fromJsonMap(Map<String, dynamic> map): 
		temp = List<Temp>.from(map["temp"].map((it) => Temp.fromJsonMap(it))),
		error = map["error"],
		message = map["message"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['temp'] = temp != null ? 
			this.temp.map((v) => v.toJson()).toList()
			: null;
		data['error'] = error;
		data['message'] = message;
		return data;
	}
}
