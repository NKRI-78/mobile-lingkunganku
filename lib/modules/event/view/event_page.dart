import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../misc/colors.dart';
import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../../../repositories/event_repository/models/event_model.dart';
import '../../../router/builder.dart';
import '../cubit/event_cubit.dart';
import '../widget/custom_card_event_section.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<EventCubit>()..fetchEvent(),
      child: const EventView(),
    );
  }
}

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  List<EventModel> _getEventsForSelectedDay(
      DateTime? selectedDay, List<EventModel> events) {
    if (selectedDay == null) return [];
    final normalizedSelectedDay = _normalizeDate(selectedDay);

    return events.where((event) {
      final start = _normalizeDate(event.startDate.toLocal());
      final end = _normalizeDate(event.endDate.toLocal());

      return (normalizedSelectedDay.isAfter(start) ||
              isSameDay(normalizedSelectedDay, start)) &&
          (normalizedSelectedDay.isBefore(end) ||
              isSameDay(normalizedSelectedDay, end));
    }).toList();
  }

  Map<DateTime, List<EventModel>> _groupEventsByDate(List<EventModel> events) {
    Map<DateTime, List<EventModel>> groupedEvents = {};

    for (var event in events) {
      DateTime currentDay = _normalizeDate(event.startDate.toLocal());
      final endDay = _normalizeDate(event.endDate.toLocal());

      while (!currentDay.isAfter(endDay)) {
        if (groupedEvents[currentDay] == null) {
          groupedEvents[currentDay] = [];
        }
        groupedEvents[currentDay]!.add(event);
        currentDay = currentDay.add(const Duration(days: 1));
      }
    }
    return groupedEvents;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        final String role = (state.profile?.roleApp ?? 'MEMBER').toUpperCase();
        // print("Role Pengguna: ${state.profile?.roleApp}");

        return RefreshIndicator(
          color: AppColors.secondaryColor,
          onRefresh: () async {
            await context.read<EventCubit>().fetchEvent();
            return;
          },
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              backgroundColor: AppColors.whiteColor,
              surfaceTintColor: Colors.transparent,
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.3),
              title: Text(
                'Event',
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
              actions: [
                if (role != "MEMBER" && role != "SECRETARY")
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.buttonColor2,
                      size: 26,
                    ),
                    onPressed: () {
                      EventCreateRoute().push(context);
                    },
                  ),
              ],
            ),
            body: BlocBuilder<EventCubit, EventState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  );
                }

                if (state.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      "Error: ${state.errorMessage}",
                      style:
                          AppTextStyles.textStyle2.copyWith(color: Colors.red),
                    ),
                  );
                }

                final groupedEvents = _groupEventsByDate(state.events ?? []);
                final filteredEvents =
                    _getEventsForSelectedDay(_selectedDay, state.events ?? []);

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 4,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TableCalendar(
                              locale: 'id_ID',
                              firstDay: DateTime.utc(2020, 1, 1),
                              lastDay: DateTime.utc(2030, 12, 31),
                              focusedDay: _focusedDay,
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              },
                              eventLoader: (day) {
                                final normalizedDay = _normalizeDate(day);
                                return groupedEvents[normalizedDay] ?? [];
                              },
                              headerStyle: HeaderStyle(
                                formatButtonVisible: false,
                                titleTextStyle: AppTextStyles.textStyle2
                                    .copyWith(fontWeight: FontWeight.bold),
                                titleCentered: true,
                                leftChevronIcon: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 24,
                                    ),
                                    color: AppColors.secondaryColor,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        _focusedDay = _focusedDay
                                            .subtract(const Duration(days: 30));
                                      });
                                    },
                                  ),
                                ),
                                rightChevronIcon: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_forward_ios,
                                        size: 24),
                                    color: AppColors.secondaryColor,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        _focusedDay = _focusedDay
                                            .add(const Duration(days: 30));
                                      });
                                    },
                                  ),
                                ),
                              ),
                              calendarStyle: CalendarStyle(
                                todayDecoration: BoxDecoration(
                                  color: AppColors.textColor1.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                selectedDecoration: const BoxDecoration(
                                  color: AppColors.textColor1,
                                  shape: BoxShape.circle,
                                ),
                                markerDecoration: BoxDecoration(
                                  color: AppColors.textColor1,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              calendarBuilders: CalendarBuilders(
                                markerBuilder: (context, date, events) {
                                  if (events.isNotEmpty) {
                                    return Positioned(
                                      right: 2,
                                      bottom: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: AppColors.textColor2,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '${events.length}',
                                          style:
                                              AppTextStyles.textStyle2.copyWith(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        filteredEvents.isEmpty
                            ? Center(
                                heightFactor: 12,
                                child: Text(
                                  "Tidak ada event pada tanggal ini.",
                                  style: AppTextStyles.textStyle2
                                      .copyWith(fontSize: 14),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: filteredEvents.length,
                                itemBuilder: (context, index) {
                                  final event = filteredEvents[index];
                                  return CustomCardEventSection(
                                    imageUrl: event.imageUrl,
                                    title: event.title,
                                    startDate: event.startDate,
                                    endDate: event.endDate,
                                    onTap: () {
                                      EventDetailRoute(idEvent: event.id)
                                          .go(context);
                                    },
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
