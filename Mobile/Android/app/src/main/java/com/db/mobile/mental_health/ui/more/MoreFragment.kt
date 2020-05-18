package com.db.mobile.mental_health.ui.more

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import com.db.mobile.mental_health.databinding.FragmentMoreBinding
import com.db.mobile.mental_health.ui.utils.DividerItemDecoration
import kotlinx.android.synthetic.main.fragment_more.*
import javax.inject.Inject

class MoreFragment : Fragment() {
    var component: MoreFragmentComponent? = null

    @Inject
    lateinit var moreViewModel: MoreViewModel

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        val binding = DataBindingUtil.inflate<FragmentMoreBinding>(
            inflater,
            R.layout.fragment_more,
            container,
            false
        )

        component = getApplicationComponent(context)?.moreFragmentComponent()?.create()
        component?.inject(this)

        val adapter = MoreMenuAdapter()
        adapter.items.addAll(resources.getStringArray(R.array.moreMenuItems))

        binding.adapter = adapter
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        more_recycler_view.addItemDecoration(
            DividerItemDecoration(
                context,
                R.drawable.list_divider
            )
        )
    }

}
