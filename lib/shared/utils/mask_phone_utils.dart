String maskPhoneNumber(String phoneNumber) {
  if (phoneNumber.length >= 10) {
    // Get the first 3 characters of the phone number
    String prefix = phoneNumber.substring(0, 3);

    // Get the last 3 characters of the phone number
    String suffix = phoneNumber.substring(phoneNumber.length - 3);

    // Create the masked phone number
    String maskedPhoneNumber = '$prefix****$suffix';

    return maskedPhoneNumber;
  } else {
    // Handle cases where the phone number is too short to mask
    return phoneNumber;
  }
}