package com.db.mobile.mental_health.ui.for_you

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.viewpager.widget.ViewPager
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import com.google.android.material.tabs.TabLayout
import javax.inject.Inject

class ForYouFragment : Fragment() {
    private var forYouComponent: ForYouComponent? = null
    private lateinit var forYouPagerAdapter: ForYouPagerAdapter
    private lateinit var viewPager: ViewPager
    private lateinit var tabLayout: TabLayout

    @Inject
    lateinit var viewModel: ForYouViewModel

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        forYouComponent = getApplicationComponent(context)?.forYouComponent()?.create()
        forYouComponent?.inject(this)
        return inflater.inflate(R.layout.fragment_for_you, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        initViews(view)

        forYouPagerAdapter = ForYouPagerAdapter(childFragmentManager, resources)
        viewPager.adapter = forYouPagerAdapter
        tabLayout.setupWithViewPager(viewPager)
    }

    private fun initViews(view: View) {
        viewPager = view.findViewById(R.id.for_you_pager)
        tabLayout = view.findViewById(R.id.for_you_tab_layout)
    }
}
