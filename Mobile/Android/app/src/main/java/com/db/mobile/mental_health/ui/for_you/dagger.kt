package com.db.mobile.mental_health.ui.for_you

import dagger.Module
import dagger.Subcomponent

@Subcomponent
interface ForYouFragmentComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): ForYouFragmentComponent
    }

    fun inject(forYouFragment: ForYouFragment)
}

@Module(subcomponents = [ForYouFragmentComponent::class])
abstract class ForYouFragmentModule