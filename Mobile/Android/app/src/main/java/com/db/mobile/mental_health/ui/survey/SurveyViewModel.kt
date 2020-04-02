package com.db.mobile.mental_health.ui.survey

import android.view.View
import androidx.databinding.BaseObservable
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.db.mobile.mental_health.ui.survey.model.SurveyQuestion
import javax.inject.Inject

class SurveyViewModel @Inject constructor() : BaseObservable() {
    var questions: LiveData<List<SurveyQuestion>>? = null

    init {
        val localQuestions = MutableLiveData<List<SurveyQuestion>>().apply {
            value = listOf(
                SurveyQuestion(0, "1. Question 1"),
                SurveyQuestion(1, "2. Question 2"),
                SurveyQuestion(2, "3. Question 2"),
                SurveyQuestion(3, "4. Question 2"),
                SurveyQuestion(4, "5. Question 2"),
                SurveyQuestion(5, "6. Question 2"),
                SurveyQuestion(6, "7. Question 2"),
                SurveyQuestion(7, "8. Question 2"),
                SurveyQuestion(8, "9. Question 2"),
                SurveyQuestion(9, "10. Question 3")
            )
        }
        questions = localQuestions
    }

    fun onAnswerChanged(question: SurveyQuestion, answer: Int) {
        println("answer for question $question changed to $answer")
        question.answer = answer
    }

    fun submitSurvey(view: View) {
        println("submit survey")
    }

}
