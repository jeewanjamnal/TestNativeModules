package com.batterymodule

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext

class BatteryModule(reactContext: ReactApplicationContext) :
    NativeBatteryModuleSpec(reactContext) {

    override fun getName() = NAME

    override fun getBatteryLevel(promise: Promise) {
        try {
            val batteryStatus: Intent? = reactApplicationContext.registerReceiver(
                null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            val level = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
            val scale = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1

            if (level == -1 || scale == -1) {
                promise.reject("BATTERY_ERROR", "Unable to read battery level")
                return
            }

            val batteryPct = (level / scale.toFloat()) * 100
            promise.resolve(batteryPct.toDouble())
        } catch (e: Exception) {
            promise.reject("BATTERY_ERROR", e.message, e)
        }
    }

    companion object {
        const val NAME = "BatteryModule"
    }
}