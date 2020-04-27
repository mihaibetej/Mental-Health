package com.db.mobile.mental_health.data.datasource.firebase

import com.db.mobile.mental_health.data.datasource.UserInfoDataSource
import com.db.mobile.mental_health.data.datasource.UserUpdateError
import com.db.mobile.mental_health.data.model.UserInfo
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.templates.Success
import com.google.firebase.firestore.CollectionReference
import com.google.firebase.firestore.SetOptions
import javax.inject.Inject
import javax.inject.Named
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

class UserFirebaseDataSource @Inject constructor(@Named("usersTable") val db: CollectionReference) :
    UserInfoDataSource {

    override suspend fun updateUserInfo(userInfo: UserInfo): OpResult<Nothing?, UserUpdateError> =
        suspendCoroutine { cont ->
            db.document(userInfo.id).set(userInfo, SetOptions.merge())
                .addOnSuccessListener {
                    cont.resume(Success(null))
                }
                .addOnFailureListener {
                    cont.resume(Failure(UserUpdateError()))
                }
        }

}
