import 'package:flutter_splash_login_signup/Model/FamilyList/flame.dart';

class FamilyDetailListApi {

  final List<Flame> flame;
  final bool error;
  final String message;

	FamilyDetailListApi.fromJsonMap(Map<String, dynamic> map): 
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
