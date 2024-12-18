// ignore_for_file: constant_identifier_names

class VideoCallStateEnum {
  static const int UNKNOWN = 0;
  static const int REQUEST = 1;
  static const int CONNECT = 2;

  // Phương thức trả về tên của trạng thái dựa trên giá trị
  static String getName(int state) {
    switch (state) {
      case REQUEST:
        return 'REQUEST';
      case CONNECT:
        return 'CONNECT';
      default:
        return 'UNKNOWN';
    }
  }

  // Phương thức để lấy giá trị từ tên
  static int getValue(String name) {
    switch (name.toUpperCase()) {
      case 'REQUEST':
        return REQUEST;
      case 'CONNECT':
        return CONNECT;
      default:
        return -1; // Trả về -1 nếu không tìm thấy
    }
  }
}
