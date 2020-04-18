package com.db.mobile.mental_health.data.model

data class UserInfo(
    val id: String = "",
    val email: String? = "",
    val hospital: String? = "",
    val jobTitle: String? = "",
    val phoneNo: String? = "",
    val town: String? = ""
)
