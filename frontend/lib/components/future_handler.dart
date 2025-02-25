import 'package:flutter/material.dart';

class FutureHandler<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext, T) onSuccess;
  final Widget Function(BuildContext, Object?)? onError;
  final Widget Function(BuildContext)? onLoading;

  const FutureHandler({
    super.key,
    required this.future,
    required this.onSuccess,
    this.onError,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return onLoading?.call(context) ??
              Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return onError?.call(context, snapshot.error) ??
              Center(
                child: Text(
                  'Error: ${snapshot.error}\n${snapshot.stackTrace}',
                  textDirection: TextDirection.ltr,
                ),
              );
        } else if (snapshot.hasData) {
          return onSuccess(context, snapshot.data as T);
        } else {
          return Center(
              child: Text(
            'אירעה שגיאה, נסו לרענן את הדף.',
            textDirection: TextDirection.rtl,
          ));
        }
      },
    );
  }
}
