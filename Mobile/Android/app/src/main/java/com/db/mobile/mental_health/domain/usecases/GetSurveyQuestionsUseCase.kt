package com.db.mobile.mental_health.domain.usecases

import android.util.SparseArray
import androidx.core.util.set
import com.db.mobile.mental_health.data.datasource.SurveyDataSource
import com.db.mobile.mental_health.domain.exceptions.NoDataException
import com.db.mobile.mental_health.domain.model.SurveyQuestion
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.NoInputUseCase
import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.templates.Success
import javax.inject.Inject

private const val DEFAULT_ANSWER = 2

class GetSurveyQuestionsUseCase @Inject constructor(private val surveyDataSource: SurveyDataSource) :
    NoInputUseCase<OpResult<List<SurveyQuestion>, NoDataException>> {

    override suspend fun execute(): OpResult<List<SurveyQuestion>, NoDataException> =
        when (val questionsResult = surveyDataSource.getQuestions()) {
            is Success -> {
                Success(questionsResult.data.map {
                    val answers = SparseArray<String>()
                    it.answers?.map { answer -> answers[answer.value!!] = answer.title!! }
                    SurveyQuestion(it.id!!, it.body!!, DEFAULT_ANSWER, answers)
                })
            }
            is Failure -> {
                Failure(NoDataException())
            }
        }

}
