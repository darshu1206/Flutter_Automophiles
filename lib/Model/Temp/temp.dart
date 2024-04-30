
class Temp {

  final String TEMP_ID;
  final String DEVICE_ID;
  final String TEMP_VALUE;
  final String READING_TIME;

	Temp.fromJsonMap(Map<String, dynamic> map): 
		TEMP_ID = map["TEMP_ID"],
		DEVICE_ID = map["DEVICE_ID"],
		TEMP_VALUE = map["TEMP_VALUE"],
		READING_TIME = map["READING_TIME"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['TEMP_ID'] = TEMP_ID;
		data['DEVICE_ID'] = DEVICE_ID;
		data['TEMP_VALUE'] = TEMP_VALUE;
		data['READING_TIME'] = READING_TIME;
		return data;
	}
}
