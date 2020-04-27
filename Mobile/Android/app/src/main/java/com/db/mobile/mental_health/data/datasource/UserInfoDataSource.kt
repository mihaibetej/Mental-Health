package com.db.mobile.mental_health.data.datasource

import com.db.mobile.mental_health.data.model.UserInfo
import com.db.mobile.mental_health.templates.OpResult

interface UserInfoDataSource {
    suspend fun updateUserInfo(userInfo: UserInfo): OpResult<Nothing?, UserUpdateError>
}

class UserUpdateError : Throwable()
