package com.db.mobile.mental_health.data.datasource.firebase

import com.db.mobile.mental_health.data.datasource.NoQuestionsException
import com.db.mobile.mental_health.data.datasource.SurveyDataSource
import com.db.mobile.mental_health.data.model.Answer
import com.db.mobile.mental_health.data.model.Question
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.templates.Success
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.CollectionReference
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import javax.inject.Inject
import javax.inject.Named
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

class SurveyFirebaseDataSource @Inject constructor(@Named("surveyTable") val db: CollectionReference) :
    SurveyDataSource {

    override suspend fun getQuestions(): OpResult<List<Question>, NoQuestionsException> =
        suspendCoroutine { cont ->
            db.get()
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

    override suspend fun postAnswers(answers: List<Answer>): OpResult<Nothing, NoQuestionsException> {
        TODO("Not yet implemented")
        Firebase.firestore.collection("users").document(FirebaseAuth.getInstance().currentUser?.uid!!).firestore.collection("answers").add(Question())
    }
}
