part of 'forum_create_cubit.dart';

class ForumCreateState extends Equatable {
  final String description;
  final int price;
  final List<String> media;
  final String feedType;
  final String fileSize;
  final String docName;
  final bool isImage;
  final List<File> pickedFile;
  final int nextPageForums;
  final Uint8List? videoFileThumbnail;
  final bool loading;
  final bool loadingUpload;

  const ForumCreateState(
      {this.description = "",
      this.price = 0,
      this.media = const [],
      this.feedType = "",
      this.fileSize = "",
      this.docName = "",
      this.isImage = false,
      this.pickedFile = const [],
      this.nextPageForums = 0,
      this.videoFileThumbnail,
      this.loading = false,
      this.loadingUpload = false});
  @override
  List<Object?> get props => [
        description,
        price,
        media,
        feedType,
        fileSize,
        docName,
        isImage,
        pickedFile,
        nextPageForums,
        videoFileThumbnail,
        loading,
        loadingUpload,
      ];

  ForumCreateState copyWith({
    String? description,
    int? price,
    List<String>? media,
    String? feedType,
    String? fileSize,
    String? docName,
    bool? isImage,
    List<File>? pickedFile,
    int? nextPageForums,
    Uint8List? videoFileThumbnail,
    bool? loading,
    bool? loadingUpload,
  }) {
    return ForumCreateState(
      description: description ?? this.description,
      price: price ?? this.price,
      media: media ?? this.media,
      feedType: feedType ?? this.feedType,
      fileSize: fileSize ?? this.fileSize,
      docName: docName ?? this.docName,
      isImage: isImage ?? this.isImage,
      pickedFile: pickedFile ?? this.pickedFile,
      nextPageForums: nextPageForums ?? this.nextPageForums,
      videoFileThumbnail: videoFileThumbnail ?? this.videoFileThumbnail,
      loading: loading ?? this.loading,
      loadingUpload: loadingUpload ?? this.loadingUpload,
    );
  }
}
