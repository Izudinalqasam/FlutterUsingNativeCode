// Autogenerated from Pigeon (v0.1.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "pigeon.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary* wrapResult(NSDictionary *result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = [NSDictionary dictionaryWithObjectsAndKeys:
        (error.code ? error.code : [NSNull null]), @"code",
        (error.message ? error.message : [NSNull null]), @"message",
        (error.details ? error.details : [NSNull null]), @"details",
        nil];
  }
  return [NSDictionary dictionaryWithObjectsAndKeys:
      (result ? result : [NSNull null]), @"result",
      errorDict, @"error",
      nil];
}

@interface MessageReply ()
+(MessageReply*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MessageRequest ()
+(MessageRequest*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end

@implementation MessageReply
+(MessageReply*)fromMap:(NSDictionary*)dict {
  MessageReply* result = [[MessageReply alloc] init];
  result.query = dict[@"query"];
  if ((NSNull *)result.query == [NSNull null]) {
    result.query = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.query ? self.query : [NSNull null]), @"query", nil];
}
@end

@implementation MessageRequest
+(MessageRequest*)fromMap:(NSDictionary*)dict {
  MessageRequest* result = [[MessageRequest alloc] init];
  result.result = dict[@"result"];
  if ((NSNull *)result.result == [NSNull null]) {
    result.result = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.result ? self.result : [NSNull null]), @"result", nil];
}
@end

void ApiSetup(id<FlutterBinaryMessenger> binaryMessenger, id<Api> api) {
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.Api.sendMessage"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        MessageRequest *input = [MessageRequest fromMap:message];
        MessageReply *output = [api sendMessage:input error:&error];
        callback(wrapResult([output toMap], error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
