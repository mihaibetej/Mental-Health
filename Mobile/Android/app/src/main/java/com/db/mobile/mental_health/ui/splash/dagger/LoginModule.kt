package com.db.mobile.mental_health.ui.splash.dagger

import com.firebase.ui.auth.AuthUI
import dagger.Module
import dagger.Provides

@Module(
    subcomponents = [
        LoginComponent::class
    ]
)
object LoginModule {

    @JvmStatic
    @Provides
    fun provideLoginMethods(): List<AuthUI.IdpConfig> = listOf(
        AuthUI.IdpConfig.EmailBuilder().build()
    )

}
