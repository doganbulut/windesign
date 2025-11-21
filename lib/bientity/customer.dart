// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Customer {
  String code;
  String name;
  String phone;
  String fax;
  String email;
  String contactName1;
  String contactName1Phone;
  String contactName2;
  String contactName2Phone;
  String address1;
  String address2;
  String address3;
  String info1;
  String info2;
  String info3;
  String info4;
  String info5;
  String info6;
  String info7;
  String info8;
  String info9;

  Customer({
    required this.code,
    required this.name,
    required this.phone,
    required this.fax,
    required this.email,
    required this.contactName1,
    required this.contactName1Phone,
    required this.contactName2,
    required this.contactName2Phone,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.info1,
    required this.info2,
    required this.info3,
    required this.info4,
    required this.info5,
    required this.info6,
    required this.info7,
    required this.info8,
    required this.info9,
  });

  Customer copyWith({
    String? code,
    String? name,
    String? phone,
    String? fax,
    String? email,
    String? contactName1,
    String? contactName1Phone,
    String? contactName2,
    String? contactName2Phone,
    String? address1,
    String? address2,
    String? address3,
    String? info1,
    String? info2,
    String? info3,
    String? info4,
    String? info5,
    String? info6,
    String? info7,
    String? info8,
    String? info9,
  }) {
    return Customer(
      code: code ?? this.code,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      fax: fax ?? this.fax,
      email: email ?? this.email,
      contactName1: contactName1 ?? this.contactName1,
      contactName1Phone: contactName1Phone ?? this.contactName1Phone,
      contactName2: contactName2 ?? this.contactName2,
      contactName2Phone: contactName2Phone ?? this.contactName2Phone,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      address3: address3 ?? this.address3,
      info1: info1 ?? this.info1,
      info2: info2 ?? this.info2,
      info3: info3 ?? this.info3,
      info4: info4 ?? this.info4,
      info5: info5 ?? this.info5,
      info6: info6 ?? this.info6,
      info7: info7 ?? this.info7,
      info8: info8 ?? this.info8,
      info9: info9 ?? this.info9,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
      'phone': phone,
      'fax': fax,
      'email': email,
      'contactName1': contactName1,
      'contactName1Phone': contactName1Phone,
      'contactName2': contactName2,
      'contactName2Phone': contactName2Phone,
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'info1': info1,
      'info2': info2,
      'info3': info3,
      'info4': info4,
      'info5': info5,
      'info6': info6,
      'info7': info7,
      'info8': info8,
      'info9': info9,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      code: map['code'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      fax: map['fax'] as String,
      email: map['email'] as String,
      contactName1: map['contactName1'] as String,
      contactName1Phone: map['contactName1Phone'] as String,
      contactName2: map['contactName2'] as String,
      contactName2Phone: map['contactName2Phone'] as String,
      address1: map['address1'] as String,
      address2: map['address2'] as String,
      address3: map['address3'] as String,
      info1: map['info1'] as String,
      info2: map['info2'] as String,
      info3: map['info3'] as String,
      info4: map['info4'] as String,
      info5: map['info5'] as String,
      info6: map['info6'] as String,
      info7: map['info7'] as String,
      info8: map['info8'] as String,
      info9: map['info9'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Customer(code: $code, name: $name, phone: $phone, fax: $fax, email: $email, contactName1: $contactName1, contactName1Phone: $contactName1Phone, contactName2: $contactName2, contactName2Phone: $contactName2Phone, address1: $address1, address2: $address2, address3: $address3, info1: $info1, info2: $info2, info3: $info3, info4: $info4, info5: $info5, info6: $info6, info7: $info7, info8: $info8, info9: $info9)';
  }

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.name == name &&
        other.phone == phone &&
        other.fax == fax &&
        other.email == email &&
        other.contactName1 == contactName1 &&
        other.contactName1Phone == contactName1Phone &&
        other.contactName2 == contactName2 &&
        other.contactName2Phone == contactName2Phone &&
        other.address1 == address1 &&
        other.address2 == address2 &&
        other.address3 == address3 &&
        other.info1 == info1 &&
        other.info2 == info2 &&
        other.info3 == info3 &&
        other.info4 == info4 &&
        other.info5 == info5 &&
        other.info6 == info6 &&
        other.info7 == info7 &&
        other.info8 == info8 &&
        other.info9 == info9;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        fax.hashCode ^
        email.hashCode ^
        contactName1.hashCode ^
        contactName1Phone.hashCode ^
        contactName2.hashCode ^
        contactName2Phone.hashCode ^
        address1.hashCode ^
        address2.hashCode ^
        address3.hashCode ^
        info1.hashCode ^
        info2.hashCode ^
        info3.hashCode ^
        info4.hashCode ^
        info5.hashCode ^
        info6.hashCode ^
        info7.hashCode ^
        info8.hashCode ^
        info9.hashCode;
  }
}
