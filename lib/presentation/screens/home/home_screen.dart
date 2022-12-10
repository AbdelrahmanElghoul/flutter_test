import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/bussiness/home_cubit/home_cubit.dart';
import 'package:test_flutter/presentation/common/error_page.dart';
import 'package:test_flutter/presentation/common/loading_widget.dart';
import 'package:test_flutter/presentation/screens/home/widget/user_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case HomeLoadingState:
                return const LoadingWidget();
              case HomeErrorState:
                state as HomeErrorState;
                return ErrorPage(
                  message: state.exception.message,
                  onRefresh: () {
                    context.read<HomeCubit>().getUsers();
                  },
                );
              default:
                final users = state is HomeSuccessState ? state.users : [];
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (_, i) => UserItemWidget(users[i]),
                );
            }
          },
        ),
      ),
    );
  }
}
