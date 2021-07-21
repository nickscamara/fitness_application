class Lap {
  int currentTime;
  int lapNum;
  Lap(this.currentTime, this.lapNum);

  toMap() {
    return {
      "currentTime": currentTime,
      "lapNum": lapNum,
    };
  }

  Lap.fromMap(Map<String, dynamic> map)
      : currentTime = map['currentTime'],
        lapNum = map['lapNum'];
}
