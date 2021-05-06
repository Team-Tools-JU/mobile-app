import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/models/implementation/settings_controller.dart';
import 'package:mobile_app/src/app/views/steering/steering_view.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  SettingsController _controller = GetIt.I<SettingsController>();

  late bool _simulationMode;
  late bool _manualSteering;

  bool get simulationMode => _simulationMode;
  bool get manualSteering => _manualSteering;

  void init() {
    _simulationMode = false;
    _manualSteering = false;

    _controller.steeringEnabled.stream.listen((steering) {
      _manualSteering = steering;
      if (steering) {
        Future.delayed(Duration(seconds: 1), () => Get.off(SteeringView()));
      }
      notifyListeners();
    });
  }

  void activateSteering() {
    _controller.steeringEnabled.add(true);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
