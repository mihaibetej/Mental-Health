package com.db.mobile.mental_health.domain.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class News(val title: String, val img: String, val body: String) : Parcelable
