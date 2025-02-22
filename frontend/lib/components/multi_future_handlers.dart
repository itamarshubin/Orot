import 'package:flutter/material.dart';

class MultiFutureHandler<T> extends StatelessWidget {
  final List<Future<T>> futures;
  final Widget Function(BuildContext, List<T>) onSuccess;
  final Widget Function(BuildContext, Object?)? onError;
  final Widget Function(BuildContext)? onLoading;

  const MultiFutureHandler({
    super.key,
    required this.futures,
    required this.onSuccess,
    this.onError,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: Future.wait(futures),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return onLoading?.call(context) ??
              Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return onError?.call(context, snapshot.error) ??
              Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return onSuccess(context, snapshot.data!);
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}
