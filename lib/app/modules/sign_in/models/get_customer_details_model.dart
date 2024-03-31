
class GetCustomerModel {
    int? id;
    String? dateCreated;
    String? dateCreatedGmt;
    String? dateModified;
    String? dateModifiedGmt;
    String? email;
    String? firstName;
    String? lastName;
    String? role;
    String? username;
    Billing? billing;
    Shipping? shipping;
    bool? isPayingCustomer;
    String? avatarUrl;
    List<MetaData>? metaData;
    Links? links;

    GetCustomerModel({this.id, this.dateCreated, this.dateCreatedGmt, this.dateModified, this.dateModifiedGmt, this.email, this.firstName, this.lastName, this.role, this.username, this.billing, this.shipping, this.isPayingCustomer, this.avatarUrl, this.metaData, this.links});

    GetCustomerModel.fromJson(Map<String, dynamic> json) {
        if(json["id"] is int) {
            id = json["id"];
        }
        if(json["date_created"] is String) {
            dateCreated = json["date_created"];
        }
        if(json["date_created_gmt"] is String) {
            dateCreatedGmt = json["date_created_gmt"];
        }
        if(json["date_modified"] is String) {
            dateModified = json["date_modified"];
        }
        if(json["date_modified_gmt"] is String) {
            dateModifiedGmt = json["date_modified_gmt"];
        }
        if(json["email"] is String) {
            email = json["email"];
        }
        if(json["first_name"] is String) {
            firstName = json["first_name"];
        }
        if(json["last_name"] is String) {
            lastName = json["last_name"];
        }
        if(json["role"] is String) {
            role = json["role"];
        }
        if(json["username"] is String) {
            username = json["username"];
        }
        if(json["billing"] is Map) {
            billing = json["billing"] == null ? null : Billing.fromJson(json["billing"]);
        }
        if(json["shipping"] is Map) {
            shipping = json["shipping"] == null ? null : Shipping.fromJson(json["shipping"]);
        }
        if(json["is_paying_customer"] is bool) {
            isPayingCustomer = json["is_paying_customer"];
        }
        if(json["avatar_url"] is String) {
            avatarUrl = json["avatar_url"];
        }
        if(json["meta_data"] is List) {
            metaData = json["meta_data"] == null ? null : (json["meta_data"] as List).map((e) => MetaData.fromJson(e)).toList();
        }
        if(json["_links"] is Map) {
            links = json["_links"] == null ? null : Links.fromJson(json["_links"]);
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["date_created"] = dateCreated;
        _data["date_created_gmt"] = dateCreatedGmt;
        _data["date_modified"] = dateModified;
        _data["date_modified_gmt"] = dateModifiedGmt;
        _data["email"] = email;
        _data["first_name"] = firstName;
        _data["last_name"] = lastName;
        _data["role"] = role;
        _data["username"] = username;
        if(billing != null) {
            _data["billing"] = billing?.toJson();
        }
        if(shipping != null) {
            _data["shipping"] = shipping?.toJson();
        }
        _data["is_paying_customer"] = isPayingCustomer;
        _data["avatar_url"] = avatarUrl;
        if(metaData != null) {
            _data["meta_data"] = metaData?.map((e) => e.toJson()).toList();
        }
        if(links != null) {
            _data["_links"] = links?.toJson();
        }
        return _data;
    }
}

class Links {
    List<Self>? self;
    List<Collection>? collection;

    Links({this.self, this.collection});

    Links.fromJson(Map<String, dynamic> json) {
        if(json["self"] is List) {
            self = json["self"] == null ? null : (json["self"] as List).map((e) => Self.fromJson(e)).toList();
        }
        if(json["collection"] is List) {
            collection = json["collection"] == null ? null : (json["collection"] as List).map((e) => Collection.fromJson(e)).toList();
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(self != null) {
            _data["self"] = self?.map((e) => e.toJson()).toList();
        }
        if(collection != null) {
            _data["collection"] = collection?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Collection {
    String? href;

    Collection({this.href});

    Collection.fromJson(Map<String, dynamic> json) {
        if(json["href"] is String) {
            href = json["href"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["href"] = href;
        return _data;
    }
}

class Self {
    String? href;

    Self({this.href});

    Self.fromJson(Map<String, dynamic> json) {
        if(json["href"] is String) {
            href = json["href"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["href"] = href;
        return _data;
    }
}

class MetaData {
    int? id;
    String? key;
    List<dynamic>? value;

    MetaData({this.id, this.key, this.value});

    MetaData.fromJson(Map<String, dynamic> json) {
        if(json["id"] is int) {
            id = json["id"];
        }
        if(json["key"] is String) {
            key = json["key"];
        }
        if(json["value"] is List) {
            value = json["value"] ?? [];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["key"] = key;
        if(value != null) {
            _data["value"] = value;
        }
        return _data;
    }
}

class Shipping {
    String? firstName;
    String? lastName;
    String? company;
    String? address1;
    String? address2;
    String? city;
    String? postcode;
    String? country;
    String? state;
    String? phone;

    Shipping({this.firstName, this.lastName, this.company, this.address1, this.address2, this.city, this.postcode, this.country, this.state, this.phone});

    Shipping.fromJson(Map<String, dynamic> json) {
        if(json["first_name"] is String) {
            firstName = json["first_name"];
        }
        if(json["last_name"] is String) {
            lastName = json["last_name"];
        }
        if(json["company"] is String) {
            company = json["company"];
        }
        if(json["address_1"] is String) {
            address1 = json["address_1"];
        }
        if(json["address_2"] is String) {
            address2 = json["address_2"];
        }
        if(json["city"] is String) {
            city = json["city"];
        }
        if(json["postcode"] is String) {
            postcode = json["postcode"];
        }
        if(json["country"] is String) {
            country = json["country"];
        }
        if(json["state"] is String) {
            state = json["state"];
        }
        if(json["phone"] is String) {
            phone = json["phone"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["first_name"] = firstName;
        _data["last_name"] = lastName;
        _data["company"] = company;
        _data["address_1"] = address1;
        _data["address_2"] = address2;
        _data["city"] = city;
        _data["postcode"] = postcode;
        _data["country"] = country;
        _data["state"] = state;
        _data["phone"] = phone;
        return _data;
    }
}

class Billing {
    String? firstName;
    String? lastName;
    String? company;
    String? address1;
    String? address2;
    String? city;
    String? postcode;
    String? country;
    String? state;
    String? email;
    String? phone;

    Billing({this.firstName, this.lastName, this.company, this.address1, this.address2, this.city, this.postcode, this.country, this.state, this.email, this.phone});

    Billing.fromJson(Map<String, dynamic> json) {
        if(json["first_name"] is String) {
            firstName = json["first_name"];
        }
        if(json["last_name"] is String) {
            lastName = json["last_name"];
        }
        if(json["company"] is String) {
            company = json["company"];
        }
        if(json["address_1"] is String) {
            address1 = json["address_1"];
        }
        if(json["address_2"] is String) {
            address2 = json["address_2"];
        }
        if(json["city"] is String) {
            city = json["city"];
        }
        if(json["postcode"] is String) {
            postcode = json["postcode"];
        }
        if(json["country"] is String) {
            country = json["country"];
        }
        if(json["state"] is String) {
            state = json["state"];
        }
        if(json["email"] is String) {
            email = json["email"];
        }
        if(json["phone"] is String) {
            phone = json["phone"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["first_name"] = firstName;
        _data["last_name"] = lastName;
        _data["company"] = company;
        _data["address_1"] = address1;
        _data["address_2"] = address2;
        _data["city"] = city;
        _data["postcode"] = postcode;
        _data["country"] = country;
        _data["state"] = state;
        _data["email"] = email;
        _data["phone"] = phone;
        return _data;
    }
}