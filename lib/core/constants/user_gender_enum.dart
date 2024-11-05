// ignore_for_file: constant_identifier_names

class UserGenderEnum {
  static const int SECRET = 0;
  static const int FEMALE = 1;
  static const int MALE = 2;
  static const int LGBT = 3;

  static allName() {
    return {
      [UserGenderEnum.SECRET]: 'bí mật',
      [UserGenderEnum.FEMALE]: 'nữ',
      [UserGenderEnum.MALE]: 'nam',
      [UserGenderEnum.LGBT]: 'lgbt',
    };
  }

  static String getNameByValue(int value) {
    return UserGenderEnum.allName()[value];
  }
}
