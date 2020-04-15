package com.db.mobile.mental_health.data.dagger

import com.db.mobile.mental_health.data.datasource.DailyAdvicesDataSource
import com.db.mobile.mental_health.data.datasource.MessagesDataSource
import com.db.mobile.mental_health.data.datasource.NewsDataSource
import dagger.Component

@Component(modules = [DataModule::class])
interface DataComponent {
    fun provideNewsDataSource() : NewsDataSource // exposes the data source to the dependent components
    fun provideDailyAdvicesDataSource() : DailyAdvicesDataSource
    fun provideMessagesDataSource() : MessagesDataSource
}
