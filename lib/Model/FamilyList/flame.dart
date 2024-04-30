
class Flame {

  final String FAMILY_ID;
  final String ID;
  final String FAMILY_NAME;
  final String CONTACT;
  final String FAMILY_EMAIL;
  final String RELATION;

	Flame.fromJsonMap(Map<String, dynamic> map): 
		FAMILY_ID = map["FAMILY_ID"],
		ID = map["ID"],
		FAMILY_NAME = map["FAMILY_NAME"],
		CONTACT = map["CONTACT"],
		FAMILY_EMAIL = map["FAMILY_EMAIL"],
		RELATION = map["RELATION"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['FAMILY_ID'] = FAMILY_ID;
		data['ID'] = ID;
		data['FAMILY_NAME'] = FAMILY_NAME;
		data['CONTACT'] = CONTACT;
		data['FAMILY_EMAIL'] = FAMILY_EMAIL;
		data['RELATION'] = RELATION;
		return data;
	}
}
