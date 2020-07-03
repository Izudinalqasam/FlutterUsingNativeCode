package com.example.method_channle

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Using standart method channel mechanism
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            val parms = call.arguments as Map<String, Any>

            if (call.method == "myNativeFunction") {
                val messageToFlutter = myNativeFunction()
                val fromParams = parms["from"].toString()
                result.success("$messageToFlutter, Back to $fromParams")
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Using pigeon method channel
        Pigeon.Api.setup(flutterEngine?.dartExecutor?.binaryMessenger, MyApi())
    }

    private fun myNativeFunction() =  "Message from android"

    companion object {
        const val CHANNEL = "MyChannel"
    }

    class MyApi: Pigeon.Api {
        override fun sendMessage(arg: Pigeon.MessageRequest?): Pigeon.MessageReply {
            val reply = Pigeon.MessageReply()
            reply.query = "Hi from native nih ${arg?.result}"
            return reply
        }
    }
}
