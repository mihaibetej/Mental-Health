package com.db.mobile.mental_health.ui.for_you.messages

import dagger.Module
import dagger.Subcomponent

@Subcomponent
interface MessagesComponent {
    @Subcomponent.Factory
    interface Factory {
        fun create(): MessagesComponent
    }

    fun inject(messagesFragment: MessagesFragment)
}

@Module(subcomponents = [MessagesComponent::class])
abstract class MessagesModule