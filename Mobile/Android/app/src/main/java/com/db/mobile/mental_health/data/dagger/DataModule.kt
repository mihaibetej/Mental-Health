package com.db.mobile.mental_health.data.dagger

import com.db.mobile.mental_health.data.datasource.NewsDataSource
import com.db.mobile.mental_health.data.datasource.SurveyDataSource
import com.db.mobile.mental_health.data.datasource.firebase.NewsFirebaseDataSource
import com.db.mobile.mental_health.data.datasource.firebase.SurveyFirebaseDataSource
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

}
