package com.db.mobile.mental_health.ui.advices

import dagger.Module
import dagger.Subcomponent

@Subcomponent
interface AdvicesComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): AdvicesComponent
    }

    fun inject(advicesFragment: AdvicesFragment)
}

@Module(subcomponents = [AdvicesComponent::class])
abstract class AdvicesModule