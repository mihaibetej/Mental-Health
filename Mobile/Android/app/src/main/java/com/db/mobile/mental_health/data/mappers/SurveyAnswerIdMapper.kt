package com.db.mobile.mental_health.data.mappers

import com.db.mobile.mental_health.templates.BidirectionalMapper
import java.text.SimpleDateFormat
import java.util.*
import javax.inject.Inject

class SurveyAnswerIdMapper @Inject constructor() : BidirectionalMapper<Date, String> {
    private val formatter = SimpleDateFormat("YYYY-MM-dd", Locale.US)

    override fun map(input: Date): String = formatter.format(input)

    override fun revert(input: String): Date = formatter.parse(input)!!

}
