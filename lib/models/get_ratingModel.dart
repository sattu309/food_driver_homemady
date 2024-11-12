class RatingModel {
  bool? status;
  String? message;
  Data? data;

  RatingModel({this.status, this.message, this.data});

  RatingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ReviewsList>? reviewsList;
  String? avgRating;
  List<TotalReviews>? totalReviews;
  int? reviewsCount;

  Data(
      {this.reviewsList, this.avgRating, this.totalReviews, this.reviewsCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reviewsList'] != null) {
      reviewsList = <ReviewsList>[];
      json['reviewsList'].forEach((v) {
        reviewsList!.add(ReviewsList.fromJson(v));
      });
    }
    avgRating = json['avg_rating'];
    if (json['totalReviews'] != null) {
      totalReviews = <TotalReviews>[];
      json['totalReviews'].forEach((v) {
        totalReviews!.add(TotalReviews.fromJson(v));
      });
    }
    reviewsCount = json['ReviewsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reviewsList != null) {
      data['reviewsList'] = reviewsList!.map((v) => v.toJson()).toList();
    }
    data['avg_rating'] = avgRating;
    if (totalReviews != null) {
      data['totalReviews'] = totalReviews!.map((v) => v.toJson()).toList();
    }
    data['ReviewsCount'] = reviewsCount;
    return data;
  }
}

class ReviewsList {
  int? id;
  String? userName;
  String? profileImage;
  String? review;
  String? date;
  String? isDelivery;

  ReviewsList(
      {this.id, this.userName, this.profileImage, this.isDelivery, this.review, this.date});

  ReviewsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    profileImage = json['profile_image'];
    review = json['review'];
    isDelivery = json['is_delivery'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['is_delivery'] = isDelivery;
    data['profile_image'] = profileImage;
    data['review'] = review;
    data['date'] = date;
    return data;
  }
}

class TotalReviews {
  String? avg;
  String? title;
  bool? show;

  TotalReviews({this.avg, this.title, this.show});

  TotalReviews.fromJson(Map<String, dynamic> json) {
    avg = json['avg'];
    title = json['title'];
    show = json['show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avg'] = avg;
    data['title'] = title;
    data['show'] = show;
    return data;
  }
}
