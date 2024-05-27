class VenueOrdersModel {
  int? totalOrders;
  int? maxPages;
  int? currentPage;
  List<Data>? data;

  VenueOrdersModel(
      {this.totalOrders, this.maxPages, this.currentPage, this.data});

  VenueOrdersModel.fromJson(Map<String, dynamic> json) {
    if (json["total_orders"] is int) {
      totalOrders = json["total_orders"];
    }
    if (json["max_pages"] is int) {
      maxPages = json["max_pages"];
    }
    if (json["current_page"] is int) {
      currentPage = json["current_page"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["total_orders"] = totalOrders;
    _data["max_pages"] = maxPages;
    _data["current_page"] = currentPage;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  int? id;
  String? status;
  String? currency;
  CreatedDate? createdDate;
  String? transactionId;
  String? discountPrice;
  int? total;
  String? totalDiscountedAmount;
  List<Coupon>? coupon;
  Customer? customer;
  Items? items;

  Data(
      {this.id,
      this.status,
      this.currency,
      this.createdDate,
      this.transactionId,
      this.discountPrice,
      this.total,
      this.totalDiscountedAmount,
      this.coupon,
      this.customer,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["currency"] is String) {
      currency = json["currency"];
    }
    if (json["created_date"] is Map) {
      createdDate = json["created_date"] == null
          ? null
          : CreatedDate.fromJson(json["created_date"]);
    }
    if (json["transaction_id"] is String) {
      transactionId = json["transaction_id"];
    }
    if (json["discount_price"] is String) {
      discountPrice = json["discount_price"];
    }
    if (json["total"] is int) {
      total = json["total"];
    }
    if (json["total_discounted_amount"] is String) {
      totalDiscountedAmount = json["total_discounted_amount"];
    }
    if (json["coupon"] is List) {
      coupon = json["coupon"] == null
          ? null
          : (json["coupon"] as List).map((e) => Coupon.fromJson(e)).toList();
    }
    if (json["customer"] is Map) {
      customer =
          json["customer"] == null ? null : Customer.fromJson(json["customer"]);
    }
    if (json["items"] is Map) {
      items = json["items"] == null ? null : Items.fromJson(json["items"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["status"] = status;
    _data["currency"] = currency;
    if (createdDate != null) {
      _data["created_date"] = createdDate?.toJson();
    }
    _data["transaction_id"] = transactionId;
    _data["discount_price"] = discountPrice;
    _data["total"] = total;
    _data["total_discounted_amount"] = totalDiscountedAmount;
    if (coupon != null) {
      _data["coupon"] = coupon?.map((e) => e.toJson()).toList();
    }
    if (customer != null) {
      _data["customer"] = customer?.toJson();
    }
    if (items != null) {
      _data["items"] = items?.toJson();
    }
    return _data;
  }
}

class Items {
  Venue? a;
  List<Slots>? slots;

  Items({this.a, this.slots});

  Items.fromJson(Map<String, dynamic> json) {
    if (json["0"] is Map) {
      a = json["0"] == null ? null : Venue.fromJson(json["0"]);
    }
    if (json["slots"] is List) {
      slots = json["slots"] == null
          ? null
          : (json["slots"] as List).map((e) => Slots.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (0 != null) {
      _data["0"] = a?.toJson();
    }
    if (slots != null) {
      _data["slots"] = slots?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Slots {
  String? dayTime;
  int? bookingId;
  int? slotAmount;
  String? slotStartDate;
  String? slotEndDate;
  String? slotStartTime;
  String? slotEndTime;
  String? slotName;

  Slots(
      {this.dayTime,
      this.bookingId,
      this.slotAmount,
      this.slotStartDate,
      this.slotEndDate,
      this.slotStartTime,
      this.slotEndTime,
      this.slotName});

  Slots.fromJson(Map<String, dynamic> json) {
    if (json["day_time"] is String) {
      dayTime = json["day_time"];
    }
    if (json["booking_id"] is int) {
      bookingId = json["booking_id"];
    }
    if (json["slot_amount"] is int) {
      slotAmount = json["slot_amount"];
    }
    if (json["slot_start_date"] is String) {
      slotStartDate = json["slot_start_date"];
    }
    if (json["slot_end_date"] is String) {
      slotEndDate = json["slot_end_date"];
    }
    if (json["slot_start_time"] is String) {
      slotStartTime = json["slot_start_time"];
    }
    if (json["slot_end_time"] is String) {
      slotEndTime = json["slot_end_time"];
    }
    if (json["slot_name"] is String) {
      slotName = json["slot_name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["day_time"] = dayTime;
    _data["booking_id"] = bookingId;
    _data["slot_amount"] = slotAmount;
    _data["slot_start_date"] = slotStartDate;
    _data["slot_end_date"] = slotEndDate;
    _data["slot_start_time"] = slotStartTime;
    _data["slot_end_time"] = slotEndTime;
    _data["slot_name"] = slotName;
    return _data;
  }
}

class Venue {
  String? name;
  String? address;
  String? personName;
  User? user;
  String? image;
  String? partnerName;
  String? partnerPhone;

  Venue(
      {this.name,
      this.address,
      this.personName,
      this.user,
      this.image,
      this.partnerName,
      this.partnerPhone});

  Venue.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["address"] is String) {
      address = json["address"];
    }
    if (json["person_name"] is String) {
      personName = json["person_name"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["partner_name"] is String) {
      partnerName = json["partner_name"];
    }
    if (json["partner_phone"] is String) {
      partnerPhone = json["partner_phone"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["address"] = address;
    _data["person_name"] = personName;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["image"] = image;
    _data["partner_name"] = partnerName;
    _data["partner_phone"] = partnerPhone;
    return _data;
  }
}

class User {
  Data1? data;
  int? id;
  Caps? caps;
  String? capKey;
  List<String>? roles;
  Allcaps? allcaps;
  dynamic filter;

  User(
      {this.data,
      this.id,
      this.caps,
      this.capKey,
      this.roles,
      this.allcaps,
      this.filter});

  User.fromJson(Map<String, dynamic> json) {
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data1.fromJson(json["data"]);
    }
    if (json["ID"] is int) {
      id = json["ID"];
    }
    if (json["caps"] is Map) {
      caps = json["caps"] == null ? null : Caps.fromJson(json["caps"]);
    }
    if (json["cap_key"] is String) {
      capKey = json["cap_key"];
    }
    if (json["roles"] is List) {
      roles = json["roles"] == null ? null : List<String>.from(json["roles"]);
    }
    if (json["allcaps"] is Map) {
      allcaps =
          json["allcaps"] == null ? null : Allcaps.fromJson(json["allcaps"]);
    }
    filter = json["filter"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    _data["ID"] = id;
    if (caps != null) {
      _data["caps"] = caps?.toJson();
    }
    _data["cap_key"] = capKey;
    if (roles != null) {
      _data["roles"] = roles;
    }
    if (allcaps != null) {
      _data["allcaps"] = allcaps?.toJson();
    }
    _data["filter"] = filter;
    return _data;
  }
}

class Allcaps {
  bool? read;
  bool? wf2FaActivate2FaSelf;
  bool? customer;

  Allcaps({this.read, this.wf2FaActivate2FaSelf, this.customer});

  Allcaps.fromJson(Map<String, dynamic> json) {
    if (json["read"] is bool) {
      read = json["read"];
    }
    if (json["wf2fa_activate_2fa_self"] is bool) {
      wf2FaActivate2FaSelf = json["wf2fa_activate_2fa_self"];
    }
    if (json["customer"] is bool) {
      customer = json["customer"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["read"] = read;
    _data["wf2fa_activate_2fa_self"] = wf2FaActivate2FaSelf;
    _data["customer"] = customer;
    return _data;
  }
}

class Caps {
  bool? customer;

  Caps({this.customer});

  Caps.fromJson(Map<String, dynamic> json) {
    if (json["customer"] is bool) {
      customer = json["customer"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["customer"] = customer;
    return _data;
  }
}

class Data1 {
  String? id;
  String? userLogin;
  String? userPass;
  String? userNicename;
  String? userEmail;
  String? userUrl;
  String? userRegistered;
  String? userActivationKey;
  String? userStatus;
  String? displayName;

  Data1(
      {this.id,
      this.userLogin,
      this.userPass,
      this.userNicename,
      this.userEmail,
      this.userUrl,
      this.userRegistered,
      this.userActivationKey,
      this.userStatus,
      this.displayName});

  Data1.fromJson(Map<String, dynamic> json) {
    if (json["ID"] is String) {
      id = json["ID"];
    }
    if (json["user_login"] is String) {
      userLogin = json["user_login"];
    }
    if (json["user_pass"] is String) {
      userPass = json["user_pass"];
    }
    if (json["user_nicename"] is String) {
      userNicename = json["user_nicename"];
    }
    if (json["user_email"] is String) {
      userEmail = json["user_email"];
    }
    if (json["user_url"] is String) {
      userUrl = json["user_url"];
    }
    if (json["user_registered"] is String) {
      userRegistered = json["user_registered"];
    }
    if (json["user_activation_key"] is String) {
      userActivationKey = json["user_activation_key"];
    }
    if (json["user_status"] is String) {
      userStatus = json["user_status"];
    }
    if (json["display_name"] is String) {
      displayName = json["display_name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ID"] = id;
    _data["user_login"] = userLogin;
    _data["user_pass"] = userPass;
    _data["user_nicename"] = userNicename;
    _data["user_email"] = userEmail;
    _data["user_url"] = userUrl;
    _data["user_registered"] = userRegistered;
    _data["user_activation_key"] = userActivationKey;
    _data["user_status"] = userStatus;
    _data["display_name"] = displayName;
    return _data;
  }
}

class Customer {
  int? id;
  String? email;
  String? name;
  String? firstName;
  String? lastName;
  String? phone;

  Customer(
      {this.id,
      this.email,
      this.name,
      this.firstName,
      this.lastName,
      this.phone});

  Customer.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["first_name"] is String) {
      firstName = json["first_name"];
    }
    if (json["last_name"] is String) {
      lastName = json["last_name"];
    }
    if (json["phone"] is String) {
      phone = json["phone"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["email"] = email;
    _data["name"] = name;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["phone"] = phone;
    return _data;
  }
}

class Coupon {
  String? code;
  String? amount;
  String? discountType;

  Coupon({this.code, this.amount, this.discountType});

  Coupon.fromJson(Map<String, dynamic> json) {
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["amount"] is String) {
      amount = json["amount"];
    }
    if (json["discount_type"] is String) {
      discountType = json["discount_type"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["amount"] = amount;
    _data["discount_type"] = discountType;
    return _data;
  }
}

class CreatedDate {
  String? date;
  int? timezoneType;
  String? timezone;

  CreatedDate({this.date, this.timezoneType, this.timezone});

  CreatedDate.fromJson(Map<String, dynamic> json) {
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["timezone_type"] is int) {
      timezoneType = json["timezone_type"];
    }
    if (json["timezone"] is String) {
      timezone = json["timezone"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    _data["timezone_type"] = timezoneType;
    _data["timezone"] = timezone;
    return _data;
  }
}
