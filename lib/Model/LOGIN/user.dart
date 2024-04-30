
class User {

  final String ID;
  final String NAME;
  final String EMAIL;
  final String PASSWORD;
  final String PHONE;
  final String ROLE;
  final String ADDRESS;
  final String BG;
  final String DOB;
  final String STATUS;
  final String CAR_NUMBER_PLATE;

	User.fromJsonMap(Map<String, dynamic> map): 
		ID = map["ID"]??"",
		NAME = map["NAME"]??"",
		EMAIL = map["EMAIL"]??"",
		PASSWORD = map["PASSWORD"]??"",
		PHONE = map["PHONE"]??"",
		ROLE = map["ROLE"]??"",
		ADDRESS = map["ADDRESS"]??"",
		BG = map["BG"]??"",
		DOB = map["DOB"]??"",
		STATUS = map["STATUS"]??"",
		CAR_NUMBER_PLATE = map["CAR_NUMBER_PLATE"]??"";

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ID'] = ID;
		data['NAME'] = NAME;
		data['EMAIL'] = EMAIL;
		data['PASSWORD'] = PASSWORD;
		data['PHONE'] = PHONE;
		data['ROLE'] = ROLE;
		data['ADDRESS'] = ADDRESS;
		data['BG'] = BG;
		data['DOB'] = DOB;
		data['STATUS'] = STATUS;
		data['CAR_NUMBER_PLATE'] = CAR_NUMBER_PLATE;
		return data;
	}
}
