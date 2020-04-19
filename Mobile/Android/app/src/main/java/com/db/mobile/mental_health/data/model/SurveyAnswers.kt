package com.db.mobile.mental_health.data.model

import java.util.*

data class SurveyAnswers(val created: Date, val items: List<SurveyPostAnswer>)

data class SurveyPostAnswer(
    val question_id: String,
    val question_body: String,
    val answer_title: String,
    val answer_value: Int
)
