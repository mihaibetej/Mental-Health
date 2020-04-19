package com.db.mobile.mental_health.data.datasource

import com.db.mobile.mental_health.data.model.Question
import com.db.mobile.mental_health.data.model.SurveyAnswers
import com.db.mobile.mental_health.templates.OpResult

interface SurveyDataSource {
    suspend fun getQuestions(): OpResult<List<Question>, NoQuestionsException>
    suspend fun postAnswers(answers: SurveyAnswers): OpResult<Nothing?, NoQuestionsException>
}

class NoQuestionsException : Throwable()
