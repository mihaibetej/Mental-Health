package com.db.mobile.mental_health.data.model

import java.util.*

data class Message (
    val body: String? = "",
    val creationDate: Date? = null,
    val from: String? = "",
    val to: String? = ""
)