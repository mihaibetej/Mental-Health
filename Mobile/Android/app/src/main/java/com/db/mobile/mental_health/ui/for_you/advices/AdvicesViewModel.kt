package com.db.mobile.mental_health.ui.for_you.advices

import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import com.db.mobile.mental_health.BR
import com.db.mobile.mental_health.domain.model.Advice
import com.db.mobile.mental_health.domain.usecases.GetAdvicesUseCase
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.Success
import com.db.mobile.mental_health.ui.utils.LoadingOverlayView.State.*
import com.db.mobile.mental_health.ui.utils.NetworkingViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import javax.inject.Inject

class AdvicesViewModel @Inject constructor(private val getAdvicesUseCase: GetAdvicesUseCase) :
    NetworkingViewModel() {

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
        getAdvices()
    }

    override fun doRetry() {
        getAdvices()
    }

    private fun getAdvices() {
        overlayState.postValue(LOADING)
        GlobalScope.launch(Dispatchers.IO) {
            showAdvices = when (val result = getAdvicesUseCase.execute()) {
                is Success -> {
                    advices.postValue(result.data)
                    overlayState.postValue(DISMISS)
                    true
                }

                is Failure -> {
                    overlayState.postValue(RETRY)
                    false
                }
            }
        }
    }
}
