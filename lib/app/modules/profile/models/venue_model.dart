
class VenueModel {
    String? status;
    Data? data;

    VenueModel({this.status, this.data});

    VenueModel.fromJson(Map<String, dynamic> json) {
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
    dynamic contactNo;
    dynamic headCoach;
    dynamic sessionTimings;
    dynamic skillLevel;
    bool? floodLights;
    dynamic coachExperience;
    dynamic noOfAssistantCoach;
    dynamic assistantCoachName;
    int? partnerId;
    List<Amenities>? amenities;
    String? image;
    String? type;
    List<Slots>? slots;

    Data1({this.currencySymbol, this.currency, this.id, this.title, this.content, this.address, this.latitude, this.longitude, this.contactNo, this.headCoach, this.sessionTimings, this.skillLevel, this.floodLights, this.coachExperience, this.noOfAssistantCoach, this.assistantCoachName, this.partnerId, this.amenities, this.image, this.type, this.slots});

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
        contactNo = json["contact_no"];
        headCoach = json["head_coach"];
        sessionTimings = json["session_timings"];
        skillLevel = json["skill_level"];
        if(json["flood_lights"] is bool) {
            floodLights = json["flood_lights"];
        }
        coachExperience = json["coach_experience"];
        noOfAssistantCoach = json["no_of_assistant_coach"];
        assistantCoachName = json["assistant_coach_name"];
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
        if(json["slots"] is List) {
            slots = json["slots"] == null ? null : (json["slots"] as List).map((e) => Slots.fromJson(e)).toList();
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
        if(slots != null) {
            _data["slots"] = slots?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Slots {
    int? available;
    String? interval;
    int? slotCost;
    String? startDateTime;
    String? startTime;
    String? slotName;

    Slots({this.available, this.interval, this.slotCost, this.startDateTime, this.startTime, this.slotName});

    Slots.fromJson(Map<String, dynamic> json) {
        if(json["available"] is int) {
            available = json["available"];
        }
        if(json["interval"] is String) {
            interval = json["interval"];
        }
        if(json["slot_cost"] is int) {
            slotCost = json["slot_cost"];
        }
        if(json["start_date_time"] is String) {
            startDateTime = json["start_date_time"];
        }
        if(json["start_time"] is String) {
            startTime = json["start_time"];
        }
        if(json["slot_name"] is String) {
            slotName = json["slot_name"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["available"] = available;
        _data["interval"] = interval;
        _data["slot_cost"] = slotCost;
        _data["start_date_time"] = startDateTime;
        _data["start_time"] = startTime;
        _data["slot_name"] = slotName;
        return _data;
    }
}

class Amenities {
    String? enumName;
    String? displayName;

    Amenities({this.enumName, this.displayName});

    Amenities.fromJson(Map<String, dynamic> json) {
        if(json["enum_name"] is String) {
            enumName = json["enum_name"];
        }
        if(json["display_name"] is String) {
            displayName = json["display_name"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["enum_name"] = enumName;
        _data["display_name"] = displayName;
        return _data;
    }
}