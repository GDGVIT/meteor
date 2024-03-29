# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
import grpc

import proto.meteor_pb2 as meteor__pb2


class MessageSenderStub(object):
  # missing associated documentation comment in .proto file
  pass

  def __init__(self, channel):
    """Constructor.

    Args:
      channel: A grpc.Channel.
    """
    self.CreateProfile = channel.unary_unary(
        '/MessageSender/CreateProfile',
        request_serializer=meteor__pb2.CreateProfileRequest.SerializeToString,
        response_deserializer=meteor__pb2.CreateProfileResponse.FromString,
        )
    self.AddFriend = channel.unary_unary(
        '/MessageSender/AddFriend',
        request_serializer=meteor__pb2.FriendRequest.SerializeToString,
        response_deserializer=meteor__pb2.FriendResponse.FromString,
        )
    self.SendMessage = channel.unary_unary(
        '/MessageSender/SendMessage',
        request_serializer=meteor__pb2.SendMessageRequest.SerializeToString,
        response_deserializer=meteor__pb2.SendMessageResponse.FromString,
        )


class MessageSenderServicer(object):
  # missing associated documentation comment in .proto file
  pass

  def CreateProfile(self, request, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')

  def AddFriend(self, request, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')

  def SendMessage(self, request, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')


def add_MessageSenderServicer_to_server(servicer, server):
  rpc_method_handlers = {
      'CreateProfile': grpc.unary_unary_rpc_method_handler(
          servicer.CreateProfile,
          request_deserializer=meteor__pb2.CreateProfileRequest.FromString,
          response_serializer=meteor__pb2.CreateProfileResponse.SerializeToString,
      ),
      'AddFriend': grpc.unary_unary_rpc_method_handler(
          servicer.AddFriend,
          request_deserializer=meteor__pb2.FriendRequest.FromString,
          response_serializer=meteor__pb2.FriendResponse.SerializeToString,
      ),
      'SendMessage': grpc.unary_unary_rpc_method_handler(
          servicer.SendMessage,
          request_deserializer=meteor__pb2.SendMessageRequest.FromString,
          response_serializer=meteor__pb2.SendMessageResponse.SerializeToString,
      ),
  }
  generic_handler = grpc.method_handlers_generic_handler(
      'MessageSender', rpc_method_handlers)
  server.add_generic_rpc_handlers((generic_handler,))
