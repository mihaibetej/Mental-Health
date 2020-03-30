package com.db.mobile.mental_health.ui.news.dagger

import com.db.mobile.mental_health.ui.news.NewsViewModel
import dagger.Subcomponent

@Subcomponent
interface NewsFragmentComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): NewsFragmentComponent
    }

    fun inject(newsViewModel: NewsViewModel)
}