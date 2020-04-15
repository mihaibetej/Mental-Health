package com.db.mobile.mental_health.data.dagger

import com.db.mobile.mental_health.data.datasource.DailyAdvicesDataSource
import com.db.mobile.mental_health.data.datasource.MessagesDataSource
import com.db.mobile.mental_health.data.datasource.NewsDataSource
import com.db.mobile.mental_health.data.datasource.firebase.DailyAdvicesFirebaseDataSource
import com.db.mobile.mental_health.data.datasource.firebase.MessagesFirebaseDataSource
import com.db.mobile.mental_health.data.datasource.firebase.NewsFirebaseDataSource
import com.google.firebase.firestore.CollectionReference
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import dagger.Binds
import dagger.Module
import dagger.Provides
import javax.inject.Named

@Module(includes = [DataModuleInlineProvider::class])
abstract class DataModule {
    @Binds
    abstract fun provideNewsDataSource(dataSource: NewsFirebaseDataSource): NewsDataSource

    @Binds
    abstract fun provideDailyAdvicesDataSource(dataSource: DailyAdvicesFirebaseDataSource): DailyAdvicesDataSource

    @Binds
    abstract fun provideMessagesDataSource(dataSource: MessagesFirebaseDataSource): MessagesDataSource
}


@Module
object DataModuleInlineProvider {

    @Provides
    fun provideDb() = Firebase.firestore

    @Provides
    @Named("newsTable")
    fun provideNewsTable(): CollectionReference = Firebase.firestore.collection("news")

    @Provides
    @Named("dailyAdvicesTable")
    fun provideDailyAdvicesTable(): CollectionReference = Firebase.firestore.collection("dailyAdvices")

    @Provides
    @Named("messagesTable")
    fun provideMessagesTable(): CollectionReference = Firebase.firestore.collection("messages")
}
