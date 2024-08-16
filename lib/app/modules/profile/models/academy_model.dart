
class AcademyModel {
    String? status;
    Data? data;

    AcademyModel({this.status, this.data});

    AcademyModel.fromJson(Map<String, dynamic> json) {
        if(json["status"] is String) {
            status = json["status"];
        }
        if(json["data"] is Map) {
            data = json["data"] == null ? null : Data.fromJson(json["data"]);
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["status"] = status;
        if(data != null) {
            _data["data"] = data?.toJson();
        }
        return _data;
    }
}

class Data {
    int? totalItems;
    int? maxNumPages;
    String? status;
    List<Data1>? data;

    Data({this.totalItems, this.maxNumPages, this.status, this.data});

    Data.fromJson(Map<String, dynamic> json) {
        if(json["total_items"] is int) {
            totalItems = json["total_items"];
        }
        if(json["max_num_pages"] is int) {
            maxNumPages = json["max_num_pages"];
        }
        if(json["status"] is String) {
            status = json["status"];
        }
        if(json["data"] is List) {
            data = json["data"] == null ? null : (json["data"] as List).map((e) => Data1.fromJson(e)).toList();
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["total_items"] = totalItems;
        _data["max_num_pages"] = maxNumPages;
        _data["status"] = status;
        if(data != null) {
            _data["data"] = data?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Data1 {
    String? currencySymbol;
    String? currency;
    String? id;
    String? title;
    String? content;
    String? address;
    String? latitude;
    String? longitude;
    String? contactNo;
    String? headCoach;
    String? sessionTimings;
    String? skillLevel;
    bool? floodLights;
    String? coachExperience;
    String? noOfAssistantCoach;
    String? assistantCoachName;
    int? partnerId;
    List<Amenities>? amenities;
    String? image;
    String? type;
    List<Packages>? packages;

    Data1({this.currencySymbol, this.currency, this.id, this.title, this.content, this.address, this.latitude, this.longitude, this.contactNo, this.headCoach, this.sessionTimings, this.skillLevel, this.floodLights, this.coachExperience, this.noOfAssistantCoach, this.assistantCoachName, this.partnerId, this.amenities, this.image, this.type, this.packages});

    Data1.fromJson(Map<String, dynamic> json) {
        if(json["currency_symbol"] is String) {
            currencySymbol = json["currency_symbol"];
        }
        if(json["currency"] is String) {
            currency = json["currency"];
        }
        if(json["id"] is String) {
            id = json["id"];
        }
        if(json["title"] is String) {
            title = json["title"];
        }
        if(json["content"] is String) {
            content = json["content"];
        }
        if(json["address"] is String) {
            address = json["address"];
        }
        if(json["latitude"] is String) {
            latitude = json["latitude"];
        }
        if(json["longitude"] is String) {
            longitude = json["longitude"];
        }
        if(json["contact_no"] is String) {
            contactNo = json["contact_no"];
        }
        if(json["head_coach"] is String) {
            headCoach = json["head_coach"];
        }
        if(json["session_timings"] is String) {
            sessionTimings = json["session_timings"];
        }
        if(json["skill_level"] is String) {
            skillLevel = json["skill_level"];
        }
        if(json["flood_lights"] is bool) {
            floodLights = json["flood_lights"];
        }
        if(json["coach_experience"] is String) {
            coachExperience = json["coach_experience"];
        }
        if(json["no_of_assistant_coach"] is String) {
            noOfAssistantCoach = json["no_of_assistant_coach"];
        }
        if(json["assistant_coach_name"] is String) {
            assistantCoachName = json["assistant_coach_name"];
        }
        if(json["partner_id"] is int) {
            partnerId = json["partner_id"];
        }
        if(json["amenities"] is List) {
            amenities = json["amenities"] == null ? null : (json["amenities"] as List).map((e) => Amenities.fromJson(e)).toList();
        }
        if(json["image"] is String) {
            image = json["image"];
        }
        if(json["type"] is String) {
            type = json["type"];
        }
        if(json["packages"] is List) {
            packages = json["packages"] == null ? null : (json["packages"] as List).map((e) => Packages.fromJson(e)).toList();
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["currency_symbol"] = currencySymbol;
        _data["currency"] = currency;
        _data["id"] = id;
        _data["title"] = title;
        _data["content"] = content;
        _data["address"] = address;
        _data["latitude"] = latitude;
        _data["longitude"] = longitude;
        _data["contact_no"] = contactNo;
        _data["head_coach"] = headCoach;
        _data["session_timings"] = sessionTimings;
        _data["skill_level"] = skillLevel;
        _data["flood_lights"] = floodLights;
        _data["coach_experience"] = coachExperience;
        _data["no_of_assistant_coach"] = noOfAssistantCoach;
        _data["assistant_coach_name"] = assistantCoachName;
        _data["partner_id"] = partnerId;
        if(amenities != null) {
            _data["amenities"] = amenities?.map((e) => e.toJson()).toList();
        }
        _data["image"] = image;
        _data["type"] = type;
        if(packages != null) {
            _data["packages"] = packages?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Packages {
    String? type;
    int? id;
    String? content;
    String? name;
    int? regularPrice;
    int? price;
    String? img;
    String? interval;
    String? period;
    String? startDate;

    Packages({this.type, this.id, this.content, this.name, this.regularPrice, this.price, this.img, this.interval, this.period, this.startDate});

    Packages.fromJson(Map<String, dynamic> json) {
        if(json["type"] is String) {
            type = json["type"];
        }
        if(json["id"] is int) {
            id = json["id"];
        }
        if(json["content"] is String) {
            content = json["content"];
        }
        if(json["name"] is String) {
            name = json["name"];
        }
        if(json["regular_price"] is int) {
            regularPrice = json["regular_price"];
        }
        if(json["price"] is int) {
            price = json["price"];
        }
        if(json["img"] is String) {
            img = json["img"];
        }
        if(json["interval"] is String) {
            interval = json["interval"];
        }
        if(json["period"] is String) {
            period = json["period"];
        }
        if(json["start_date"] is String) {
            startDate = json["start_date"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["type"] = type;
        _data["id"] = id;
        _data["content"] = content;
        _data["name"] = name;
        _data["regular_price"] = regularPrice;
        _data["price"] = price;
        _data["img"] = img;
        _data["interval"] = interval;
        _data["period"] = period;
        _data["start_date"] = startDate;
        return _data;
    }
}

class Amenities {
  String? enumName;
  String? displayName;
  String? image;

  Amenities({this.enumName, this.displayName, this.image});

  Amenities.fromJson(Map<String, dynamic> json) {
    if (json["enum_name"] is String) {
      enumName = json["enum_name"];
    }
    if (json["display_name"] is String) {
      displayName = json["display_name"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["enum_name"] = enumName;
    _data["display_name"] = displayName;
    _data["image"] = image;
    return _data;
  }
}