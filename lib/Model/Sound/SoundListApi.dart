import 'package:flutter_splash_login_signup/Model/Sound/sound.dart';

class SoundListApi {

  final List<Sound> sound;
  final bool error;
  final String message;

	SoundListApi.fromJsonMap(Map<String, dynamic> map): 
		sound = List<Sound>.from(map["sound"].map((it) => Sound.fromJsonMap(it))),
		error = map["error"],
		message = map["message"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sound'] = sound != null ? 
			this.sound.map((v) => v.toJson()).toList()
			: null;
		data['error'] = error;
		data['message'] = message;
		return data;
	}
}
