package com.db.mobile.mental_health.ui.splash

import android.app.Activity
import android.content.Intent
import androidx.lifecycle.MutableLiveData
import com.firebase.ui.auth.AuthUI
import com.firebase.ui.auth.IdpResponse
import com.google.firebase.auth.FirebaseAuth
import javax.inject.Inject

class SplashScreenViewModel @Inject constructor(private var providers: List<AuthUI.IdpConfig>) {
    val sessionStatus = MutableLiveData<UserStatus>()

    init {
        sessionStatus.value = if (FirebaseAuth.getInstance().currentUser != null) {
            UserStatus.SIGNED_IN
        } else {
            UserStatus.SIGNED_OUT
        }
    }

    fun signInIntent(): Intent = AuthUI.getInstance()
        .createSignInIntentBuilder()
        .setAvailableProviders(providers)
        .build()

    fun onIntentResult(activityResult: Int, data: Intent?) {
        val response = IdpResponse.fromResultIntent(data)

        sessionStatus.value = if (activityResult == Activity.RESULT_OK) {
            UserStatus.SIGNED_IN
        } else {
            UserStatus.SIGN_IN_ERROR
        }
    }

}

enum class UserStatus {
    SIGNED_IN, SIGNED_OUT, SIGN_IN_ERROR
}
