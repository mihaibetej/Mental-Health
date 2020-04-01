package com.db.mobile.mental_health.ui.login

import android.view.View
import androidx.databinding.BaseObservable
import androidx.databinding.Bindable
import com.db.mobile.mental_health.BR
import javax.inject.Inject

class LoginViewModel @Inject constructor() : BaseObservable() {
    var loginError: String? = null
        @Bindable
        get
        @Bindable
        set(value) {
            if (field != value) {
                field = value
                notifyPropertyChanged(BR.loginError)
            }
        }

    var usernameField: String? = null
        @Bindable
        get
        @Bindable
        set(value) {
            if (field != value) {
                field = value
                clearErrorOnTextChanged(field)
                notifyPropertyChanged(BR.usernameField)
            }
        }

    var passwordField: String? = null
        @Bindable
        get
        @Bindable
        set(value) {
            if (field != value) {
                field = value
                clearErrorOnTextChanged(field)
                notifyPropertyChanged(BR.passwordField)
            }
        }

    fun doLogin(view: View) {
        println("login clicked with credentials: $usernameField, $passwordField")
        // Clear fields
        usernameField = null
        passwordField = null
        //Show error
        loginError = "An error occurred"
    }

    private fun clearErrorOnTextChanged(text: String?) {
        if (!text.isNullOrBlank()) {
            loginError = null //Clear error
        }
    }

}