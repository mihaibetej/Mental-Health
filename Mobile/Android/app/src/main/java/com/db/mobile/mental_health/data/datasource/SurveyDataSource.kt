package com.db.mobile.mental_health.data.datasource

import com.db.mobile.mental_health.data.DataSourceResult
import com.db.mobile.mental_health.data.model.Question

interface SurveyDataSource {
    suspend fun getQuestions(): DataSourceResult<List<Question>, NoQuestionsException>
}

class NoQuestionsException : Throwable()
