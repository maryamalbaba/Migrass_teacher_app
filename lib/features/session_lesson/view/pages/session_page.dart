import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/services_locator.dart';
import 'package:teacher/core/widgets/custom_appbar.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';
import 'package:teacher/core/enums/controller_status.dart';
import '../../../../core/resource/colors_manager.dart';
import '../bloc/session_bloc.dart';
import '../bloc/session_event.dart';
import '../bloc/session_state.dart';
import '../widget/session_card.dart';

class SessionPage extends StatelessWidget {
  final int circleId;

  const SessionPage({super.key, required this.circleId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionBloc(sl(), sl())
        ..add(FetchSessionEvent(circleId: circleId)),
      child: Scaffold(
        backgroundColor: lightGreen1,
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(                    ImagesManager.greenBcak,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: double.infinity,

                  child: CustomAppbar(title: 'الدروس'),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),

                ),
                child: BlocBuilder<SessionBloc, SessionState>(
                  builder: (context, state) {
                    if (state.fetchSessionStatus == ControllerStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.fetchSessionStatus == ControllerStatus.error) {
                      return Center(child: Text(state.message));
                    } else if (state.fetchSessionStatus == ControllerStatus.loaded) {
                      if (state.sessions.isEmpty) {
                        return const Center(child: Text('لا توجد جلسات'));
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: state.sessions.length,
                        itemBuilder: (context, index) {
                          final session = state.sessions[index];
                          return SessionCard(
                            title: session.title,
                            subtitle: session.description,
                            onTap: () {
                              print('Session ${session.title} tapped');
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<SessionBloc, SessionState>(
          builder: (context, state) {
            return InkWell(
              onTap: () => createSessionDialog(context),
              child: Container(
                height: 66,
                width: 66,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                      color: lightGreen1
                ),
                  child:  Icon(Icons.add,color: white,size: 40,)),
            );
          },
        ),
      ),
    );
  }

  void createSessionDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<SessionBloc>(), // Propagate SessionBloc to dialog
          child: AlertDialog(
            title: const Text('إنشاء جلسة جديدة'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'العنوان'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'الوصف'),
                  ),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(labelText: 'التاريخ (YYYY-MM-DD)'),
                    readOnly: true,
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: dialogContext,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('إلغاء'),
              ),
              BlocConsumer<SessionBloc, SessionState>(
                listener: (context, state) {
                  if (state.createSessionStatus == ControllerStatus.loaded) {
                    context.read<SessionBloc>().add(FetchSessionEvent(circleId: circleId));
                    Navigator.pop(dialogContext); // Close dialog after success
                  } else if (state.createSessionStatus == ControllerStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return TextButton(
                    onPressed: state.createSessionStatus == ControllerStatus.loading
                        ? null
                        : () {
                      final session = SessionRequestModel(
                        title: titleController.text,
                        date: dateController.text,
                        description: descriptionController.text,
                      );
                      context.read<SessionBloc>().add(
                        CreateSessionEvent(
                          circleId: circleId,
                          session: session,
                        ),
                      );
                    },
                    child: state.createSessionStatus == ControllerStatus.loading
                        ? const CircularProgressIndicator()
                        : const Text('إنشاء'),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}