package com.db.mobile.mental_health.ui.for_you

import dagger.Module
import dagger.Subcomponent

@Subcomponent
interface ForYouComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): ForYouComponent
    }

    fun inject(forYouFragment: ForYouFragment)
}

@Module(subcomponents = [ForYouComponent::class])
abstract class ForYouModule