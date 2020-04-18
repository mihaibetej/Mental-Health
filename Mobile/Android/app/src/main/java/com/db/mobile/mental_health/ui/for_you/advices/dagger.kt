package com.db.mobile.mental_health.ui.for_you.advices

import dagger.Module
import dagger.Subcomponent

@Subcomponent
interface AdvicesFragmentComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): AdvicesFragmentComponent
    }

    fun inject(advicesFragment: AdvicesFragment)
}

@Module(subcomponents = [AdvicesFragmentComponent::class])
abstract class AdvicesFragmentModule