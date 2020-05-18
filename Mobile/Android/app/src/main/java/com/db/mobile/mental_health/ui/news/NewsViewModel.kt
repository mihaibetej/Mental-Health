package com.db.mobile.mental_health.ui.news

import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import com.db.mobile.mental_health.BR
import com.db.mobile.mental_health.domain.model.News
import com.db.mobile.mental_health.domain.usecases.GetNewsUseCase
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.Success
import com.db.mobile.mental_health.ui.utils.LoadingOverlayView.State.*
import com.db.mobile.mental_health.ui.utils.NetworkingViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import javax.inject.Inject

class NewsViewModel @Inject constructor(private val getNewsUseCase: GetNewsUseCase) :
    NetworkingViewModel() {

    val news = MutableLiveData<List<News>>()

    var showNews: Boolean? = false
        @Bindable
        get
        @Bindable
        set(value) {
            if (field != value) {
                field = value
                notifyPropertyChanged(BR.showNews)
            }
        }

    init {
        getData()
    }

    override fun doRetry() {
        getData()
    }

    private fun getData() {
        loadingStatus.postValue(LOADING)
        GlobalScope.launch(Dispatchers.IO) {
            showNews = when (val result = getNewsUseCase.execute()) {
                is Success -> {
                    news.postValue(result.data)
                    loadingStatus.postValue(DISMISS)
                    true
                }
                is Failure -> {
                    loadingStatus.postValue(RETRY)
                    false
                }
            }
        }
    }

}
