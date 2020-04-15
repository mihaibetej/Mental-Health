package com.db.mobile.mental_health.ui.for_you.messages

import dagger.Module
import dagger.Subcomponent

@Subcomponent
interface MessagesFragmentComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): MessagesFragmentComponent
    }

    fun inject(messagesFragment: MessagesFragment)
}

@Module(subcomponents = [MessagesFragmentComponent::class])
abstract class MessagesFragmentModule