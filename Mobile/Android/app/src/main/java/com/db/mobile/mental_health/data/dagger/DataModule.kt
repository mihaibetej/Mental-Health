package com.db.mobile.mental_health.data.dagger

import com.db.mobile.mental_health.data.datasource.*
import com.db.mobile.mental_health.data.datasource.firebase.*
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
    abstract fun provideSurveyQuestionsDataSource(dataSource: SurveyFirebaseDataSource): SurveyDataSource

    @Binds
    abstract fun provideUserInfoDataSource(dataSource: UserFirebaseDataSource): UserInfoDataSource

    @Binds
    abstract fun provideDailyAdvicesDataSource(dataSource: DailyAdvicesFirebaseDataSource): DailyAdvicesDataSource

    @Binds
    abstract fun provideMessagesDataSource(dataSource: MessagesFirebaseDataSource): MessagesDataSource

}


@Module
class DataModuleInlineProvider {

    @Provides
    fun provideDb() = Firebase.firestore

    @Provides
    @Named("newsTable")
    fun provideNewsTable(): CollectionReference = Firebase.firestore.collection("news")

    @Provides
    @Named("surveyTable")
    fun provideSurveyTable(): CollectionReference = Firebase.firestore.collection("questions")

    @Provides
    @Named("usersTable")
    fun provideUsersTable(): CollectionReference = Firebase.firestore.collection("users")

    @Provides
    @Named("dailyAdvicesTable")
    fun provideDailyAdvicesTable(): CollectionReference =
        Firebase.firestore.collection("daily-advices")

    @Provides
    @Named("messagesTable")
    fun provideMessagesTable(): CollectionReference = Firebase.firestore.collection("messages")

}
