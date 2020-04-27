package com.db.mobile.mental_health.ui.survey.result

import android.content.Intent
import android.net.Uri
import android.view.View
import androidx.databinding.BaseObservable
import androidx.databinding.Bindable
import com.db.mobile.mental_health.BR
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.domain.model.SurveyQuestion
import com.db.mobile.mental_health.domain.model.SurveyResult
import com.db.mobile.mental_health.domain.usecases.PostAnswersUseCase
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.Success
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import javax.inject.Inject


class SurveyResultViewModel @Inject constructor(
    private val postAnswersUseCase: PostAnswersUseCase
) : BaseObservable() {

    var answeredQuestions: Array<SurveyQuestion>? = null
        set(value) {
            if (field != value && value != null) {
                field = value
                postAnswers(value.asList())
            }
        }

    var phoneNumber: String = "0717 987 666"
        @Bindable get
        @Bindable set(value) {
            if (value != field) {
                field = value
                notifyPropertyChanged(BR.phoneNumber)
            }
        }

    var emailAddress: String = "test@contact.com"
        @Bindable get
        @Bindable set(value) {
            if (value != field) {
                field = value
                notifyPropertyChanged(BR.emailAddress)
            }
        }

    var showSurveyResult: Boolean = false
        @Bindable get
        @Bindable set(value) {
            if (value != field) {
                field = value
                notifyPropertyChanged(BR.showSurveyResult)
            }
        }

    var surveyResultText: Int? = 0
        @Bindable get
        @Bindable set(value) {
            if (value != field) {
                field = value
                notifyPropertyChanged(BR.surveyResultText)
            }
        }

    fun onPhoneClicked(view: View) {
        val intent = Intent(Intent.ACTION_DIAL)
        intent.data = Uri.parse("tel:$phoneNumber")
        view.context.startActivity(intent)
    }

    fun onEmailClicked(view: View) {
        val intent = Intent(Intent.ACTION_SEND)
        intent.type = "text/html"
        intent.putExtra(Intent.EXTRA_EMAIL, emailAddress)
        view.context.startActivity(Intent.createChooser(intent, "Trimite email"))
    }

    private fun postAnswers(questions: List<SurveyQuestion>) =
        GlobalScope.launch {
            when (val surveyResult = postAnswersUseCase.execute(questions)) {
                is Success -> {
                    surveyResultText = when (surveyResult.data) {
                        SurveyResult.GOOD -> R.string.survey_result_good
                        SurveyResult.NEUTRAL -> R.string.survey_result_neutral
                        SurveyResult.BAD -> R.string.survey_result_bad
                    }
                    showSurveyResult = true
                }
                is Failure -> {
                    TODO("retry not implemented")
                }
            }
        }


}
