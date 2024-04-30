
class DashBoardListApi {

  final String MQ4;
  final String FLAME;
  final String SMOKE;
  final String SOUND;
  final String TEMP;
  final bool error;
  final String message;

	DashBoardListApi.fromJsonMap(Map<String, dynamic> map): 
		MQ4 = map["MQ4"],
		FLAME = map["FLAME"],
		SMOKE = map["SMOKE"],
		SOUND = map["SOUND"],
		TEMP = map["TEMP"],
		error = map["error"],
		message = map["message"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['MQ4'] = MQ4;
		data['FLAME'] = FLAME;
		data['SMOKE'] = SMOKE;
		data['SOUND'] = SOUND;
		data['TEMP'] = TEMP;
		data['error'] = error;
		data['message'] = message;
		return data;
	}
}
