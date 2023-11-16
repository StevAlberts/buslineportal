String journeyStatusText( bool isStarted) {
  String status;

    if (isStarted) {
      status = "STARTED";
    } else {
      status = "SCHEDULED";
    }

  return status;
}
