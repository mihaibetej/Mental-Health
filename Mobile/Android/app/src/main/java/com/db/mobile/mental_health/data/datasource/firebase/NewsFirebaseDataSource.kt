package com.db.mobile.mental_health.data.datasource.firebase

import com.db.mobile.mental_health.data.DataSourceResult
import com.db.mobile.mental_health.data.Failure
import com.db.mobile.mental_health.data.Success
import com.db.mobile.mental_health.data.datasource.NewsDataSource
import com.db.mobile.mental_health.data.datasource.NoNewsException
import com.db.mobile.mental_health.data.model.News
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import javax.inject.Inject
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

class NewsFirebaseDataSource @Inject constructor() : NewsDataSource {
    val db = Firebase.firestore.collection("news")

    override suspend fun getNews(): DataSourceResult<List<News>, NoNewsException> =
        suspendCoroutine { cont ->
            db.get()
                .addOnSuccessListener { it ->
                    cont.resume(Success(it.toObjects(News::class.java)))
                }
                .addOnFailureListener {
                    cont.resume(Failure(NoNewsException()))
                }
        }

}
