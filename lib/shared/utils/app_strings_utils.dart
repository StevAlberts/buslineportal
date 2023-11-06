String journeyStatusText( bool isStarted, bool scheduled) {
  String status;
  if(scheduled){
    status = "SCHEDULED";
  }else{
    if (isStarted) {
      status = "STARTED";
    } else {
      status = "ENDED";
    }
  }
  return status;
}
