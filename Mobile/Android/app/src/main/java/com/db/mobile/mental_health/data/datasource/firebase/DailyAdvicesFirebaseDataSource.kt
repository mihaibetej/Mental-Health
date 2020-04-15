package com.db.mobile.mental_health.data.datasource.firebase

import com.db.mobile.mental_health.data.datasource.DailyAdvicesDataSource
import com.db.mobile.mental_health.data.datasource.NoAdvicesException
import com.db.mobile.mental_health.data.model.DailyAdvices
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.templates.Success
import com.google.firebase.firestore.CollectionReference
import javax.inject.Inject
import javax.inject.Named
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

class DailyAdvicesFirebaseDataSource @Inject constructor(@Named("dailyAdvicesTable") val db: CollectionReference) : DailyAdvicesDataSource {

    override suspend fun getAdvices(): OpResult<List<DailyAdvices>, NoAdvicesException> =
        suspendCoroutine { continuation ->
            db.get()
                .addOnSuccessListener {
                    continuation.resume(Success(it.toObjects(DailyAdvices::class.java)))
                }
                .addOnFailureListener {
                    continuation.resume(Failure(NoAdvicesException()))
                }
        }

}