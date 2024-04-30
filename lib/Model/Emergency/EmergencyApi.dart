
class EmergencyApi {

  final bool error;
  final String message;

	EmergencyApi.fromJsonMap(Map<String, dynamic> map): 
		error = map["error"],
		message = map["message"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['error'] = error;
		data['message'] = message;
		return data;
	}
}
