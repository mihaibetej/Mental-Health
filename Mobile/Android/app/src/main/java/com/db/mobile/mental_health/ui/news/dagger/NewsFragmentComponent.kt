package com.db.mobile.mental_health.ui.news.dagger

import com.db.mobile.mental_health.ui.news.NewsFragment
import dagger.Subcomponent

@Subcomponent
interface NewsFragmentComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): NewsFragmentComponent
    }

    fun inject(newsFragment: NewsFragment)
}
