package com.db.mobile.mental_health.ui.survey.result

import dagger.Module
import dagger.Subcomponent

@Subcomponent
interface SurveyResultComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): SurveyResultComponent
    }

    fun inject(fragment: SurveyResultFragment)

}

@Module(subcomponents = [SurveyResultComponent::class])
abstract class SurveyResultModule
