part of 'management_detail_cubit.dart';

class ManagementDetailState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final ManagementDetailMemberModel? memberDetail;
  final Members? member;
  final ProfileModel? profile;
  final IuranModel? iuran;
  final bool hasUnpaidInvoice;

  const ManagementDetailState(
      {this.isLoading = false,
      this.errorMessage,
      this.successMessage,
      this.memberDetail,
      this.member,
      this.profile,
      this.iuran,
      this.hasUnpaidInvoice = false});

  ManagementDetailState copyWith(
      {bool? isLoading,
      String? errorMessage,
      String? successMessage,
      ManagementDetailMemberModel? memberDetail,
      Members? member,
      ProfileModel? profile,
      IuranModel? iuran,
      bool? hasUnpaidInvoice}) {
    return ManagementDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          errorMessage ?? (isLoading == false ? this.errorMessage : null),
      successMessage:
          successMessage ?? (isLoading == false ? this.successMessage : null),
      memberDetail: memberDetail ?? this.memberDetail,
      member: member ?? this.member,
      profile: profile ?? this.profile,
      iuran: iuran ?? this.iuran,
      hasUnpaidInvoice: hasUnpaidInvoice ?? this.hasUnpaidInvoice,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        memberDetail,
        member,
        profile,
        iuran,
        successMessage,
        hasUnpaidInvoice,
        DateTime.now(),
      ];
}
