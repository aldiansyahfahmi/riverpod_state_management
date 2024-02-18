import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_state_management/presentation/users/provider/users_provider.dart';
import 'package:riverpod_state_management/utils/state/view_data_state.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(usersNotifierProvider.notifier).getUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Consumer(
        builder: (context, widRef, child) {
          final state = widRef.watch(usersNotifierProvider).usersState;
          log(state.status.toString());
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status.isError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state.status.isNoData) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state.status.isHasData) {
            final users = state.data!;
            return ListView.separated(
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: Image.network(user.avatar!),
                  title: Text(user.firstName!),
                  subtitle: Text(user.email!),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: users.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
