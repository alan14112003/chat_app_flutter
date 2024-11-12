// ignore_for_file: constant_identifier_names

enum NavigationEnum { CHAT, FRIEND, PROFILE }

NavigationEnum getNavigationEnumFromIndex(int index) {
  if (index < 0 || index >= NavigationEnum.values.length) {
    return NavigationEnum.CHAT;
  }
  return NavigationEnum.values[index];
}
