class UpcomingSubscriptionModel {
  dynamic totalOrders;
  int? maxPages;
  int? currentPage;
  List<Data>? data;

  UpcomingSubscriptionModel(
      {this.totalOrders, this.maxPages, this.currentPage, this.data});

  UpcomingSubscriptionModel.fromJson(Map<String, dynamic> json) {
    totalOrders = json["total_orders"];
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
  String? total;
  String? discountPrice;
  String? totalDiscountedAmount;
  Customer? customer;
  List<Subscriptions>? subscriptions;
  List<Items>? items;

  Data(
      {this.id,
      this.status,
      this.currency,
      this.createdDate,
      this.transactionId,
      this.total,
      this.customer,
      this.subscriptions,
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
    if (json["total"] is int || json["total"] is String) {
      total = json["total"].toString();
    }

    if (json["discount_price"] is String) {
      discountPrice = json["discount_price"];
    }
    if (json["total_discounted_amount"] is String) {
      totalDiscountedAmount = json["total_discounted_amount"];
    }
    if (json["customer"] is Map) {
      customer =
          json["customer"] == null ? null : Customer.fromJson(json["customer"]);
    }
    if (json["subscriptions"] is List) {
      subscriptions = json["subscriptions"] == null
          ? null
          : (json["subscriptions"] as List)
              .map((e) => Subscriptions.fromJson(e))
              .toList();
    }
    if (json["items"] is List) {
      items = json["items"] == null
          ? null
          : (json["items"] as List).map((e) => Items.fromJson(e)).toList();
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
    if (customer != null) {
      _data["customer"] = customer?.toJson();
    }
    if (subscriptions != null) {
      _data["subscriptions"] = subscriptions?.map((e) => e.toJson()).toList();
    }
    if (items != null) {
      _data["items"] = items?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Items {
  String? type;
  String? academyName;
  String? academyAddress;
  String? packageName;
  String? packageAmount;
  String? personName;
  String? image;
  String? partnerName;
  String? partnerPhone;

  Items(
      {this.type,
      this.academyName,
      this.academyAddress,
      this.packageName,
      this.packageAmount,
      this.personName,
      this.image,
      this.partnerName,
      this.partnerPhone});

  Items.fromJson(Map<String, dynamic> json) {
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["academy_name"] is String) {
      academyName = json["academy_name"];
    }
    if (json["academy_address"] is String) {
      academyAddress = json["academy_address"];
    }
    if (json["package_name"] is String) {
      packageName = json["package_name"];
    }
    if (json["package_amount"] is String) {
      packageAmount = json["package_amount"];
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
    _data["type"] = type;
    _data["academy_name"] = academyName;
    _data["academy_address"] = academyAddress;
    _data["package_name"] = packageName;
    _data["package_amount"] = packageAmount;
    _data["person_name"] = personName;
    _data["image"] = image;
    _data["partner_name"] = partnerName;
    _data["partner_phone"] = partnerPhone;
    return _data;
  }
}

class Subscriptions {
  int? id;
  int? trialEnd;
  String? total;
  String? nextPayment;
  String? start;
  String? end;
  int? subscriptionLength;

  Subscriptions(
      {this.id,
      this.trialEnd,
      this.total,
      this.nextPayment,
      this.start,
      this.end,
      this.subscriptionLength});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["trial_end"] is int) {
      trialEnd = json["trial_end"];
    }
    if (json["total"] is String) {
      total = json["total"];
    }
    if (json["next_payment"] is String) {
      nextPayment = json["next_payment"];
    }
    if (json["start"] is String) {
      start = json["start"];
    }
    if (json["end"] is String) {
      end = json["end"];
    }
    if (json["subscription_length"] is int) {
      subscriptionLength = json["subscription_length"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["trial_end"] = trialEnd;
    _data["total"] = total;
    _data["next_payment"] = nextPayment;
    _data["start"] = start;
    _data["end"] = end;
    _data["subscription_length"] = subscriptionLength;
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
