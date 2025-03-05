import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/event_create_cubit.dart';
import '../widget/customfield_event.dart';
import '../widget/customfield_event_date.dart';
import '../widget/customfield_event_foto.dart';
import '../widget/customfield_event_time.dart';
import '../../../widgets/button/custom_button.dart';
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
        final cubit = context.read<EventCreateCubit>();

        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
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
                size: 24,
              ),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: Column(
                children: [
                  const CustomfieldEventFoto(),
                  SizedBox(height: 15),
                  CustomFieldEventDate(),
                  SizedBox(height: 5),
                  CustomFieldEventTime(),
                  SizedBox(height: 5),
                  const CustomfieldEvent(),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Posting",
                      isLoading: state.isLoading,
                      onPressed: () {
                        cubit.submit(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
