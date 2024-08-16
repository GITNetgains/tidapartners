class UpcomingBookingsModel {
  int? totalBookings;
  int? maxPages;
  String? currentPage;
  List<Data>? data;

  UpcomingBookingsModel(
      {this.totalBookings, this.maxPages, this.currentPage, this.data});

  UpcomingBookingsModel.fromJson(Map<String, dynamic> json) {
    if (json["total_bookings"] is int) {
      totalBookings = json["total_bookings"];
    }
    if (json["max_pages"] is int) {
      maxPages = json["max_pages"];
    }
    if (json["current_page"] is String) {
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
    _data["total_bookings"] = totalBookings;
    _data["max_pages"] = maxPages;
    _data["current_page"] = currentPage;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  int? orderId;
  String? status;
  String? currency;
  CreatedDate? createdDate;
  String? transactionId;
  String? bookingAmount;
  String? orderTotalDiscountedAmount;
  String? orderTotal;
  int? orderItems;
  int? orderItemPosition;
  Customer? customer;
  Slot? slot;

  Data(
      {this.orderId,
      this.status,
      this.currency,
      this.createdDate,
      this.transactionId,
      this.bookingAmount,
      this.orderTotal,
      this.orderItems,
      this.orderItemPosition,
      this.customer,
      this.orderTotalDiscountedAmount,
      this.slot});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["order_id"] is int) {
      orderId = json["order_id"];
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
    if (json["booking_amount"] is String) {
      bookingAmount = json["booking_amount"];
    }
    if (json["order_total_discounted_amount"] is String) {
      orderTotalDiscountedAmount = json["order_total_discounted_amount"];
    }
    if (json["order_total"] is String) {
      orderTotal = json["order_total"];
    }
    if (json["order_items"] is int) {
      orderItems = json["order_items"];
    }
    if (json["order_item_position"] is int) {
      orderItemPosition = json["order_item_position"];
    }
    if (json["customer"] is Map) {
      customer =
          json["customer"] == null ? null : Customer.fromJson(json["customer"]);
    }
    if (json["slot"] is Map) {
      slot = json["slot"] == null ? null : Slot.fromJson(json["slot"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["order_id"] = orderId;
    _data["status"] = status;
    _data["currency"] = currency;
    if (createdDate != null) {
      _data["created_date"] = createdDate?.toJson();
    }
    _data["transaction_id"] = transactionId;
    _data["booking_amount"] = bookingAmount;
    _data["order_total_discounted_amount"] = orderTotalDiscountedAmount;
    _data["order"] = bookingAmount;
    _data["order_total"] = orderTotal;
    _data["order_items"] = orderItems;
    _data["order_item_position"] = orderItemPosition;
    if (customer != null) {
      _data["customer"] = customer?.toJson();
    }
    if (slot != null) {
      _data["slot"] = slot?.toJson();
    }
    return _data;
  }
}

class Slot {
  Item? item;
  int? slotAmount;
  String? dayTime;
  int? bookingId;
  String? slotStartDate;
  String? slotEndDate;
  String? slotStartTime;
  String? slotEndTime;
  String? slotName;

  Slot(
      {this.item,
      this.slotAmount,
      this.dayTime,
      this.bookingId,
      this.slotStartDate,
      this.slotEndDate,
      this.slotStartTime,
      this.slotEndTime,
      this.slotName});

  Slot.fromJson(Map<String, dynamic> json) {
    if (json["item"] is Map) {
      item = json["item"] == null ? null : Item.fromJson(json["item"]);
    }
    if (json["slot_amount"] is int) {
      slotAmount = json["slot_amount"];
    }
    if (json["day_time"] is String) {
      dayTime = json["day_time"];
    }
    if (json["booking_id"] is int) {
      bookingId = json["booking_id"];
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
    if (item != null) {
      _data["item"] = item?.toJson();
    }
    _data["slot_amount"] = slotAmount;
    _data["day_time"] = dayTime;
    _data["booking_id"] = bookingId;
    _data["slot_start_date"] = slotStartDate;
    _data["slot_end_date"] = slotEndDate;
    _data["slot_start_time"] = slotStartTime;
    _data["slot_end_time"] = slotEndTime;
    _data["slot_name"] = slotName;
    return _data;
  }
}

class Item {
  String? name;
  String? address;
  String? personName;
  String? image;
  String? partnerName;
  String? partnerPhone;

  Item(
      {this.name,
      this.address,
      this.personName,
      this.image,
      this.partnerName,
      this.partnerPhone});

  Item.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["address"] is String) {
      address = json["address"];
    }
    if (json["person_name"] is String) {
      personName = json["person_name"];
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
    _data["image"] = image;
    _data["partner_name"] = partnerName;
    _data["partner_phone"] = partnerPhone;
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
