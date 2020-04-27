package com.db.mobile.mental_health.domain.model

import android.util.SparseArray

data class SurveyQuestion(var id: String, val question: String, var answer: Int = 2, var answers: SparseArray<String>)
