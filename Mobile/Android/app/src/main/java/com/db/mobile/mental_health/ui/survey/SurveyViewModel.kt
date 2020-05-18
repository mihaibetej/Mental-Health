package com.db.mobile.mental_health.ui.survey

import android.view.View
import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import androidx.navigation.findNavController
import com.db.mobile.mental_health.BR
import com.db.mobile.mental_health.domain.model.SurveyQuestion
import com.db.mobile.mental_health.domain.usecases.GetSurveyQuestionsUseCase
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.Success
import com.db.mobile.mental_health.ui.utils.LoadingOverlayView.State.*
import com.db.mobile.mental_health.ui.utils.NetworkingViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import javax.inject.Inject

class SurveyViewModel @Inject constructor(
    private val surveyQuestionsUseCase: GetSurveyQuestionsUseCase
) : NetworkingViewModel() {
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
        getQuestions()
    }

    override fun doRetry() {
        getQuestions()
    }

    fun onAnswerChanged(question: SurveyQuestion, answer: Int) {
        println("answer for question $question changed to $answer")
        question.answer = answer
    }

    fun submitSurvey(view: View) {
        val answeredQuestions = questions.value?.toTypedArray()
        if (answeredQuestions != null) {
            val action = SurveyFragmentDirections.actionNavigationSurveyToNavigationSurveyResult(answeredQuestions)
            view.findNavController().navigate(action)
        }
    }

    private fun getQuestions() {
        overlayState.postValue(LOADING)
        GlobalScope.launch(Dispatchers.IO) {
            showSurvey = when (val questionsResult = surveyQuestionsUseCase.execute()) {
                is Success -> {
                    questions.postValue(questionsResult.data)
                    overlayState.postValue(DISMISS)
                    true
                }
                is Failure -> {
                    overlayState.postValue(RETRY)
                    false
                }
            }
        }
    }

}
