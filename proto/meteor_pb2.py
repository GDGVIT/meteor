# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: meteor.proto

import sys
_b=sys.version_info[0]<3 and (lambda x:x) or (lambda x:x.encode('latin1'))
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor.FileDescriptor(
  name='meteor.proto',
  package='',
  syntax='proto3',
  serialized_options=None,
  serialized_pb=_b('\n\x0cmeteor.proto\"\x1f\n\rFriendRequest\x12\x0e\n\x06HostId\x18\x01 \x01(\t\"7\n\x0e\x46riendResponse\x12\x0f\n\x07isValid\x18\x01 \x01(\x08\x12\x14\n\x0c\x66riendHostId\x18\x02 \x01(\t\"&\n\x14\x43reateProfileRequest\x12\x0e\n\x06userId\x18\x01 \x01(\x03\"(\n\x15\x43reateProfileResponse\x12\x0f\n\x07isValid\x18\x01 \x01(\x08\"L\n\x12SendMessageRequest\x12\x0c\n\x04text\x18\x01 \x01(\t\x12\x14\n\x0ctargetHostId\x18\x02 \x01(\t\x12\x12\n\nfromHostId\x18\x03 \x01(\t\"\'\n\x13SendMessageResponse\x12\x10\n\x08response\x18\x01 \x01(\t2\xbd\x01\n\rMessageSender\x12@\n\rCreateProfile\x12\x15.CreateProfileRequest\x1a\x16.CreateProfileResponse\"\x00\x12.\n\tAddFriend\x12\x0e.FriendRequest\x1a\x0f.FriendResponse\"\x00\x12:\n\x0bSendMessage\x12\x13.SendMessageRequest\x1a\x14.SendMessageResponse\"\x00\x62\x06proto3')
)




_FRIENDREQUEST = _descriptor.Descriptor(
  name='FriendRequest',
  full_name='FriendRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='HostId', full_name='FriendRequest.HostId', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=16,
  serialized_end=47,
)


_FRIENDRESPONSE = _descriptor.Descriptor(
  name='FriendResponse',
  full_name='FriendResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='isValid', full_name='FriendResponse.isValid', index=0,
      number=1, type=8, cpp_type=7, label=1,
      has_default_value=False, default_value=False,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR),
    _descriptor.FieldDescriptor(
      name='friendHostId', full_name='FriendResponse.friendHostId', index=1,
      number=2, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=49,
  serialized_end=104,
)


_CREATEPROFILEREQUEST = _descriptor.Descriptor(
  name='CreateProfileRequest',
  full_name='CreateProfileRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='userId', full_name='CreateProfileRequest.userId', index=0,
      number=1, type=3, cpp_type=2, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=106,
  serialized_end=144,
)


_CREATEPROFILERESPONSE = _descriptor.Descriptor(
  name='CreateProfileResponse',
  full_name='CreateProfileResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='isValid', full_name='CreateProfileResponse.isValid', index=0,
      number=1, type=8, cpp_type=7, label=1,
      has_default_value=False, default_value=False,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=146,
  serialized_end=186,
)


_SENDMESSAGEREQUEST = _descriptor.Descriptor(
  name='SendMessageRequest',
  full_name='SendMessageRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='text', full_name='SendMessageRequest.text', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR),
    _descriptor.FieldDescriptor(
      name='targetHostId', full_name='SendMessageRequest.targetHostId', index=1,
      number=2, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR),
    _descriptor.FieldDescriptor(
      name='fromHostId', full_name='SendMessageRequest.fromHostId', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=188,
  serialized_end=264,
)


_SENDMESSAGERESPONSE = _descriptor.Descriptor(
  name='SendMessageResponse',
  full_name='SendMessageResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='response', full_name='SendMessageResponse.response', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=266,
  serialized_end=305,
)

DESCRIPTOR.message_types_by_name['FriendRequest'] = _FRIENDREQUEST
DESCRIPTOR.message_types_by_name['FriendResponse'] = _FRIENDRESPONSE
DESCRIPTOR.message_types_by_name['CreateProfileRequest'] = _CREATEPROFILEREQUEST
DESCRIPTOR.message_types_by_name['CreateProfileResponse'] = _CREATEPROFILERESPONSE
DESCRIPTOR.message_types_by_name['SendMessageRequest'] = _SENDMESSAGEREQUEST
DESCRIPTOR.message_types_by_name['SendMessageResponse'] = _SENDMESSAGERESPONSE
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

FriendRequest = _reflection.GeneratedProtocolMessageType('FriendRequest', (_message.Message,), {
  'DESCRIPTOR' : _FRIENDREQUEST,
  '__module__' : 'meteor_pb2'
  # @@protoc_insertion_point(class_scope:FriendRequest)
  })
_sym_db.RegisterMessage(FriendRequest)

FriendResponse = _reflection.GeneratedProtocolMessageType('FriendResponse', (_message.Message,), {
  'DESCRIPTOR' : _FRIENDRESPONSE,
  '__module__' : 'meteor_pb2'
  # @@protoc_insertion_point(class_scope:FriendResponse)
  })
_sym_db.RegisterMessage(FriendResponse)

CreateProfileRequest = _reflection.GeneratedProtocolMessageType('CreateProfileRequest', (_message.Message,), {
  'DESCRIPTOR' : _CREATEPROFILEREQUEST,
  '__module__' : 'meteor_pb2'
  # @@protoc_insertion_point(class_scope:CreateProfileRequest)
  })
_sym_db.RegisterMessage(CreateProfileRequest)

CreateProfileResponse = _reflection.GeneratedProtocolMessageType('CreateProfileResponse', (_message.Message,), {
  'DESCRIPTOR' : _CREATEPROFILERESPONSE,
  '__module__' : 'meteor_pb2'
  # @@protoc_insertion_point(class_scope:CreateProfileResponse)
  })
_sym_db.RegisterMessage(CreateProfileResponse)

SendMessageRequest = _reflection.GeneratedProtocolMessageType('SendMessageRequest', (_message.Message,), {
  'DESCRIPTOR' : _SENDMESSAGEREQUEST,
  '__module__' : 'meteor_pb2'
  # @@protoc_insertion_point(class_scope:SendMessageRequest)
  })
_sym_db.RegisterMessage(SendMessageRequest)

SendMessageResponse = _reflection.GeneratedProtocolMessageType('SendMessageResponse', (_message.Message,), {
  'DESCRIPTOR' : _SENDMESSAGERESPONSE,
  '__module__' : 'meteor_pb2'
  # @@protoc_insertion_point(class_scope:SendMessageResponse)
  })
_sym_db.RegisterMessage(SendMessageResponse)



_MESSAGESENDER = _descriptor.ServiceDescriptor(
  name='MessageSender',
  full_name='MessageSender',
  file=DESCRIPTOR,
  index=0,
  serialized_options=None,
  serialized_start=308,
  serialized_end=497,
  methods=[
  _descriptor.MethodDescriptor(
    name='CreateProfile',
    full_name='MessageSender.CreateProfile',
    index=0,
    containing_service=None,
    input_type=_CREATEPROFILEREQUEST,
    output_type=_CREATEPROFILERESPONSE,
    serialized_options=None,
  ),
  _descriptor.MethodDescriptor(
    name='AddFriend',
    full_name='MessageSender.AddFriend',
    index=1,
    containing_service=None,
    input_type=_FRIENDREQUEST,
    output_type=_FRIENDRESPONSE,
    serialized_options=None,
  ),
  _descriptor.MethodDescriptor(
    name='SendMessage',
    full_name='MessageSender.SendMessage',
    index=2,
    containing_service=None,
    input_type=_SENDMESSAGEREQUEST,
    output_type=_SENDMESSAGERESPONSE,
    serialized_options=None,
  ),
])
_sym_db.RegisterServiceDescriptor(_MESSAGESENDER)

DESCRIPTOR.services_by_name['MessageSender'] = _MESSAGESENDER

# @@protoc_insertion_point(module_scope)
