class Lap{
  int currentTime;
  int lapNum;
  Lap(this.currentTime,this.lapNum);

  toMap(){
    return {
      "currentTime":currentTime,
      "lapNum":lapNum,
    };
  }
}