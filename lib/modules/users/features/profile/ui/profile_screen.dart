import '../../../../../core/auth/logic/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            child: const Text("LogOut"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthCubit>().handleUnauthorized();
            },
            child: const Text('Test Session Expired'),
          ),
        ],
      ),
    );
  }
}
