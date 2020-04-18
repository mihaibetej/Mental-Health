package com.db.mobile.mental_health.ui.for_you

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import kotlinx.android.synthetic.main.fragment_for_you.*
import javax.inject.Inject

class ForYouFragment : Fragment() {
    private var forYouComponent: ForYouFragmentComponent? = null
    private lateinit var forYouPagerAdapter: ForYouPagerAdapter

    @Inject
    lateinit var viewModel: ForYouViewModel

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        forYouComponent = getApplicationComponent(context)?.forYouFragmentComponent()?.create()
        forYouComponent?.inject(this)
        return inflater.inflate(R.layout.fragment_for_you, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        forYouPagerAdapter = ForYouPagerAdapter(childFragmentManager, resources)
        for_you_pager.adapter = forYouPagerAdapter
        for_you_tab_layout.setupWithViewPager(for_you_pager)
    }

}
