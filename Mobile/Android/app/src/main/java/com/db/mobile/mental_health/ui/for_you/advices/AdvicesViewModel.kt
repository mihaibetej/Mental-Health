package com.db.mobile.mental_health.ui.for_you.advices

import androidx.databinding.BaseObservable
import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import com.db.mobile.mental_health.BR
import com.db.mobile.mental_health.domain.model.Advice
import com.db.mobile.mental_health.domain.usecases.GetAdvicesUseCase
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.Success
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import javax.inject.Inject

class AdvicesViewModel @Inject constructor(private val getAdvicesUseCase: GetAdvicesUseCase) :
    BaseObservable() {

    val advices = MutableLiveData<List<Advice>>()

    var showAdvices: Boolean? = false
        @Bindable
        get
        @Bindable
        set(value) {
            if (field != value) {
                field = value
                notifyPropertyChanged(BR.showAdvices)
            }
        }

    init {
        GlobalScope.launch(Dispatchers.IO) {
            when (val result = getAdvicesUseCase.execute()) {
                is Success ->
                    showAdvices(result.data)

                is Failure ->
                    TODO("not handled")

            }
        }
    }

    private suspend fun showAdvices(result: List<Advice>?) = withContext(Dispatchers.Main) {
        advices.value = result
        showAdvices = true
    }
}