package com.db.mobile.mental_health.ui.login.dagger

import com.db.mobile.mental_health.ui.login.LoginActivity
import dagger.Subcomponent

@Subcomponent
interface LoginComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): LoginComponent
    }

    fun inject(loginActivity: LoginActivity)
}