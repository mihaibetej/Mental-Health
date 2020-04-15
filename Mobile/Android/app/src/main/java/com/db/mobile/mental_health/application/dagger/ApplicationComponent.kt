package com.db.mobile.mental_health.application.dagger

import android.content.Context
import com.db.mobile.mental_health.application.MentalHealthApplication
import com.db.mobile.mental_health.domain.dagger.DomainComponent
import com.db.mobile.mental_health.ui.for_you.ForYouComponent
import com.db.mobile.mental_health.ui.for_you.ForYouModule
import com.db.mobile.mental_health.ui.for_you.advices.AdvicesComponent
import com.db.mobile.mental_health.ui.for_you.advices.AdvicesModule
import com.db.mobile.mental_health.ui.for_you.messages.MessagesComponent
import com.db.mobile.mental_health.ui.for_you.messages.MessagesModule
import com.db.mobile.mental_health.ui.news.dagger.NewsFragmentComponent
import com.db.mobile.mental_health.ui.news.dagger.NewsFragmentModule
import com.db.mobile.mental_health.ui.splash.dagger.LoginComponent
import com.db.mobile.mental_health.ui.splash.dagger.LoginModule
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
    dependencies = [
        DomainComponent::class
    ],
    modules = [
        ApplicationModule::class,
        LoginModule::class,
        NewsFragmentModule::class,
        SurveyModule::class,
        ForYouModule::class,
        AdvicesModule::class,
        MessagesModule::class
    ]
)
interface ApplicationComponent {
    fun newsFragmentComponent(): NewsFragmentComponent.Factory
    fun loginComponent(): LoginComponent.Factory
    fun surveyComponent(): SurveyComponent.Factory
    fun forYouComponent(): ForYouComponent.Factory
    fun advicesComponent(): AdvicesComponent.Factory
    fun messagesComponent(): MessagesComponent.Factory
}
