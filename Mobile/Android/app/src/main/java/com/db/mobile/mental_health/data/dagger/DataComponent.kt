package com.db.mobile.mental_health.data.dagger

import com.db.mobile.mental_health.data.datasource.NewsDataSource
import com.db.mobile.mental_health.data.datasource.SurveyDataSource
import dagger.Component

@Component(modules = [DataModule::class])
interface DataComponent {
    fun provideNewsDataSource(): NewsDataSource // exposes the data source to the dependent components
    fun provideSurveyDataSource(): SurveyDataSource // exposes the data source to the dependent components
}
