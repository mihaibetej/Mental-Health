package com.db.mobile.mental_health.ui.more

import dagger.Module
import dagger.Subcomponent

@Subcomponent
interface MoreFragmentComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): MoreFragmentComponent
    }

    fun inject(surveyFragment: MoreFragment)

}

@Module(subcomponents = [MoreFragmentComponent::class])
abstract class MoreFragmentModule
