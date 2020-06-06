package com.db.mobile.mental_health.ui.for_you.advices

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import com.db.mobile.mental_health.databinding.FragmentAdvicesBinding
import com.db.mobile.mental_health.ui.utils.DividerItemDecoration
import com.db.mobile.mental_health.ui.utils.prepareNetworkingView
import kotlinx.android.synthetic.main.fragment_advices.*
import javax.inject.Inject

class AdvicesFragment : Fragment() {
    private var advicesFragmentComponent: AdvicesFragmentComponent? = null

    @Inject
    lateinit var viewModel: AdvicesViewModel

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        advicesFragmentComponent = getApplicationComponent(context)?.advicesFragmentComponent()?.create()
        advicesFragmentComponent?.inject(this)

        val adapter = AdvicesAdapter()
        viewModel.advices.observe(viewLifecycleOwner, Observer {
            adapter.items.addAll(it)
            adapter.notifyDataSetChanged()
        })

        val binding: FragmentAdvicesBinding =
            DataBindingUtil.inflate(inflater, R.layout.fragment_advices, container, false)
        binding.adapter = adapter
        binding.viewModel = viewModel
        binding.root.prepareNetworkingView(viewLifecycleOwner, viewModel)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        advices_recycler_view.addItemDecoration(DividerItemDecoration(context, R.drawable.list_divider))
    }
}
