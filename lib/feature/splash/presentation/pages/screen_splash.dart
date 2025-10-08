import 'package:blocsevendays/core/navigation/app_router.dart';
import 'package:blocsevendays/feature/splash/presentation/bloc/bloc_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/custom_error_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _getKey();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.status == SplashStatus.failure) {
            SnackbarUtils.showErrorSnackbar(context, state.errorMessage!);
          } else if (state.status == SplashStatus.success) {
            _toMainPage();
          }
        },
        builder: (context, state) {
          if (state.key.isNotEmpty) {
            return Center(
                child: Text(state.key)
            );
          } else {
            return SizedBox(
              child: Container(
                color: Colors.red,
              ),

            );
          }

        },
      ),
    );
  }
  
  void _getKey() {
    context.read<SplashBloc>().add(const GetKeyEvent());
  }

  void _toMainPage() {
    Navigator.popAndPushNamed(
      context,
      AppRouteConstants.mainPage,
    );
  }
  
}