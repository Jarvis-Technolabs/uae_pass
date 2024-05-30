package com.uaepass.uaepass

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.*
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context
import io.flutter.plugin.common.PluginRegistry
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry.Registrar

/** UaepassPlugin */
class UaepassPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.NewIntentListener{
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private var activity: Activity? = null

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    if(activity==null)
    activity = binding.getActivity()
    binding.addOnNewIntentListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "uaepass")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
     if(call.method == OPEN_UAE_PASS_APP){
      UaepassPlugin.result = result
      launchApp(call)
    }else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  companion object {
    lateinit var result: MethodChannel.Result
    private const val OPEN_UAE_PASS_APP = "openUaePassApp"
    private const val KEY_URL = "url"
    const val KEY_LOAD_SUCCESS_URL = "loadSuccessUrl"
    const val KEY_BROWSER_PACKAGE = "browserpackage"
    const val KEY_SUCCESS_URL = "successurl"

  }

  private var successUrl = ""

  private fun isAppEnabled(call: MethodCall) {
    var appStatus = false
    try {
      val uriSchema = call.argument<Any>(KEY_URL).toString()
      val ai = activity!!.packageManager.getApplicationInfo(uriSchema, 0)
      appStatus = ai.enabled
    } catch (e: PackageManager.NameNotFoundException) {
    }
    result.success(appStatus)
  }

  private fun launchApp(call: MethodCall) {
    try {
      var uriSchema = call.argument<Any>(KEY_URL).toString()
      uriSchema = replaceUriParameter(Uri.parse(uriSchema), KEY_BROWSER_PACKAGE, activity!!.packageName).toString()
      successUrl = getUriParameter(Uri.parse(uriSchema), KEY_SUCCESS_URL)
      val launchIntent = Intent("android.intent.action.VIEW", Uri.parse(uriSchema))
      launchIntent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
      if (launchIntent.resolveActivity(activity!!.packageManager) != null) {
        activity!!.startActivity(launchIntent)
      }
    } catch (e: PackageManager.NameNotFoundException) {
      result.success("")
    }
  }
  override  fun onNewIntent(intent: Intent): Boolean {
    handleIntent(intent)
    return false
  }
  private fun handleIntent(intent: Intent?) {
    if (intent != null && intent.data != null) {
      if (intent.dataString == successUrl) {
        result.success(KEY_LOAD_SUCCESS_URL)
      }
    }
  }

  fun checkSuccess(dataString: String) {
    if (dataString == successUrl) {
      result.success(KEY_LOAD_SUCCESS_URL)
    }
  }

  private fun replaceUriParameter(uri: Uri, key: String, newValue: String): Uri? {
    val params = uri.queryParameterNames
    val newUri = uri.buildUpon().clearQuery()
    for (param in params) {
      newUri.appendQueryParameter(param,
        if (param == key) newValue else uri.getQueryParameter(param))
    }
    return newUri.build()
  }

  private fun getUriParameter(uri: Uri, key: String): String {
    var value = ""
    val params = uri.queryParameterNames
    for (param in params) {
      if (param == key) {
        value = uri.getQueryParameter(param)!!
        break;
      }
    }
    return value
  }
}
