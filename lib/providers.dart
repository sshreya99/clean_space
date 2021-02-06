import 'package:provider/provider.dart';

class ProviderInjector {
  static List<SingleChildCloneableWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._consumableServices,
  ];
  static List<SingleChildCloneableWidget> _independentServices = [

  ];
  static List<SingleChildCloneableWidget> _dependentServices = [];

  static List<SingleChildCloneableWidget> _consumableServices = [];
}