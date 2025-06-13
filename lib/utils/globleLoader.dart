
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../Base/controller/globlLoaderController.dart';

class GlobalLoader extends StatelessWidget {
  const GlobalLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<LoaderController>();
      return controller.isLoading.value
          ? Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: const ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color:Colors.indigo,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: const SpinKitCircle(
                color: Colors.white,
                size: 60.0,
              ),
            ),
          ),
        ],
      )
          : const SizedBox.shrink();
    });
  }
}
