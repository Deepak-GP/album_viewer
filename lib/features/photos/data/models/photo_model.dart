import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/photo.dart';

part 'photo_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class PhotoModel extends Photo {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int photoId;

  @HiveField(1)
  @JsonKey(name: 'albumId')
  final int photoAlbumId;

  @HiveField(2)
  @JsonKey(name: 'title')
  final String photoTitle;

  @HiveField(3)
  @JsonKey(name: 'url')
  final String photoUrl;

  @HiveField(4)
  @JsonKey(name: 'thumbnailUrl')
  final String photoThumbnailUrl;

  const PhotoModel({
    required this.photoId,
    required this.photoAlbumId,
    required this.photoTitle,
    required this.photoUrl,
    required this.photoThumbnailUrl,
  }) : super(
          id: photoId,
          albumId: photoAlbumId,
          title: photoTitle,
          url: photoUrl,
          thumbnailUrl: photoThumbnailUrl,
        );

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);

  factory PhotoModel.fromEntity(Photo photo) {
    return PhotoModel(
      photoId: photo.id,
      photoAlbumId: photo.albumId,
      photoTitle: photo.title,
      photoUrl: photo.url,
      photoThumbnailUrl: photo.thumbnailUrl,
    );
  }
}
