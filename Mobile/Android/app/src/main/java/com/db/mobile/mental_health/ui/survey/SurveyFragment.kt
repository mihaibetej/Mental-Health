package com.db.mobile.mental_health.ui.survey

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import com.db.mobile.mental_health.databinding.FragmentSurveyBinding
import com.db.mobile.mental_health.ui.utils.prepareNetworkingView
import javax.inject.Inject

class SurveyFragment : Fragment() {
    private var component: SurveyComponent? = null

    @Inject
    lateinit var viewModel: SurveyViewModel

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        component = getApplicationComponent(context)?.surveyComponent()?.create()
        component?.inject(this)

        val adapter = SurveyAdapter(viewModel)
        viewModel.questions.observe(viewLifecycleOwner, Observer {
            adapter.items.addAll(it)
            adapter.notifyDataSetChanged()
        })

        val binding: FragmentSurveyBinding =
            DataBindingUtil.inflate(inflater, R.layout.fragment_survey, container, false)
        binding.adapter = adapter
        binding.viewModel = viewModel
        binding.root.prepareNetworkingView(viewLifecycleOwner, viewModel)
        return binding.root
    }

}
