package com.db.mobile.mental_health.application.dagger

import android.content.Context
import com.db.mobile.mental_health.application.MentalHealthApplication
import com.db.mobile.mental_health.ui.splash.dagger.LoginComponent
import com.db.mobile.mental_health.ui.splash.dagger.LoginModule
import com.db.mobile.mental_health.ui.news.dagger.NewsFragmentComponent
import com.db.mobile.mental_health.ui.news.dagger.NewsFragmentModule
import com.db.mobile.mental_health.ui.survey.SurveyComponent
import com.db.mobile.mental_health.ui.survey.SurveyModule
import dagger.Component
import javax.inject.Singleton

fun getApplicationComponent(context: Context?): ApplicationComponent? {
    if (context?.applicationContext is MentalHealthApplication) {
        return (context.applicationContext as MentalHealthApplication).applicationComponent
    }
    return null
}

@Singleton
@Component(
    modules = [
        ApplicationModule::class,
        LoginModule::class,
        NewsFragmentModule::class,
        SurveyModule::class
    ]
)
interface ApplicationComponent {
    fun newsFragmentComponent(): NewsFragmentComponent.Factory
    fun loginComponent(): LoginComponent.Factory
    fun surveyComponent(): SurveyComponent.Factory
}
