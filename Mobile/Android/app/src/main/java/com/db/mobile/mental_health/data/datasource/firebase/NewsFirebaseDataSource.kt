package com.db.mobile.mental_health.data.datasource.firebase

import com.db.mobile.mental_health.data.datasource.NewsDataSource
import com.db.mobile.mental_health.data.datasource.NoNewsException
import com.db.mobile.mental_health.data.model.News
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.templates.Success
import com.google.firebase.firestore.CollectionReference
import javax.inject.Inject
import javax.inject.Named
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

class NewsFirebaseDataSource @Inject constructor(@Named("newsTable") val db: CollectionReference) :
    NewsDataSource {

    override suspend fun getNews(): OpResult<List<News>, NoNewsException> =
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
