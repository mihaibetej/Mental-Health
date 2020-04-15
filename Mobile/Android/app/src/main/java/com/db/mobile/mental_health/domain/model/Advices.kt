package com.db.mobile.mental_health.domain.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize
import java.util.*

@Parcelize
data class Advices(val body: String?, val date: Date?, val image: String?, val title: String?) : Parcelable