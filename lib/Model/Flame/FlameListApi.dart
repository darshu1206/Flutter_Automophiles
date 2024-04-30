import 'package:flutter_splash_login_signup/Model/Flame/flame.dart';

class FlameListApi {

  final List<Flame> flame;
  final bool error;
  final String message;

	FlameListApi.fromJsonMap(Map<String, dynamic> map): 
		flame = List<Flame>.from(map["flame"].map((it) => Flame.fromJsonMap(it))),
		error = map["error"],
		message = map["message"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['flame'] = flame != null ? 
			this.flame.map((v) => v.toJson()).toList()
			: null;
		data['error'] = error;
		data['message'] = message;
		return data;
	}
}
