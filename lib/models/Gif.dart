//
//     final gif = gifFromJson(jsonString);

import 'dart:convert';

Gif gifFromJson(String str) => Gif.fromJson(json.decode(str));

String gifToJson(Gif data) => json.encode(data.toJson());

class Gif {
  final List<Datum> data;
  final Pagination pagination;
  final Meta meta;

  Gif({
    required this.data,
    required this.pagination,
    required this.meta,
  });

  factory Gif.fromJson(Map<String, dynamic> json) => Gif(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "meta": meta.toJson(),
      };
}

class Datum {
  final Type? type;
  final String? id;
  final String? url;
  final String? slug;
  final String? bitlyGifUrl;
  final String? bitlyUrl;
  final String? embedUrl;
  final String? username;
  final String? source;
  final String? title;
  final Rating? rating;
  final String? contentUrl;
  final String? sourceTld;
  final String? sourcePostUrl;
  final int? isSticker;
  final DateTime? importDatetime;
  final String? trendingDatetime;
  final Images? images;
  final User? user;
  final String? analyticsResponsePayload;
  final Analytics? analytics;

  Datum({
    this.type,
    this.id,
    this.url,
    this.slug,
    this.bitlyGifUrl,
    this.bitlyUrl,
    this.embedUrl,
    this.username,
    this.source,
    this.title,
    this.rating,
    this.contentUrl,
    this.sourceTld,
    this.sourcePostUrl,
    this.isSticker,
    this.importDatetime,
    this.trendingDatetime,
    this.images,
    this.user,
    this.analyticsResponsePayload,
    this.analytics,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: typeValues.map[json["type"]]!,
        id: json["id"],
        url: json["url"],
        slug: json["slug"],
        bitlyGifUrl: json["bitly_gif_url"],
        bitlyUrl: json["bitly_url"],
        embedUrl: json["embed_url"],
        username: json["username"],
        source: json["source"],
        title: json["title"],
        rating: ratingValues.map[json["rating"]]!,
        contentUrl: json["content_url"],
        sourceTld: json["source_tld"],
        sourcePostUrl: json["source_post_url"],
        isSticker: json["is_sticker"],
        importDatetime: json["import_datetime"] == null
            ? null
            : DateTime.parse(json["import_datetime"]),
        trendingDatetime: json["trending_datetime"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        analyticsResponsePayload: json["analytics_response_payload"],
        analytics: json["analytics"] == null
            ? null
            : Analytics.fromJson(json["analytics"]),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "id": id,
        "url": url,
        "slug": slug,
        "bitly_gif_url": bitlyGifUrl,
        "bitly_url": bitlyUrl,
        "embed_url": embedUrl,
        "username": username,
        "source": source,
        "title": title,
        "rating": ratingValues.reverse[rating],
        "content_url": contentUrl,
        "source_tld": sourceTld,
        "source_post_url": sourcePostUrl,
        "is_sticker": isSticker,
        "import_datetime": importDatetime?.toIso8601String(),
        "trending_datetime": trendingDatetime,
        "images": images?.toJson(),
        "user": user?.toJson(),
        "analytics_response_payload": analyticsResponsePayload,
        "analytics": analytics?.toJson(),
      };
}

class Analytics {
  final Onclick onload;
  final Onclick onclick;
  final Onclick onsent;

  Analytics({
    required this.onload,
    required this.onclick,
    required this.onsent,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
        onload: Onclick.fromJson(json["onload"]),
        onclick: Onclick.fromJson(json["onclick"]),
        onsent: Onclick.fromJson(json["onsent"]),
      );

  Map<String, dynamic> toJson() => {
        "onload": onload.toJson(),
        "onclick": onclick.toJson(),
        "onsent": onsent.toJson(),
      };
}

class Onclick {
  final String url;

  Onclick({
    required this.url,
  });

  factory Onclick.fromJson(Map<String, dynamic> json) => Onclick(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Images {
  final FixedHeight original;
  final FixedHeight fixedHeight;
  final FixedHeight fixedHeightDownsampled;
  final FixedHeight fixedHeightSmall;
  final FixedHeight fixedWidth;
  final FixedHeight fixedWidthDownsampled;
  final FixedHeight fixedWidthSmall;

  Images({
    required this.original,
    required this.fixedHeight,
    required this.fixedHeightDownsampled,
    required this.fixedHeightSmall,
    required this.fixedWidth,
    required this.fixedWidthDownsampled,
    required this.fixedWidthSmall,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        original: FixedHeight.fromJson(json["original"]),
        fixedHeight: FixedHeight.fromJson(json["fixed_height"]),
        fixedHeightDownsampled:
            FixedHeight.fromJson(json["fixed_height_downsampled"]),
        fixedHeightSmall: FixedHeight.fromJson(json["fixed_height_small"]),
        fixedWidth: FixedHeight.fromJson(json["fixed_width"]),
        fixedWidthDownsampled:
            FixedHeight.fromJson(json["fixed_width_downsampled"]),
        fixedWidthSmall: FixedHeight.fromJson(json["fixed_width_small"]),
      );

  Map<String, dynamic> toJson() => {
        "original": original.toJson(),
        "fixed_height": fixedHeight.toJson(),
        "fixed_height_downsampled": fixedHeightDownsampled.toJson(),
        "fixed_height_small": fixedHeightSmall.toJson(),
        "fixed_width": fixedWidth.toJson(),
        "fixed_width_downsampled": fixedWidthDownsampled.toJson(),
        "fixed_width_small": fixedWidthSmall.toJson(),
      };
}

class FixedHeight {
  final String height;
  final String width;
  final String size;
  final String url;
  final String? mp4Size;
  final String? mp4;
  final String webpSize;
  final String webp;
  final String? frames;
  final String? hash;

  FixedHeight({
    required this.height,
    required this.width,
    required this.size,
    required this.url,
    this.mp4Size,
    this.mp4,
    required this.webpSize,
    required this.webp,
    this.frames,
    this.hash,
  });

  factory FixedHeight.fromJson(Map<String, dynamic> json) => FixedHeight(
        height: json["height"],
        width: json["width"],
        size: json["size"],
        url: json["url"],
        mp4Size: json["mp4_size"],
        mp4: json["mp4"],
        webpSize: json["webp_size"],
        webp: json["webp"],
        frames: json["frames"],
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
        "size": size,
        "url": url,
        "mp4_size": mp4Size,
        "mp4": mp4,
        "webp_size": webpSize,
        "webp": webp,
        "frames": frames,
        "hash": hash,
      };
}

enum Rating { G }

final ratingValues = EnumValues({"g": Rating.G});

enum Type { gif }

final typeValues = EnumValues({"gif": Type.gif});

class User {
  final String avatarUrl;
  final String bannerImage;
  final String bannerUrl;
  final String profileUrl;
  final String username;
  final String displayName;
  final String description;
  final String instagramUrl;
  final String websiteUrl;
  final bool isVerified;

  User({
    required this.avatarUrl,
    required this.bannerImage,
    required this.bannerUrl,
    required this.profileUrl,
    required this.username,
    required this.displayName,
    required this.description,
    required this.instagramUrl,
    required this.websiteUrl,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatarUrl: json["avatar_url"],
        bannerImage: json["banner_image"],
        bannerUrl: json["banner_url"],
        profileUrl: json["profile_url"],
        username: json["username"],
        displayName: json["display_name"],
        description: json["description"],
        instagramUrl: json["instagram_url"],
        websiteUrl: json["website_url"],
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "banner_image": bannerImage,
        "banner_url": bannerUrl,
        "profile_url": profileUrl,
        "username": username,
        "display_name": displayName,
        "description": description,
        "instagram_url": instagramUrl,
        "website_url": websiteUrl,
        "is_verified": isVerified,
      };
}

class Meta {
  final int status;
  final String msg;
  final String responseId;

  Meta({
    required this.status,
    required this.msg,
    required this.responseId,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        status: json["status"],
        msg: json["msg"],
        responseId: json["response_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "response_id": responseId,
      };
}

class Pagination {
  final int totalCount;
  final int count;
  final int offset;

  Pagination({
    required this.totalCount,
    required this.count,
    required this.offset,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalCount: json["total_count"],
        count: json["count"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "count": count,
        "offset": offset,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
