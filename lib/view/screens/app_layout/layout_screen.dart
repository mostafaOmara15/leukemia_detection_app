import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../view_model/cubit/app_layout_cubit/app_layout_cubit.dart';
import '../../../view_model/cubit/app_layout_cubit/app_layout_states.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppLayoutCubit(),
        child: BlocConsumer<AppLayoutCubit, AppLayoutStates>(
            listener: (BuildContext context, AppLayoutStates states){},
            builder: (BuildContext context, AppLayoutStates states){
              AppLayoutCubit layoutCubit = AppLayoutCubit.get(context);

              return Scaffold(
                  body: SafeArea(
                    child: Center(
                        child: AppLayoutCubit.appScreens[layoutCubit.selectedIndex]
                    ),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: layoutCubit.selectedIndex,
                    onTap:(index){
                      layoutCubit.onItemTapped(index);
                    },
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home_rounded),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                            "assets/noun-blood-3953224.png",
                            height: 3.5.h,
                            color: layoutCubit.selectedIndex == 1
                              ? Colors.black
                              : Colors.grey
                        ),
                        label: 'Test',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ],
                  )
              );
            }
        )
    );
  }
}
