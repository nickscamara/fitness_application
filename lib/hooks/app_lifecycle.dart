import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

useWidgetLifecycleObserver(BuildContext context) {
  return use(const _WidgetObserver());
}

class _WidgetObserver extends Hook<void> {
  const _WidgetObserver();

  @override
  HookState<void, Hook<void>> createState() {
    return _WidgetObserverState();
  }
}

class _WidgetObserverState extends HookState<void, _WidgetObserver> with WidgetsBindingObserver {
   AppLifecycleState _state = AppLifecycleState.resumed;
  
  @override
  AppLifecycleState build(BuildContext context) {
    return _state;
  }

  @override
  void initHook() {
    super.initHook();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("app state now is $state");
    super.didChangeAppLifecycleState(state);
    setState(() {
      _state = state;
    });
  }
}