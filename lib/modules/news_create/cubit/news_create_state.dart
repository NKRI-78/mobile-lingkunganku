part of 'news_create_cubit.dart';

class NewsCreateState extends Equatable {
  final String title;
  final String content;
  final String linkImage;
  final File? imageFile;
  final bool isLoading;
  final String successMessage;
  final String? errorMessage;

  const NewsCreateState({
    this.title = '',
    this.content = '',
    this.linkImage = '',
    this.imageFile,
    this.isLoading = false,
    this.successMessage = '',
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        title,
        content,
        linkImage,
        imageFile,
        isLoading,
        successMessage,
        errorMessage,
      ];

  NewsCreateState copyWith({
    String? title,
    String? content,
    String? linkImage,
    ValueGetter<File?>? imageFile,
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return NewsCreateState(
      title: title ?? this.title,
      content: content ?? this.content,
      linkImage: linkImage ?? this.linkImage,
      imageFile: imageFile != null ? imageFile() : this.imageFile,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
