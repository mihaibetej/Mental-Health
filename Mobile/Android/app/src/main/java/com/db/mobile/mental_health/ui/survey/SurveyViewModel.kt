package com.db.mobile.mental_health.ui.survey

import android.os.Handler
import android.view.View
import androidx.databinding.BaseObservable
import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import com.db.mobile.mental_health.BR
import com.db.mobile.mental_health.ui.survey.model.SurveyQuestion
import javax.inject.Inject

class SurveyViewModel @Inject constructor() : BaseObservable() {
    val questions = MutableLiveData<List<SurveyQuestion>>()

    var showSurvey: Boolean? = false
        @Bindable
        get
        @Bindable
        set(value) {
            if (field != value) {
                field = value
                notifyPropertyChanged(BR.showSurvey)
            }
        }

    init {
        val localQuestions = listOf(
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

        Handler().postDelayed(
            Runnable {
                showSurvey = true
                questions.value = localQuestions
            }, 800
        )


    }

    fun onAnswerChanged(question: SurveyQuestion, answer: Int) {
        println("answer for question $question changed to $answer")
        question.answer = answer
    }

    fun submitSurvey(view: View) {
        println("submit survey")
    }

}
