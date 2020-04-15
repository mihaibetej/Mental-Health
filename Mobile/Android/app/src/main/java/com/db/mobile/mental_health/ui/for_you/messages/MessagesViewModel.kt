package com.db.mobile.mental_health.ui.for_you.messages

import androidx.databinding.BaseObservable
import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import com.db.mobile.mental_health.BR
import com.db.mobile.mental_health.domain.model.Message
import com.db.mobile.mental_health.domain.usecases.GetMessagesUseCase
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.Success
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import javax.inject.Inject

class MessagesViewModel @Inject constructor(private val getMessagesUseCase: GetMessagesUseCase) :
    BaseObservable() {
    val messages = MutableLiveData<List<Message>>()

    var showMessages: Boolean? = false
        @Bindable
        get
        @Bindable
        set(value) {
            if (field != value) {
                field = value
                notifyPropertyChanged(BR.showMessages)
            }
        }

    init {
        GlobalScope.launch(Dispatchers.IO) {
            when (val result = getMessagesUseCase.execute()) {
                is Success -> {
                    messages.postValue(result.data)
                    showMessages = true
                }

                is Failure ->
                    TODO("not handled")

            }
        }
    }

}