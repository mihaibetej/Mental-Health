package com.db.mobile.mental_health.domain.model

data class UserInfo(
    val id: String,
    val email: String,
    val hospital: String,
    val jobTitle: String,
    val phoneNumber: String,
    val town: String
)
