package com.db.mobile.mental_health.data.datasource

import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.data.model.Answer
import com.db.mobile.mental_health.data.model.Question

interface SurveyDataSource {
    suspend fun getQuestions(): OpResult<List<Question>, NoQuestionsException>
    suspend fun postAnswers(answers: List<Answer>): OpResult<Nothing, NoQuestionsException>
}

class NoQuestionsException : Throwable()
