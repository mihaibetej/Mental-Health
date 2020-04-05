package com.db.mobile.mental_health.ui.splash.dagger

import com.db.mobile.mental_health.ui.splash.SplashScreenActivity
import dagger.Subcomponent

@Subcomponent
interface LoginComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): LoginComponent
    }

    fun inject(splashScreenActivity: SplashScreenActivity)
}
