part of meeting_core;

abstract class TimeConsumingOperation {
  final int _startTime;
  int _endTime = 0;
  Stopwatch _stopwatch;
  int _duration = 0;
  int _adjustDuration = 0;
  int? _code;
  String? _msg;
  String? _requestId;
  int _serverCost = 0;

  TimeConsumingOperation({int? startTime})
      : _startTime = startTime ?? DateTime.now().millisecondsSinceEpoch,
        _stopwatch = Stopwatch()..start();

  TimeConsumingOperation setResult(
    int code, [
    String? message,
    String? requestId,
    int serverCost = 0,
  ]) {
    if (_code == null) {
      _code = code;
      _msg = message;
      _requestId = requestId;
      _serverCost = serverCost;
      _endTime = DateTime.now().millisecondsSinceEpoch;
      _duration = _stopwatch.elapsedMilliseconds - _adjustDuration;
    }
    return this;
  }

  final params = <String, dynamic>{};

  TimeConsumingOperation setParams(Map<String, dynamic> params) {
    this.params
      ..clear()
      ..addAll(params);
    return this;
  }

  TimeConsumingOperation addParam(String key, dynamic value) {
    if (value != null) params[key] = value;
    return this;
  }

  TimeConsumingOperation removeParam(String key) {
    params.remove(key);
    return this;
  }

  void setAdjustDuration(int durationInMillis) {
    _adjustDuration = durationInMillis;
  }

  void addAdjustDuration(int durationInMillis) {
    _adjustDuration += durationInMillis;
  }

  Map<String, dynamic> toMap() {
    final props = {
      'timeStamp': _startTime,
      'startTime': _startTime,
      'endTime': _endTime,
      'duration': _duration,
      if (_code != null) 'code': _code,
      if (_msg != null) 'message': _msg,
      if (_requestId != null) 'requestId': _requestId,
      if (_serverCost != 0) 'serverCost': _serverCost,
      if (params.isNotEmpty) 'params': params,
    };
    return props;
  }
}

class IntervalStep extends TimeConsumingOperation {
  final String name;

  IntervalStep(this.name);

  @override
  Map<String, dynamic> toMap() {
    final props = super.toMap();
    props['step'] = name;
    return props;
  }
}

enum EventPriority {
  LOW,
  NORMAL,
  HIGH,
}

abstract class Event {
  String get eventId;
  EventPriority get priority;
  Map<String, dynamic> toMap();
}

class IntervalEvent extends TimeConsumingOperation implements Event {
  @override
  final String eventId;

  final EventPriority priority;

  final steps = LinkedHashMap<String, IntervalStep>();

  IntervalEvent(
    this.eventId, {
    this.priority = EventPriority.NORMAL,
    int? startTime,
  }) : super(startTime: startTime);

  IntervalStep beginStep(String name) {
    steps.remove(name);
    final step = IntervalStep(name);
    steps[name] = step;
    return step;
  }

  IntervalEvent endStep(
    int code, [
    String? message,
    String? requestId,
    int serverCost = 0,
  ]) {
    _currentStep()?.setResult(code, message, requestId, serverCost);
    return this;
  }

  IntervalStep? getStep(String name) {
    return steps[name];
  }

  IntervalStep? _currentStep() {
    return steps.isNotEmpty ? steps.values.elementAt(steps.length - 1) : null;
  }

  @override
  Map<String, dynamic> toMap() {
    final lastStep = _currentStep();
    if (_code == null && lastStep != null && lastStep._code != null) {
      setResult(lastStep._code!, lastStep._msg, lastStep._requestId);
    }
    final props = super.toMap();
    final itemList = steps.values.toList();
    if (itemList.isNotEmpty) {
      props['steps'] = itemList.asMap().entries.map((entry) {
        final index = entry.key;
        final intervalStep = entry.value;
        final stepMap = intervalStep.toMap();
        stepMap['index'] = index;
        return stepMap;
      }).toList();
    }
    return props;
  }
}

extension IntervalEventExtension on IntervalEvent {
  IntervalEvent endStepWithResult<T>(NEResult<T> result) {
    return endStep(result.code, result.msg, result.requestId, result.cost);
  }
}

extension FutureResultExtension<T> on Future<NEResult<T>> {
  Future<NEResult<T>> thenEndStep(IntervalEvent? event) {
    return then<NEResult<T>>((value) {
      event?.endStep(value.code, value.msg, value.requestId, value.cost);
      return value;
    });
  }
}

extension ReportEvent on NERoomKit {
  Future<bool> reportEvent(Map<String, dynamic> event) async {
    assert(() {
      print('RoomKit reportEvent: ${jsonEncode(event)}');
      return true;
    }());
    return (await invokeMethod('reportEvent', event)) == true;
  }
}
