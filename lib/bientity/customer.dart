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
    this.code,
    this.name,
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
    this.info1,
    this.info2,
    this.info3,
    this.info4,
    this.info5,
    this.info6,
    this.info7,
    this.info8,
    this.info9,
  });

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
    if (map == null) return null;

    return Customer(
      code: map['code'],
      name: map['name'],
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
      info1: map['info1'],
      info2: map['info2'],
      info3: map['info3'],
      info4: map['info4'],
      info5: map['info5'],
      info6: map['info6'],
      info7: map['info7'],
      info8: map['info8'],
      info9: map['info9'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(code: $code, name: $name, phone: $phone, fax: $fax, email: $email, contactName1: $contactName1, contactName1Phone: $contactName1Phone, contactName2: $contactName2, contactName2Phone: $contactName2Phone, address1: $address1, address2: $address2, address3: $address3, info1: $info1, info2: $info2, info3: $info3, info4: $info4, info5: $info5, info6: $info6, info7: $info7, info8: $info8, info9: $info9)';
  }
}
