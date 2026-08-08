import Foundation
import UIKit

@objcMembers
public class BatteryModule: NSObject {

    public override init() {
        super.init()

        UIDevice.current.isBatteryMonitoringEnabled = true
    }

    public func getBatteryLevel() -> Double {
        let level = UIDevice.current.batteryLevel

        if level < 0 {
            return -1
        }

        return Double(level * 100)
    }
}
