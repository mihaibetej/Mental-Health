package com.db.mobile.mental_health.ui.news

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import com.db.mobile.mental_health.databinding.FragmentNewsBinding
import com.db.mobile.mental_health.ui.news.dagger.NewsFragmentComponent
import javax.inject.Inject

class NewsFragment : Fragment() {
    private var newsFragmentComponent: NewsFragmentComponent? = null

    @Inject
    lateinit var viewModel: NewsViewModel

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        newsFragmentComponent = getApplicationComponent(context)?.newsFragmentComponent()?.create()
        newsFragmentComponent?.inject(this)

        val adapter = NewsAdapter(viewModel)
        viewModel.news.observe(viewLifecycleOwner, Observer {
            adapter.items.addAll(it)
            adapter.notifyDataSetChanged()
        })

        val binding: FragmentNewsBinding =
            DataBindingUtil.inflate(inflater, R.layout.fragment_news, container, false)
        binding.adapter = adapter
        binding.viewModel = viewModel
        return binding.root
    }
}
