package com.db.mobile.mental_health.data.datasource.firebase

import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.data.datasource.NoQuestionsException
import com.db.mobile.mental_health.data.datasource.SurveyDataSource
import com.db.mobile.mental_health.data.model.Answer
import com.db.mobile.mental_health.data.model.Question

class SurveyFirebaseDataSource : SurveyDataSource {
    override suspend fun getQuestions(): OpResult<List<Question>, NoQuestionsException> {
        TODO("Not yet implemented")
    }

    override suspend fun postAnswers(answers: List<Answer>): OpResult<Nothing, NoQuestionsException> {
        TODO("Not yet implemented")
    }
}
