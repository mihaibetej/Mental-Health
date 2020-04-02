package com.db.mobile.mental_health.ui.survey

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.databinding.FragmentSurveyBinding
import com.db.mobile.mental_health.ui.survey.model.SurveyQuestion

class SurveyFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val binding: FragmentSurveyBinding =
            DataBindingUtil.inflate(inflater, R.layout.fragment_survey, container, false)
        val adapter = SurveyAdapter()
        adapter.items.addAll(
            listOf(
                SurveyQuestion(0, "1. Question 1"),
                SurveyQuestion(1, "2. Question 2"),
                SurveyQuestion(2, "3. Question 3")
            )
        )
        adapter.surveyAnswerChanged = this::answerChanged
        adapter.submitSurvey = {
            //TODO submit question
        }
        adapter.notifyDataSetChanged()
        binding.adapter = adapter
        return binding.root
    }

    private fun answerChanged(survey: SurveyQuestion, answer: Int) {
        //TODO use
    }



}
