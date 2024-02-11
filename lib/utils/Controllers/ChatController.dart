import 'package:talentsearchenglish/Modals/SocketRequest.dart';
import 'package:talentsearchenglish/utils/Controllers/UserController.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatController extends GetxController {
  final String SOCKET_URI = "https://octopus-app-hg35x.ondigitalocean.app";
  final String SEND_MESSAGE = "sendMessage";
  final String JOIN_ROOM = "joinRoom";
  final String LEAVE_ROOM = "leaveRoom";

  final String LISTEN_MESSAGE = "messageSend";
  final String LISTEN_JOIN = "joined";
  final String LISTEN_LEAVE = "left";
  late Socket socket;
  final Logger logger = Logger();

  UserDetailsManager userDetailsManager = Get.put(UserDetailsManager());
  RxList<SocketData> chatList = RxList.empty();
  void initialiseSocket() {
    socket =
        io(SOCKET_URI, OptionBuilder().setTransports(['websocket']).build());
    connectSocket();
  }

  void connectSocket() {
    socket.connect();
    socket.onConnect((data) => logger.i("Connection established $data"));
    socket.onConnectError((data) => logger.e('Connect Error: $data'));
    socket.onDisconnect(
        (data) => logger.i('Socket.IO server disconnected $data'));
    socket.onError((data) => logger.e("Error: $data"));

    socket.on(LISTEN_MESSAGE, (data) {
      logger.i(data);
      SocketData socketData = SocketData.fromJson(data);
      chatList.add(socketData);
      chatList.refresh();
    });

    socket.on(LISTEN_JOIN, (data) {
      logger.i("Joined room $data");

      JoinResponse joinResponse = JoinResponse.fromJson(data);
    });

    socket.on(LISTEN_LEAVE, (data) => logger.i("Left Room $data"));
  }

  void joinRoom({required int id}) {
    SocketData socketRequest = SocketData(
        room: id.toString(), userName: userDetailsManager.username.value);
    socket.emit(JOIN_ROOM, socketRequest.toJson());
  }

  void sendMessage({required int id, required String message}) {
    SocketData socketRequest = SocketData(
        room: id.toString(),
        userName: userDetailsManager.username.value,
        message: message);
    socket.emit(SEND_MESSAGE, socketRequest.toJson());
    return;
  }

  void leaveRoom({required int id}) {
    SocketData socketRequest = SocketData(
        room: id.toString(), userName: userDetailsManager.username.value);
    socket.emit(LEAVE_ROOM, socketRequest.toJson());
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }
}
