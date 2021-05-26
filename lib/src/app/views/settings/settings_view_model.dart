import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth.dart';
import 'package:mobile_app/src/app/models/implementation/mower_commands.dart';
import 'package:mobile_app/src/app/models/implementation/navigation_controller.dart';
import 'package:mobile_app/src/app/models/implementation/settings_controller.dart';
import 'package:mobile_app/src/app/views/navigation/navigation_view.dart';
import 'package:mobile_app/src/app/views/steering/steering_view.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  SettingsController _controller = GetIt.I<SettingsController>();
  Bluetooth _bluetooth = GetIt.I<Bluetooth>();
  NavigationController _navigationController = GetIt.I<NavigationController>();

  late bool _simulationMode;
  late bool _manualSteering;
  late bool autoDriving;
  late bool isConnected;
  bool get simulationMode => _simulationMode;
  bool get manualSteering => _manualSteering;

  void init() {
    _simulationMode = false;
    _manualSteering = false;
    autoDriving = false;
    isConnected = _bluetooth.isConnected;

    _controller.steeringEnabled.stream.listen((steering) {
      _manualSteering = steering;
      if (steering) {
        print("MANUAL STEERING MODE");
        notifyListeners();
        Future.delayed(
            Duration(seconds: 2), () => Get.off(() => SteeringView()));
      }
      //
    });

    _bluetooth.isConnectedStream.stream.listen((state) async {
      _bluetooth.isConnected = isConnected = state;

      if (!isConnected) {
        await _bluetooth.disconnect();
        _navigationController.currentIndex = 0;
        Get.off(NavigationView());
      }
    });
  }

  void activateSteering() {
    _controller.steeringEnabled.add(true);
  }

  void toggleAutoDrive() {
    _bluetooth.write(autoDriving ? MOWER_AUTO_RUN : MOWER_IDLE);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
