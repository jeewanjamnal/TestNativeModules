#import "RCTBatteryModule.h"
#import "TestNativeModules-Swift.h"

@implementation RCTBatteryModule {
  BatteryModule *_batteryModule;
}

- (instancetype)init
{
  self = [super init];

  if (self) {
    _batteryModule = [BatteryModule new];
  }

  return self;
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeBatteryModuleSpecJSI>(params);
}

- (void)getBatteryLevel:
    (RCTPromiseResolveBlock)resolve
    reject:(RCTPromiseRejectBlock)reject
{
  double batteryLevel = [_batteryModule getBatteryLevel];

  if (batteryLevel < 0) {
    reject(
      @"BATTERY_UNAVAILABLE",
      @"Unable to determine the battery level.",
      nil
    );
    return;
  }

  resolve(@(batteryLevel));
}

+ (NSString *)moduleName
{
  return @"BatteryModule";
}

@end
