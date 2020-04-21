package com.db.mobile.mental_health.domain.usecases

import com.db.mobile.mental_health.data.datasource.SurveyDataSource
import com.db.mobile.mental_health.data.model.SurveyAnswers
import com.db.mobile.mental_health.data.model.SurveyPostAnswer
import com.db.mobile.mental_health.domain.exceptions.NoDataException
import com.db.mobile.mental_health.domain.mappers.SurveyResultMapper
import com.db.mobile.mental_health.domain.model.SurveyQuestion
import com.db.mobile.mental_health.domain.model.SurveyResult
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.templates.Success
import java.util.*
import javax.inject.Inject

class PostAnswersUseCase @Inject constructor(
    private val dataSource: SurveyDataSource,
    private val resultMapper: SurveyResultMapper
) {

    suspend fun execute(questions: List<SurveyQuestion>): OpResult<SurveyResult, NoDataException> {
        val answers = questions.map {
            SurveyPostAnswer(it.id!!, it.question!!, it.answers!![it.answer!!], it.answer!!)
        }

        val answerData = SurveyAnswers(Date(), answers)

        return when (dataSource.postAnswers(answerData)) {
            is Success -> {
                Success(resultMapper.map(questions.sumBy { it.answer!! }))
            }
            is Failure -> {
                Failure(NoDataException())
            }
        }
    }

}
