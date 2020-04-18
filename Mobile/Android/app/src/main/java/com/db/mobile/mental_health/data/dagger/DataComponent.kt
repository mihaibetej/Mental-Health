package com.db.mobile.mental_health.data.dagger

import com.db.mobile.mental_health.data.datasource.*
import dagger.Component

@Component(modules = [DataModule::class])
interface DataComponent {
    fun provideNewsDataSource(): NewsDataSource
    fun provideDailyAdvicesDataSource(): DailyAdvicesDataSource
    fun provideMessagesDataSource(): MessagesDataSource
    fun provideSurveyDataSource(): SurveyDataSource
    fun provideUserInfoDataSource(): UserInfoDataSource
}
