import 'dart:ui';

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

Color colorFromOpacityHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('$hexCode', radix: 16));
}


String validateUserNameField(String value){
  if(value != null && value.isNotEmpty){
    return null;
  }
  return "This field is required";
}
