part of 'news_update_cubit.dart';

class NewsUpdateState extends Equatable {
  final int idNews;
  final bool loading;
  final bool success;
  final String? errorMessage;
  final DetailNewsModel? updatedNews;
  final File? fileImage;

  const NewsUpdateState({
    this.idNews = 0,
    this.loading = false,
    this.success = false,
    this.errorMessage,
    this.updatedNews,
    this.fileImage,
  });

  NewsUpdateState copyWith({
    int? idNews,
    bool? loading,
    bool? success,
    String? errorMessage,
    DetailNewsModel? updatedNews,
    ValueGetter<File?>? fileImage,
  }) {
    return NewsUpdateState(
      idNews: idNews ?? this.idNews,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      errorMessage: errorMessage,
      updatedNews: updatedNews ?? this.updatedNews,
      fileImage: fileImage != null ? fileImage() : this.fileImage,
    );
  }

  @override
  List<Object?> get props => [
        idNews,
        loading,
        success,
        errorMessage,
        updatedNews,
        fileImage,
      ];
}
