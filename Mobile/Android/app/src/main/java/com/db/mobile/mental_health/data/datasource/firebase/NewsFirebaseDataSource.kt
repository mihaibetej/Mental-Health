package com.db.mobile.mental_health.data.datasource.firebase

import com.db.mobile.mental_health.data.datasource.NewsDataSource
import com.db.mobile.mental_health.data.model.News
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import javax.inject.Inject
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine

class NewsFirebaseDataSource @Inject constructor(): NewsDataSource {
    val db = Firebase.firestore.collection("news")

    override suspend fun getNews(): List<News>? = suspendCoroutine { cont ->
        db.get()
            .addOnSuccessListener { it ->
                cont.resume(it.toObjects(News::class.java))
            }
            .addOnFailureListener {
                cont.resumeWithException(NoNewsException())
            }
    }

}

class NoNewsException : Throwable()
