import grpc
import proto.meteor_pb2 as pb2
import proto.meteor_pb2_grpc as pb2_grpc

class MeteorNodeInterface:
    def __init__(self, port):
        self.channel = grpc.insecure_channel("localhost:" + str(port))
        self.stub = pb2_grpc.MessageSenderStub(self.channel)
    
    def CreateProfile(self, userId):
        return self.stub.CreateProfile(pb2.CreateProfileRequest(userId=userId)).isValid
    
    def AddFriend(self, hostId):
        return self.stub.AddFriend(pb2.FriendRequest(HostId=hostId)).isValid
    
    def SendMessage(self, myId, hostId, message):
        return self.stub.SendMessage(pb2.SendMessageRequest(text=message, 
                fromHostId=myId, targetHostId=hostId))
    
    def close(self):
        self.channel.close()
