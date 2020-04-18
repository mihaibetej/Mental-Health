package com.db.mobile.mental_health.domain.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize
import java.util.*

@Parcelize
data class Advice(
    val body: String?,
    val creationDate: Date?,
    val publishDate: Date?
) : Parcelable