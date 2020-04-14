package com.db.mobile.mental_health.ui.survey

import android.view.View
import androidx.databinding.BaseObservable
import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import com.db.mobile.mental_health.BR
import com.db.mobile.mental_health.domain.model.SurveyQuestion
import com.db.mobile.mental_health.domain.usecases.GetSurveyQuestionsUseCase
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.Success
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import javax.inject.Inject

class SurveyViewModel @Inject constructor(private val surveyQuestionsUseCase: GetSurveyQuestionsUseCase) :
    BaseObservable() {
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
        GlobalScope.launch(Dispatchers.IO) {
            when (val questionsResult = surveyQuestionsUseCase.execute()) {
                is Success -> {
                    showSurvey = true
                    questions.postValue(questionsResult.data)
                }
                is Failure -> {
                    TODO("treat exception")
                }
            }
        }
    }

    fun onAnswerChanged(question: SurveyQuestion, answer: Int) {
        println("answer for question $question changed to $answer")
        question.answer = answer
    }

    fun submitSurvey(view: View) {
        println("submit survey")
    }

}
