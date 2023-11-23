String journeyStatusText(bool isStarted, bool isEnded) {
  String status;

  if (isStarted && isEnded) {
    status = "ENDED";
  } else if (isStarted) {
    status = "STARTED";
  } else {
    status = "SCHEDULED";
  }
  return status;
}

bool? journeyStatusStarted(bool isStarted, bool isEnded) {
  bool? status;

  if (isStarted && isEnded) {
    status = false;
  } else if (isStarted) {
    status = true;
  } else {
    status = false;
  }
  return status;
}
