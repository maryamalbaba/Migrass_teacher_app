// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

import 'package:teacher/core/network/network.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/assets_manager.dart'; // Assuming this exists
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/resource/colors_manager.dart'; // Assuming this exists; otherwise, use Colors.*
import 'package:teacher/core/resource/icon_image_manager.dart';
import 'package:teacher/core/resource/icon_image_manager.dart'; // Assuming this exists
import 'package:teacher/core/resource/navigator_manager.dart';
import 'package:teacher/core/resource/route_const.dart';
import 'package:teacher/features/create_tasmi3_siession/data/model/session.dart';
import 'package:teacher/features/create_tasmi3_siession/data/model/session.dart';
import 'package:teacher/features/create_tasmi3_siession/data/repository/repo_impl.dart';
import 'package:teacher/features/create_tasmi3_siession/data/repository/repo_impl.dart';
import 'package:teacher/features/create_tasmi3_siession/data/source/remote/remote_source.dart';
import 'package:teacher/features/create_tasmi3_siession/data/source/remote/remote_source.dart';
import 'package:teacher/features/create_tasmi3_siession/domain/usecase/createTasmi3usecase.dart';
import 'package:teacher/features/create_tasmi3_siession/domain/usecase/createTasmi3usecase.dart';
import 'package:teacher/features/create_tasmi3_siession/presentation/bloc/create_tasmi3_session_bloc.dart';
import 'package:teacher/features/create_tasmi3_siession/presentation/bloc/create_tasmi3_session_bloc.dart';
import 'package:teacher/features/get_session/data/repository/Imp_repository.dart';
import 'package:teacher/features/get_session/data/source/local.dart';
import 'package:teacher/features/get_session/data/source/remote.dart';
import 'package:teacher/features/get_session/domain/usecase/sessiontasmi3.dart';
import 'package:teacher/features/get_session/presenture/bloc/tasmi3_session_bloc.dart';
import 'package:teacher/features/get_session/presenture/view/SesionsTasmi3Ui.dart';
import 'package:teacher/features/tasmi3/presentation/bloc/tasmi3_group_bloc.dart';

class Tasmi3SessionUi extends StatefulWidget {
  Tasmi3SessionUi({
    Key? key,
    required this.circle_id,
    required this.CircleName,
    required this.CircleType,
  }) : super(key: key);
  final num circle_id;
  final  String CircleName;
  final String CircleType;
  @override
  State<Tasmi3SessionUi> createState() => _Tasmi3SessionUiState();
}

class _Tasmi3SessionUiState extends State<Tasmi3SessionUi> {
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? date;
  List<Tasmi3Session> sessions = [];
  @override
  Widget build(BuildContext context) {
    final double stackHeight = MediaQuery.of(context).size.height * 0.20;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateTasmi3SessionBloc(
            CreateTasmi3Usecase(
              repo: RepoImpCreateTasmi3Session(
                r: RemoteSource(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => Tasmi3SessionBloc(
            GetAllTasmiSessionUseCase(
              repo: SessionRepoImpl(
                remoteSessionDataSource: RemoteSessionDataSource(),
                localSessionDataSource: LocalSessionDataSource(),
                 networkMonitor: NetworkMonitor(connectivity: Connectivity(),checker: InternetConnectionChecker.createInstance()),
              ),
            ),
          )..add(getSessionEvent(id: widget.circle_id)),
        ),
      ],
      child: BlocListener<CreateTasmi3SessionBloc, CreateTasmi3SessionState>(
        listener: (context, state) {
          if (state is SuucessCreateTasmi3Session) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم الإرسال بنجاح')),
            );
            context
                .read<Tasmi3SessionBloc>()
                .add(getSessionEvent(id: widget.circle_id));
          } else if (state is FailedTasmi3Session) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('فشل الإرسال: ')),
            );
          }
        },
        child: Builder(
          builder: (innerContext) => Scaffold(
            floatingActionButton: InkWell(
              onTap: () {
                final bloc = innerContext.read<CreateTasmi3SessionBloc>();
                showDialog(
                  context: innerContext,
                  builder: (dialogContext) {
                    return StatefulBuilder(
                      builder: (builderContext, setStateDialog) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            width: 200,
                            height: 150,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        final DateTime? pickedDate =
                                            await showDatePicker(
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2022),
                                          lastDate: DateTime(2100),
                                          context: dialogContext,
                                        );
                                        if (pickedDate != null) {
                                          final newDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          setStateDialog(() {
                                            date = newDate;
                                          });
                                          setState(() {
                                            date =
                                                newDate; // Update parent state
                                          });
                                        }
                                      },
                                      icon: const Icon(Icons.date_range),
                                    ),
                                    Text(date ?? today),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Tasmi3Session session = Tasmi3Session(
                                        circle_id: widget.circle_id,
                                        date: date ?? today);

                                    print(
                                        'Sending session: ${session.toJson()}');
                                    bloc.add(CreateTasmi3SessionEventt(
                                        tasmi3session: session));
                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text("ارسال"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                width: 50,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 135, 192, 146),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            backgroundColor: lightGreen2,
            body: SafeArea(
              child: Column(children: [
                SizedBox(
                  height: stackHeight,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          ImagesManager.greenBcak,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: stackHeight - 16.0,
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                       Text(
                                       widget.CircleName,
                                        style: TextStyle(fontSize: 15),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        DateTime.now().toString(),
                                        style: const TextStyle(fontSize: 12),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                                onTap: () {
                                  AppNavigator.instance
                                      .push(name: RouteConst.CoreUi);
                                },
                                child: backContainer()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SessionUi(
                        circl_id: widget.circle_id, circleType: widget.CircleType,
                      )),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class backContainer extends StatelessWidget {
  const backContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        width: 30,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
          child: Image.asset(IconImageManager.back),
        ),
      ),
    );
  }
}


 //        ListView.builder(
                    //           itemCount: sessions.length,
                    //           itemBuilder: (context, index) {
                    //             final session = sessions[index];
                    //             return InkWell(
                    //               onTap: (){
                    //                   AppNavigator.instance.push(
                    //                       name: RouteConst.studentCircle,
                    //                       extra: sessions[index].circle_id,
                    //                       );

                    //               },
                    //               child: Card(
                    //                 margin: const EdgeInsets.symmetric(
                    //                     vertical: 8, horizontal: 16),
                    //                 child: ListTile(
                    //                   title: Text(
                    //                     'تاريخ الجلسة: ${session.date}',
                    //                     style: const TextStyle(fontSize: 16),
                    //                                         ))),
                    //             );})