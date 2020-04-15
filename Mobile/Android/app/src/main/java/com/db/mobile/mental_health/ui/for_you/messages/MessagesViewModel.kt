package com.db.mobile.mental_health.ui.for_you.messages

import androidx.databinding.BaseObservable
import com.db.mobile.mental_health.domain.usecases.GetAdvicesUseCase
import javax.inject.Inject

class MessagesViewModel @Inject constructor(private val getAdvicesUseCase: GetAdvicesUseCase) :
    BaseObservable() {

}