package com.db.mobile.mental_health.ui.login

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import com.db.mobile.mental_health.databinding.ActivityLoginBinding
import com.db.mobile.mental_health.ui.login.dagger.LoginComponent
import javax.inject.Inject

class LoginActivity : AppCompatActivity() {
    private var loginComponent: LoginComponent? = null

    @Inject
    lateinit var viewModel: LoginViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        loginComponent = getApplicationComponent(this)?.loginComponent()?.create()
        loginComponent?.inject(this)
        val dataBinding: ActivityLoginBinding = DataBindingUtil.setContentView(
            this,
            R.layout.activity_login
        )
        dataBinding.viewModel = viewModel
    }

}