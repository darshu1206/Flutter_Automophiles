
class Flame {

  final String FLAME_ID;
  final String DEVICE_ID;
  final String FLAME_VALUE;
  final String READING_TIME;

	Flame.fromJsonMap(Map<String, dynamic> map): 
		FLAME_ID = map["FLAME_ID"],
		DEVICE_ID = map["DEVICE_ID"],
		FLAME_VALUE = map["FLAME_VALUE"],
		READING_TIME = map["READING_TIME"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['FLAME_ID'] = FLAME_ID;
		data['DEVICE_ID'] = DEVICE_ID;
		data['FLAME_VALUE'] = FLAME_VALUE;
		data['READING_TIME'] = READING_TIME;
		return data;
	}
}
