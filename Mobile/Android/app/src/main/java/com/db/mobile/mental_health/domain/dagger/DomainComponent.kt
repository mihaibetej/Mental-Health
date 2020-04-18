package com.db.mobile.mental_health.domain.dagger

import com.db.mobile.mental_health.data.dagger.DataComponent
import com.db.mobile.mental_health.domain.usecases.GetNewsUseCase
import com.db.mobile.mental_health.domain.usecases.GetSurveyQuestionsUseCase
import com.db.mobile.mental_health.domain.usecases.UpdateUserInfoFromFirebase
import dagger.Component

@Component(dependencies = [DataComponent::class], modules = [DomainModule::class])
interface DomainComponent {
    fun provideGetNewsUseCase(): GetNewsUseCase
    fun provideSurveyStatusUseCase(): GetSurveyQuestionsUseCase
    fun provideSignUpUserInfoUpdate(): UpdateUserInfoFromFirebase
}
