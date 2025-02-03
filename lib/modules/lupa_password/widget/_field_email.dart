// part of '../view/lupa_password_page.dart';

// class _FieldEmail extends StatelessWidget {
//   const _FieldEmail();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
//         builder: (context, state) {
//       return CustomTextField(
//         labelText: 'Email',
//         isEmail: true,
//         onChanged: (p0) {
//           var cubit = context.read<ForgotPasswordCubit>();
//           cubit.copyState(newState: cubit.state.copyWith(email: p0));
//         },
//         hintText: "",
//         emptyText: "Email wajib di isi",
//         fillColor: whiteColor.withOpacity(0.10),
//         textInputType: TextInputType.emailAddress,
//         textInputAction: TextInputAction.next,
//       );
//     });
//   }
// }
