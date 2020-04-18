package com.db.mobile.mental_health.data.dagger

import com.db.mobile.mental_health.data.datasource.NewsDataSource
import com.db.mobile.mental_health.data.datasource.SurveyDataSource
import com.db.mobile.mental_health.data.datasource.UserInfoDataSource
import dagger.Component

@Component(modules = [DataModule::class])
interface DataComponent {
    fun provideNewsDataSource(): NewsDataSource
    fun provideSurveyDataSource(): SurveyDataSource
    fun provideUserInfoDataSource(): UserInfoDataSource
}
