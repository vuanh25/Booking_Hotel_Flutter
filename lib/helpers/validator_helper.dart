import 'package:get/get.dart';
import 'package:travel_app_flutter/helpers/enum_helper.dart';

class ValidatorHelper {
  ValidatorHelper._();
  static final instance = ValidatorHelper._();

  String? validator(
      {required String? value, required FieldType type, String? matchText}) {
    switch (type) {
      case FieldType.name:
        return _name(value);
      case FieldType.email:
        return _email(value);
      case FieldType.password:
        return _password(value);
      case FieldType.confirmPassword:
        return _confirmPassword(value, matchText);
      case FieldType.cardNumber:
        return _cardNumber(value);
      case FieldType.cardHolder:
        return _cardHolder(value);
      case FieldType.phoneNumber:
        return _phoneNumber(value);
    }
  }

  String? _name(String? value) {
    if (value == null || value.isEmpty) {
      return "Không được để trống".tr;
    }
    if (value.length < 4) {
      return "Tên quá ngắn".tr;
    }
    return null;
  }

  String? _email(String? value) {
    if (value == null || value.isEmpty) {
      return "Không được để trống".tr;
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return "Email không đúng định dạng";
    }

    return null;
  }

  String? _password(String? value) {
    if (value == null || value.isEmpty) {
      return "Không được để trống mật khẩu";
    }
    if (value.length < 6) {
      return "Mật khẩu quá ngắn phải trên 6 ký tự";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Mật khẩu phải có định dạng chữ hoa chữ thường";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Mật khẩu phải có ký tự";
    }
    return null;
  }

  String? _confirmPassword(String? value, String? otherText) {
    if (value == null || value.isEmpty) {
      return "Không được để trống mật khẩu";
    }
    if (value.length < 6) {
      return "Mật khẩu quá ngắn";
    }
    if (value != otherText) {
      return "Mật khẩu không khớp";
    }
    return null;
  }

  String? _cardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "empty_card_number".tr;
    }
    if (value.length < 4) {
      return "short_card_number".tr;
    }
    if (int.tryParse(value) == null) {
      return "enter_valid_number".tr;
    }
    return null;
  }

  String? _cardHolder(String? value) {
    if (value == null || value.isEmpty) {
      return "empty_card_holder".tr;
    }
    if (value.length < 4) {
      return "short_card_holder".tr;
    }
    return null;
  }

  String? _phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length < 4) {
      return "short_card_number".tr;
    }
    if (int.tryParse(value) == null) {
      return "enter_valid_number".tr;
    }
    return null;
  }
}
