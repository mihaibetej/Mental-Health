package com.db.mobile.mental_health.ui.survey.result

import android.graphics.Paint
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.navArgs
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import com.db.mobile.mental_health.databinding.FragmentSurveyResultBinding
import kotlinx.android.synthetic.main.fragment_survey_result.*
import javax.inject.Inject

class SurveyResultFragment : Fragment() {
    private val args: SurveyResultFragmentArgs by navArgs()

    private var component: SurveyResultComponent? = null

    @Inject
    lateinit var viewModel: SurveyResultViewModel

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        component = getApplicationComponent(context)?.surveyResultComponent()?.create()
        component?.inject(this)

        viewModel.answeredQuestions = args.questions

        val dataBinding = DataBindingUtil.inflate<FragmentSurveyResultBinding>(
            inflater,
            R.layout.fragment_survey_result,
            container,
            false
        )
        dataBinding.viewModel = viewModel

        return dataBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        survey_phone_number.paintFlags = survey_phone_number.paintFlags or Paint.UNDERLINE_TEXT_FLAG

    }

}
