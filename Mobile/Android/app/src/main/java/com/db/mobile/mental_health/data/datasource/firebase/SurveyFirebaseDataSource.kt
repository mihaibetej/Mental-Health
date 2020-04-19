package com.db.mobile.mental_health.data.datasource.firebase

import com.db.mobile.mental_health.data.datasource.NoQuestionsException
import com.db.mobile.mental_health.data.datasource.SurveyDataSource
import com.db.mobile.mental_health.data.mappers.SurveyAnswerIdMapper
import com.db.mobile.mental_health.data.model.Question
import com.db.mobile.mental_health.data.model.SurveyAnswers
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.templates.Success
import com.google.firebase.firestore.CollectionReference
import com.google.firebase.firestore.SetOptions
import javax.inject.Inject
import javax.inject.Named
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

class SurveyFirebaseDataSource @Inject constructor(
    @Named("surveyTable") val surveyTable: CollectionReference,
    @Named("answersTable") val answersTable: CollectionReference,
    private val surveyAnswerKeyMapper: SurveyAnswerIdMapper
) : SurveyDataSource {

    override suspend fun getQuestions(): OpResult<List<Question>, NoQuestionsException> =
        suspendCoroutine { cont ->
            surveyTable.get()
                .addOnSuccessListener { it ->
                    val result = it.map { rawQuestion ->
                        val question = rawQuestion.toObject(Question::class.java)
                        question.id = rawQuestion.id
                        return@map question
                    }
                    cont.resume(Success(result))
                }
                .addOnFailureListener {
                    cont.resume(Failure(NoQuestionsException()))
                }
        }

    override suspend fun postAnswers(answers: SurveyAnswers): OpResult<Nothing?, NoQuestionsException> =
        suspendCoroutine { cont ->
            val key = surveyAnswerKeyMapper.map(answers.created)
            answersTable.document(key).set(answers, SetOptions.merge())
                .addOnSuccessListener {
                    cont.resume(Success(null))
                }
                .addOnFailureListener {
                    cont.resume(Failure(NoQuestionsException()))
                }
        }

    fun getHistory() {
        answersTable.get()
            .addOnSuccessListener {
                val result = it.toObjects(SurveyAnswers::class.java)
            }
    }

}
