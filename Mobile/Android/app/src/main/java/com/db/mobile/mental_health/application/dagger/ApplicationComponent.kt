package com.db.mobile.mental_health.application.dagger

import android.content.Context
import com.db.mobile.mental_health.application.MentalHealthApplication
import com.db.mobile.mental_health.ui.login.dagger.LoginComponent
import com.db.mobile.mental_health.ui.login.dagger.LoginModule
import com.db.mobile.mental_health.ui.news.dagger.NewsFragmentComponent
import com.db.mobile.mental_health.ui.news.dagger.NewsFragmentModule
import dagger.Component
import javax.inject.Singleton

fun getApplicationComponent(context: Context): ApplicationComponent? {
    if (context.applicationContext is MentalHealthApplication) {
        return (context.applicationContext as MentalHealthApplication).applicationComponent
    }
    return null
}

@Singleton
@Component (
    modules = [
        ApplicationModule::class,
        LoginModule::class,
        NewsFragmentModule::class
    ]
)
interface ApplicationComponent {
    fun newsFragmentComponent() : NewsFragmentComponent.Factory
    fun loginComponent() : LoginComponent.Factory
}