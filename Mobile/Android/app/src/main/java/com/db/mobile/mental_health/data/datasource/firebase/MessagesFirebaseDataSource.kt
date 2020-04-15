package com.db.mobile.mental_health.data.datasource.firebase

import com.db.mobile.mental_health.data.datasource.MessagesDataSource
import com.db.mobile.mental_health.data.datasource.NoMessagesException
import com.db.mobile.mental_health.data.model.Message
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.templates.Success
import com.google.firebase.firestore.CollectionReference
import javax.inject.Inject
import javax.inject.Named
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

class MessagesFirebaseDataSource @Inject constructor(@Named("messagesTable") val db: CollectionReference) : MessagesDataSource {

    override suspend fun getMessages(): OpResult<List<Message>, NoMessagesException> =
        suspendCoroutine { continuation ->
            db.get()
                .addOnSuccessListener {
                    continuation.resume(Success(it.toObjects(Message::class.java)))
                }
                .addOnFailureListener {
                    continuation.resume(Failure(NoMessagesException()))
                }
        }

}