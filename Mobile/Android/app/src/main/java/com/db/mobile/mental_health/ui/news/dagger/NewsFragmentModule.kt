package com.db.mobile.mental_health.ui.news.dagger

import com.db.mobile.mental_health.data.datasource.NewsDataSource
import com.db.mobile.mental_health.data.datasource.firebase.NewsFirebaseDataSource
import dagger.Binds
import dagger.Module

@Module(
    subcomponents = [
        NewsFragmentComponent::class
    ]
)
abstract class NewsFragmentModule {
    @Binds
    abstract fun provideNewsDataSource(dataSource: NewsFirebaseDataSource): NewsDataSource
}
