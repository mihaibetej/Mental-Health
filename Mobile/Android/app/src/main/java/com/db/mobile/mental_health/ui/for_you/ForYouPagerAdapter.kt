package com.db.mobile.mental_health.ui.for_you

import android.content.res.Resources
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentPagerAdapter
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.ui.for_you.advices.AdvicesFragment
import com.db.mobile.mental_health.ui.for_you.messages.MessagesFragment

class ForYouPagerAdapter(fragmentManager: FragmentManager, private var resources: Resources) : FragmentPagerAdapter(fragmentManager, BEHAVIOR_RESUME_ONLY_CURRENT_FRAGMENT) {
    private val count = 2

    override fun getItem(position: Int): Fragment =
        when (position) {
            0 -> AdvicesFragment()
            else -> MessagesFragment()
        }

    override fun getCount(): Int = count

    override fun getPageTitle(position: Int): CharSequence?  =
        when (position) {
            0 -> resources.getString(R.string.title_advices)
            else -> resources.getString(R.string.title_messages)
        }
}