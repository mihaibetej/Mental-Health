package com.db.mobile.mental_health.domain.mappers

import com.db.mobile.mental_health.domain.model.SurveyResult
import com.db.mobile.mental_health.templates.Mapper
import javax.inject.Inject

class SurveyResultMapper @Inject constructor() : Mapper<Int, SurveyResult> {
    private val goodRange = 40..60
    private val neutralRange = 20..39
    private val badRange = 0..19


    override fun map(input: Int): SurveyResult = when (input) {
        in goodRange -> SurveyResult.GOOD
        in neutralRange -> SurveyResult.NEUTRAL
        in badRange -> SurveyResult.BAD
        else -> SurveyResult.NEUTRAL
    }

}
