abstract class DependencyInjector {
  static late DependencyInjector injector;

  T getInstance<T extends Object>({
    List<Type>? typesInRequestList,
    T? defaultValue,
  });

  static T get<T extends Object>({
    List<Type>? typesInRequestList,
    T? defaultValue,
  }) {
    return injector.getInstance(
        typesInRequestList: typesInRequestList, defaultValue: defaultValue);
  }
}
