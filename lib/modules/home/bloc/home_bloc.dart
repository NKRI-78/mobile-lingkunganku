import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/repositories/profile_repository/models/profile_model.dart';
import 'package:mobile_lingkunganku/repositories/profile_repository/profile_repository.dart';
import '../../../misc/injections.dart';
import '../../../misc/location.dart';
import '../../../repositories/home_repository/home_repository.dart';
import '../../../repositories/home_repository/models/data_pagination.dart';
import '../../../repositories/home_repository/models/news_model.dart';
import '../../profile/cubit/profile_cubit.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository repo = HomeRepository();
  final ProfileCubit profileCubit;

  final ProfileRepository profileRepo = getIt<ProfileRepository>();

  HomeBloc(this.repo, this.profileCubit)
      : super(const HomeState(selectedIndex: 0)) {
    on<HomeInit>((event, emit) async {
      await fetchNews(emit, isRefresh: true);
      determinePosition();
      await getProfile(emit);
      add(LoadProfile());
    });

    on<HomeNavigate>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });

    on<HomeFetchMoreNews>((event, emit) async {
      await fetchNews(emit);
    });

    on<HomeCopyState>((event, emit) {
      emit(event.newState);
    });
    on<LoadProfile>((event, emit) async {
      print("🚀 Memuat ulang profil...");
      await _getProfile(emit);
    });

    // 🔥 Dengarkan perubahan ProfileCubit dan muat ulang profil
    profileCubit.stream.listen((profileState) {
      if (profileState.profile != null) {
        add(LoadProfile()); // ✅ Trigger ulang pemuatan profil
      }
    });
  }

  Future<void> _getProfile(Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final profile = await profileRepo.getProfile();
      emit(state.copyWith(profile: profile));
    } catch (e) {
      print("❌ Error saat memuat profil: $e");
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> fetchNews(Emitter<HomeState> emit,
      {bool isRefresh = false}) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    try {
      final int nextPage = isRefresh ? 1 : state.nextPageNews;
      DataPagination<NewsModel> newsData = await repo.getNews(page: nextPage);

      emit(state.copyWith(
        news: isRefresh ? newsData.list : [...state.news, ...newsData.list],
        nextPageNews: newsData.paginate.next ?? state.nextPageNews,
      ));
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> getProfile(Emitter<HomeState> emit) async {
    try {
      print('Fetching profile...'); // Debugging
      emit(state.copyWith(isLoading: true));

      final profile = await profileRepo.getProfile();

      print('Profile fetched: ${profile.profile?.fullname}'); // Debugging
      emit(state.copyWith(profile: profile)); // Memastikan emit state baru
    } catch (e) {
      print('Error fetching profile: $e'); // Debugging
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
