
class Smoke {

  final String SMOKE_ID;
  final String DEVICE_ID;
  final String SMOKE_VALUE;
  final String READING_TIME;

	Smoke.fromJsonMap(Map<String, dynamic> map): 
		SMOKE_ID = map["SMOKE_ID"],
		DEVICE_ID = map["DEVICE_ID"],
		SMOKE_VALUE = map["SMOKE_VALUE"],
		READING_TIME = map["READING_TIME"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['SMOKE_ID'] = SMOKE_ID;
		data['DEVICE_ID'] = DEVICE_ID;
		data['SMOKE_VALUE'] = SMOKE_VALUE;
		data['READING_TIME'] = READING_TIME;
		return data;
	}
}
