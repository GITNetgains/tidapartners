
class BookingOrdersModel {
    int? totalOrders;
    int? maxPages;
    int? currentPage;
    List<Data>? data;

    BookingOrdersModel({this.totalOrders, this.maxPages, this.currentPage, this.data});

    BookingOrdersModel.fromJson(Map<String, dynamic> json) {
        if(json["total_orders"] is int) {
            totalOrders = json["total_orders"];
        }
        if(json["max_pages"] is int) {
            maxPages = json["max_pages"];
        }
        if(json["current_page"] is int) {
            currentPage = json["current_page"];
        }
        if(json["data"] is List) {
            data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["total_orders"] = totalOrders;
        _data["max_pages"] = maxPages;
        _data["current_page"] = currentPage;
        if(data != null) {
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
    String? phoneNumber;
    String? transactionId;
    Customer? customer;
    List<Items>? items;

    Data({this.id, this.status, this.currency, this.createdDate, this.phoneNumber, this.transactionId, this.customer, this.items});

    Data.fromJson(Map<String, dynamic> json) {
        if(json["id"] is int) {
            id = json["id"];
        }
        if(json["status"] is String) {
            status = json["status"];
        }
        if(json["currency"] is String) {
            currency = json["currency"];
        }
        if(json["created_date"] is Map) {
            createdDate = json["created_date"] == null ? null : CreatedDate.fromJson(json["created_date"]);
        }
        if(json["phone_number"] is String) {
            phoneNumber = json["phone_number"];
        }
        if(json["transaction_id"] is String) {
            transactionId = json["transaction_id"];
        }
        if(json["customer"] is Map) {
            customer = json["customer"] == null ? null : Customer.fromJson(json["customer"]);
        }
        if(json["items"] is List) {
            items = json["items"] == null ? null : (json["items"] as List).map((e) => Items.fromJson(e)).toList();
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["status"] = status;
        _data["currency"] = currency;
        if(createdDate != null) {
            _data["created_date"] = createdDate?.toJson();
        }
        _data["phone_number"] = phoneNumber;
        _data["transaction_id"] = transactionId;
        if(customer != null) {
            _data["customer"] = customer?.toJson();
        }
        if(items != null) {
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

    Items({this.type, this.academyName, this.academyAddress, this.packageName, this.packageAmount, this.personName});

    Items.fromJson(Map<String, dynamic> json) {
        if(json["type"] is String) {
            type = json["type"];
        }
        if(json["academy_name"] is String) {
            academyName = json["academy_name"];
        }
        if(json["academy_address"] is String) {
            academyAddress = json["academy_address"];
        }
        if(json["package_name"] is String) {
            packageName = json["package_name"];
        }
        if(json["package_amount"] is String) {
            packageAmount = json["package_amount"];
        }
        if(json["person_name"] is String) {
            personName = json["person_name"];
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
        return _data;
    }
}

class Customer {
    String? email;
    String? name;
    String? firstName;
    String? lastName;
    String? phone;

    Customer({this.email, this.name, this.firstName, this.lastName, this.phone});

    Customer.fromJson(Map<String, dynamic> json) {
        if(json["email"] is String) {
            email = json["email"];
        }
        if(json["name"] is String) {
            name = json["name"];
        }
        if(json["first_name"] is String) {
            firstName = json["first_name"];
        }
        if(json["last_name"] is String) {
            lastName = json["last_name"];
        }
        if(json["phone"] is String) {
            phone = json["phone"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
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
        if(json["date"] is String) {
            date = json["date"];
        }
        if(json["timezone_type"] is int) {
            timezoneType = json["timezone_type"];
        }
        if(json["timezone"] is String) {
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