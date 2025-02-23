import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_lingkunganku/modules/event_create/cubit/event_create_cubit.dart';
import 'package:mobile_lingkunganku/modules/event_create/widget/customfield_event.dart';
import 'package:mobile_lingkunganku/modules/event_create/widget/customfield_event_foto.dart';
import 'package:mobile_lingkunganku/widgets/button/custom_button.dart';
import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class EventCreatePage extends StatelessWidget {
  const EventCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventCreateCubit(),
      child: const EventCreateView(),
    );
  }
}

class EventCreateView extends StatelessWidget {
  const EventCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCreateCubit, EventCreateState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            surfaceTintColor: Colors.transparent,
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.3),
            title: Text(
              'Create Event',
              style: AppTextStyles.textStyle1,
            ),
            centerTitle: true,
            toolbarHeight: 100,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.buttonColor2,
                size: 30,
              ),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 20,
                children: [
                  CustomfieldEventFoto(),
                  CustomfieldEvent(),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Posting",
                      isLoading: state.isLoading,
                      onPressed: () {
                        context.read<EventCreateCubit>().submit(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
