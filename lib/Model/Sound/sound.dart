
class Sound {

  final String SOUND_ID;
  final String DEVICE_ID;
  final String SOUND_VALUE;
  final String READING_TIME;

	Sound.fromJsonMap(Map<String, dynamic> map): 
		SOUND_ID = map["SOUND_ID"],
		DEVICE_ID = map["DEVICE_ID"],
		SOUND_VALUE = map["SOUND_VALUE"],
		READING_TIME = map["READING_TIME"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['SOUND_ID'] = SOUND_ID;
		data['DEVICE_ID'] = DEVICE_ID;
		data['SOUND_VALUE'] = SOUND_VALUE;
		data['READING_TIME'] = READING_TIME;
		return data;
	}
}
