package com.xiprofit.ximena_hoyos_app

import android.content.Context
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Base64
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        printHashKey(this@MainActivity)
    }

    private fun printHashKey(pContext: Context) {
        try {
            val info = pContext.packageManager.getPackageInfo(pContext.packageName, PackageManager.GET_SIGNATURES)

            for (signature in info.signatures) {
                val md: MessageDigest = MessageDigest.getInstance("SHA")
                md.update(signature.toByteArray())
                Log.d("KeyHash:", Base64.encodeToString(md.digest(), Base64.DEFAULT))
            }

        } catch (e: NoSuchAlgorithmException) {
            Log.e("MainActivity", "printHashKey()", e)
        } catch (e: Exception) {
            Log.e("MainActivity", "printHashKey()", e)
        }
    }

}
