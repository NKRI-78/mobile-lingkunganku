part of '../view/forum_create_page.dart';

class InputDescription extends StatelessWidget {
  const InputDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForumCreateCubit, ForumCreateState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Deskripsi",
              //   style: AppTextStyles.textRegister2,
              // ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    width: 1,
                    color: AppColors.secondaryColor.withOpacity(0.3),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1.0,
                        blurRadius: 3.0,
                        offset: const Offset(0.0, 1.0),
                      )
                    ],
                  ),
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1000),
                    ],
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 4,
                    maxLines: null,
                    style: AppTextStyles.textDialog,
                    onChanged: (value) {
                      final ct = context.read<ForumCreateCubit>();
                      ct.copyState(
                          newState: ct.state.copyWith(description: value));
                    },
                    cursorColor: AppColors.greyColor,
                    decoration: InputDecoration(
                      hintText: "Apa yang kamu pikirkan...",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 15.0),
                      isDense: true,
                      hintStyle: TextStyle(
                        color: AppColors.greyColor.withOpacity(0.8),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
