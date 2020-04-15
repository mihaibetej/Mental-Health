package com.db.mobile.mental_health.ui.for_you.messages

import androidx.databinding.BaseObservable
import com.db.mobile.mental_health.domain.usecases.GetMessagesUseCase
import javax.inject.Inject

class MessagesViewModel @Inject constructor(private val getMessagesUseCase: GetMessagesUseCase) :
    BaseObservable() {

}