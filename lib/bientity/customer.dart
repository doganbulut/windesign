import 'dart:convert';

class Customer {
  final String code;
  final String name;
  final String? phone;
  final String? fax;
  final String? email;
  final String? contactName1;
  final String? contactName1Phone;
  final String? contactName2;
  final String? contactName2Phone;
  final String? address1;
  final String? address2;
  final String? address3;
  final Map<String, String>? info;

  Customer({
    required this.code,
    required this.name,
    this.phone,
    this.fax,
    this.email,
    this.contactName1,
    this.contactName1Phone,
    this.contactName2,
    this.contactName2Phone,
    this.address1,
    this.address2,
    this.address3,
    this.info,
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
    Map<String, String>? info,
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
      info: info ?? this.info,
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
      'info': info,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'],
      fax: map['fax'],
      email: map['email'],
      contactName1: map['contactName1'],
      contactName1Phone: map['contactName1Phone'],
      contactName2: map['contactName2'],
      contactName2Phone: map['contactName2Phone'],
      address1: map['address1'],
      address2: map['address2'],
      address3: map['address3'],
      info: map['info'] != null ? Map<String, String>.from(map['info']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(code: $code, name: $name, phone: $phone, fax: $fax, email: $email, contactName1: $contactName1, contactName1Phone: $contactName1Phone, contactName2: $contactName2, contactName2Phone: $contactName2Phone, address1: $address1, address2: $address2, address3: $address3, info: $info)';
  }
}
