package com.db.mobile.mental_health.ui.survey

import dagger.Module
import dagger.Subcomponent

@Subcomponent
interface SurveyComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): SurveyComponent
    }

    fun inject(surveyFragment: SurveyFragment)
}

@Module(subcomponents = [SurveyComponent::class])
abstract class SurveyModule
