package com.db.mobile.mental_health.data.dagger

import com.db.mobile.mental_health.data.datasource.*
import com.db.mobile.mental_health.data.datasource.firebase.*
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.CollectionReference
import com.google.firebase.firestore.FirebaseFirestore
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
    fun provideDb(): FirebaseFirestore = Firebase.firestore

    @Provides
    @Named("user_id")
    fun provideUserId(): String = FirebaseAuth.getInstance().currentUser?.uid!!

    @Provides
    @Named("newsTable")
    fun provideNewsTable(store: FirebaseFirestore): CollectionReference = store.collection("news")

    @Provides
    @Named("surveyTable")
    fun provideSurveyTable(store: FirebaseFirestore): CollectionReference =
        store.collection("questions")

    @Provides
    @Named("usersTable")
    fun provideUsersTable(store: FirebaseFirestore): CollectionReference = store.collection("users")

    @Provides
    @Named("dailyAdvicesTable")
    fun provideDailyAdvicesTable(store: FirebaseFirestore): CollectionReference =
        store.collection("daily-advices")

    @Provides
    @Named("messagesTable")
    fun provideMessagesTable(store: FirebaseFirestore): CollectionReference =
        store.collection("messages")

    @Provides
    @Named("answersTable")
    fun provideAnswersTable(
        @Named("usersTable") usersTable: CollectionReference,
        @Named("user_id") userId: String
    ): CollectionReference = usersTable.document(userId).collection("answers")

}
