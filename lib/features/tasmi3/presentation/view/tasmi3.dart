import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:teacher/core/config/sharedPreferences_manager.dart';
import 'package:teacher/core/network/network.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/resource/navigator_manager.dart';
import 'package:teacher/core/resource/route_const.dart';
import 'package:teacher/core/widgets/green_container.dart';
import 'package:teacher/core/widgets/moving_container.dart';
import 'package:teacher/features/tasmi3/data/data_sourse/Local1/local_tasmi3group.dart';
import 'package:teacher/features/tasmi3/data/data_sourse/remote/remote_tasmi3group.dart';
import 'package:teacher/features/tasmi3/data/repository/repo_impl.dart';
import 'package:teacher/features/tasmi3/domain/repository/repositry_tasmi3group.dart';
import 'package:teacher/features/tasmi3/domain/use_case/get_tasmi3_group_usecase.dart';
import 'package:teacher/features/tasmi3/presentation/bloc/tasmi3_group_bloc.dart';

import 'package:teacher/features/tasmi3/data/repository/repo_impl.dart';
import 'package:teacher/features/tasmi3/domain/repository/repositry_tasmi3group.dart';
import 'package:teacher/features/tasmi3/domain/use_case/get_tasmi3_group_usecase.dart';
import 'package:teacher/features/tasmi3/presentation/bloc/tasmi3_group_bloc.dart';

class tasmi3UI extends StatefulWidget {
  tasmi3UI({super.key});

  @override
  State<tasmi3UI> createState() => _tasmi3UIState();
}

class _tasmi3UIState extends State<tasmi3UI> {
  int currentIndex = 0;
//  GetAllTasmi3GroupUseCase? useCase_tasmi3group;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Tasmi3GroupBloc(GetAllTasmi3GroupUseCase(
          repo: Tasmi3groupRepoImpl(
              locaTasmi3groupDataSource: LocalTasmi3groupDataSource(),
              networkConnection: NetworkConnection(
                  connection: InternetConnectionChecker.createInstance()),
              remoteTasmi3groupDataSource: RemoteTasmi3groupDataSource())))
        ..add(GetTsmi3CircleTeacherEvent()),
      child: BlocBuilder<Tasmi3GroupBloc, Tasmi3GroupState>(
        builder: (context, state) {
          if (state is SucessGetTasmi3GroupeState) {
            final succeslist = state.succeslist;
            if (currentIndex >= succeslist.length) {
              currentIndex = 0;
            }
            final currentGroup = succeslist[currentIndex];
            final currentCircles = currentGroup.circles;

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: lightGreen2),
              child: Column(
                children: [
                  SafeArea(
                    child: Stack(children: [
                      Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset(
                              width: MediaQuery.of(context).size.width * 0.5,
                              ImagesManager.moon,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 6,
                        right: 7,
                        left: 16,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: 200,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MovingContainer(
                                    ontap: () {
                                      setState(() {
                                        if (currentIndex <
                                            succeslist.length - 1)
                                          currentIndex++;
                                      });
                                    },
                                    iconData:
                                        Icon(color: white, Icons.arrow_back)),
                                SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    currentGroup.type,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                SizedBox(width: 8),
                                MovingContainer(
                                    ontap: () {
                                      setState(() {
                                        if (currentIndex > 0) currentIndex--;
                                      });
                                    },
                                    iconData: Icon(
                                        color: white, Icons.arrow_forward)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: currentCircles.isEmpty
                          ? Center(child: Text("لا يوجد حلقات لك هنا"))
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: currentCircles.length,
                              itemBuilder: (context, index2) {
                                return SizedBox(
                                  width: 100,
                                  height: 130,
                                  child: InkWell(
                                    onTap: () {
                                      AppNavigator.instance.push(
                                          name: RouteConst.Tasmi3SessionUi,
                                          extra: currentCircles[index2].id,
                                          );

                                    },
                                    child: greenContainer(
                                      name: currentCircles[index2].name,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ErrorTasmi3GroupeState) {
            return Text(state.e.message);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
