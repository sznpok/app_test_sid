class AdResponse {
  final bool status;
  final String message;
  final AdData data;

  AdResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AdResponse.fromJson(Map<String, dynamic> json) {
    return AdResponse(
      status: json['status'],
      message: json['message'],
      data: AdData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class AdData {
  final Map<String, List<Ad>> ads;

  AdData({required this.ads});

  factory AdData.fromJson(Map<String, dynamic> json) {
    return AdData(
      ads: (json['ads'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List).map((ad) => Ad.fromJson(ad)).toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ads': ads.map(
        (key, value) => MapEntry(
          key,
          value.map((ad) => ad.toJson()).toList(),
        ),
      ),
    };
  }
}

class Ad {
  final int id;
  final String title;
  final String redirectUrl;
  final String? expDate;
  final List<String>? images;
  final String placement;
  final String status;

  Ad({
    required this.id,
    required this.title,
    required this.redirectUrl,
    this.expDate,
    this.images,
    required this.placement,
    required this.status,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json['id'],
      title: json['title'],
      redirectUrl: json['redirect_url'],
      expDate: json['exp_date'],
      images: _parseImages(json['images']),
      placement: json['placement'],
      status: json['status'],
    );
  }

  static List<String>? _parseImages(dynamic images) {
    if (images is String && images.isEmpty) {
      return null;
    } else if (images is List) {
      return List<String>.from(images);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'redirect_url': redirectUrl,
      'exp_date': expDate,
      'images': images,
      'placement': placement,
      'status': status,
    };
  }
}
