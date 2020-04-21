package com.db.mobile.mental_health.domain.model

import android.os.Parcel
import android.os.Parcelable
import android.util.SparseArray
import kotlinx.android.parcel.Parcelize

data class SurveyQuestion(
    var id: String?,
    val question: String?,
    var answer: Int?,
    var answers: SparseArray<String>?
) : Parcelable {
    constructor(source: Parcel) : this(
        source.readString(),
        source.readString(),
        source.readValue(Int::class.java.classLoader) as Int?,
        source.readSparseArray<String>(SparseArray::class.java.classLoader)
    )

    override fun describeContents() = 0

    override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
        writeString(id)
        writeString(question)
        writeValue(answer)
        writeSparseArray<String>(answers)
    }

    companion object {
        @JvmField
        val CREATOR: Parcelable.Creator<SurveyQuestion> =
            object : Parcelable.Creator<SurveyQuestion> {
                override fun createFromParcel(source: Parcel): SurveyQuestion =
                    SurveyQuestion(source)

                override fun newArray(size: Int): Array<SurveyQuestion?> = arrayOfNulls(size)
            }
    }
}
