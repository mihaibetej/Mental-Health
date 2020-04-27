package com.db.mobile.mental_health.application.dagger

import android.content.Context
import com.db.mobile.mental_health.application.MentalHealthApplication
import com.db.mobile.mental_health.domain.dagger.DomainComponent
import com.db.mobile.mental_health.ui.for_you.ForYouFragmentComponent
import com.db.mobile.mental_health.ui.for_you.ForYouFragmentModule
import com.db.mobile.mental_health.ui.for_you.advices.AdvicesFragmentComponent
import com.db.mobile.mental_health.ui.for_you.advices.AdvicesFragmentModule
import com.db.mobile.mental_health.ui.for_you.messages.MessagesFragmentComponent
import com.db.mobile.mental_health.ui.for_you.messages.MessagesFragmentModule
import com.db.mobile.mental_health.ui.news.dagger.NewsFragmentComponent
import com.db.mobile.mental_health.ui.news.dagger.NewsFragmentModule
import com.db.mobile.mental_health.ui.splash.dagger.LoginComponent
import com.db.mobile.mental_health.ui.splash.dagger.LoginModule
import com.db.mobile.mental_health.ui.survey.SurveyComponent
import com.db.mobile.mental_health.ui.survey.SurveyModule
import com.db.mobile.mental_health.ui.survey.result.SurveyResultComponent
import com.db.mobile.mental_health.ui.survey.result.SurveyResultModule
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
        SurveyResultModule::class,
        ForYouFragmentModule::class,
        AdvicesFragmentModule::class,
        MessagesFragmentModule::class
    ]
)
interface ApplicationComponent {
    fun newsFragmentComponent(): NewsFragmentComponent.Factory
    fun loginComponent(): LoginComponent.Factory
    fun surveyComponent(): SurveyComponent.Factory
    fun surveyResultComponent(): SurveyResultComponent.Factory
    fun forYouFragmentComponent(): ForYouFragmentComponent.Factory
    fun advicesFragmentComponent(): AdvicesFragmentComponent.Factory
    fun messagesFragmentComponent(): MessagesFragmentComponent.Factory
}
