package com.db.mobile.mental_health.ui.splash

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.provider.AlarmClock
import androidx.appcompat.app.AppCompatActivity
import com.db.mobile.mental_health.MainActivity
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import com.db.mobile.mental_health.ui.splash.dagger.LoginComponent
import com.firebase.ui.auth.AuthUI
import com.firebase.ui.auth.IdpResponse
import com.google.firebase.auth.FirebaseAuth
import javax.inject.Inject

private const val RC_SIGN_IN = 123

class SplashScreenActivity : AppCompatActivity() {
    private var loginComponent: LoginComponent? = null

    // Choose authentication providers
    @Inject
    lateinit var providers: List<AuthUI.IdpConfig>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        loginComponent = getApplicationComponent(this)?.loginComponent()?.create()
        loginComponent?.inject(this)

        setContentView(R.layout.activity_splash)

        startActivityForResult(
            AuthUI.getInstance()
                .createSignInIntentBuilder()
                .setAvailableProviders(providers)
                .build(),
            RC_SIGN_IN
        )
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == RC_SIGN_IN) {
            val response = IdpResponse.fromResultIntent(data)

            if (resultCode == Activity.RESULT_OK) {
                // Successfully signed in
                val user = FirebaseAuth.getInstance().currentUser
                val intent = Intent(this, MainActivity::class.java).apply {
                    if (user != null) {
                        putExtra(AlarmClock.EXTRA_MESSAGE, user.displayName)
                    }
                }
                startActivity(intent)
            } else {
                // Sign in failed. If response is null the user canceled the
                // sign-in flow using the back button. Otherwise check
                // response.getError().getErrorCode() and handle the error.
                // ...
            }
        }
    }

}
