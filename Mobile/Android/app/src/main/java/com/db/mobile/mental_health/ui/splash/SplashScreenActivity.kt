package com.db.mobile.mental_health.ui.splash

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import com.db.mobile.mental_health.createIntent
import com.db.mobile.mental_health.ui.splash.dagger.LoginComponent
import javax.inject.Inject

private const val RC_SIGN_IN = 123

class SplashScreenActivity : AppCompatActivity() {
    private var loginComponent: LoginComponent? = null

    @Inject
    lateinit var viewModel: SplashScreenViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        loginComponent = getApplicationComponent(this)?.loginComponent()?.create()
        loginComponent?.inject(this)

        setContentView(R.layout.activity_splash)

        viewModel.sessionStatus.observe(this, Observer {
            when (it) {
                UserStatus.SIGNED_IN -> startMainActivity()
                UserStatus.SIGNED_OUT -> doSignIn(viewModel.signInIntent())
                UserStatus.SIGN_IN_ERROR -> TODO("no err handling")
                else -> TODO("no err handling")
            }
        })

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == RC_SIGN_IN) {
            viewModel.onIntentResult(resultCode, data)
        }
    }

    private fun startMainActivity() {
        startActivity(createIntent(this))
        finish()
    }

    private fun doSignIn(signInIntent: Intent) {
        startActivityForResult(signInIntent, RC_SIGN_IN)
    }

}
