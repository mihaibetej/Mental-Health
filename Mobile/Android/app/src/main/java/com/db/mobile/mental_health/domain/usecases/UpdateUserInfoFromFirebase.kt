package com.db.mobile.mental_health.domain.usecases

import com.db.mobile.mental_health.data.datasource.UserInfoDataSource
import com.db.mobile.mental_health.data.model.UserInfo
import com.db.mobile.mental_health.templates.NoIOUseCase
import com.google.firebase.auth.FirebaseAuth
import javax.inject.Inject

class UpdateUserInfoFromFirebase @Inject constructor(private val dataSource: UserInfoDataSource) :
    NoIOUseCase {

    override suspend fun execute() {
        val userData = FirebaseAuth.getInstance().currentUser!!
        dataSource.updateUserInfo(
            UserInfo(
                id = userData.uid,
                email = userData.email,
                phoneNo = userData.phoneNumber
            )
        )
    }
}
