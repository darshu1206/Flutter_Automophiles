import 'package:flutter_splash_login_signup/Model/MQ4/_m_q4.dart';

class CNGListApi {

  final List<CNG> MQ4;
  final bool error;
  final String message;

	CNGListApi.fromJsonMap(Map<String, dynamic> map): 
		MQ4 = List<CNG>.from(map["MQ4"].map((it) => CNG.fromJsonMap(it))),
		error = map["error"],
		message = map["message"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['MQ4'] = MQ4 != null ? 
			this.MQ4.map((v) => v.toJson()).toList()
			: null;
		data['error'] = error;
		data['message'] = message;
		return data;
	}
}
