
class CNG {

  final String MQ4_ID;
  final String DEVICE_ID;
  final String MQ4_VALUE;
  final String READING_TIME;

	CNG.fromJsonMap(Map<String, dynamic> map):
		MQ4_ID = map["MQ4_ID"],
		DEVICE_ID = map["DEVICE_ID"],
		MQ4_VALUE = map["MQ4_VALUE"],
		READING_TIME = map["READING_TIME"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['MQ4_ID'] = MQ4_ID;
		data['DEVICE_ID'] = DEVICE_ID;
		data['MQ4_VALUE'] = MQ4_VALUE;
		data['READING_TIME'] = READING_TIME;
		return data;
	}
}
