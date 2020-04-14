package com.db.mobile.mental_health.ui.news

import androidx.databinding.BaseObservable
import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import com.db.mobile.mental_health.BR
import com.db.mobile.mental_health.domain.model.News
import com.db.mobile.mental_health.domain.usecases.GetNewsUseCase
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.Success
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import javax.inject.Inject

class NewsViewModel @Inject constructor(private val getNewsUseCase: GetNewsUseCase) :
    BaseObservable() {

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
        GlobalScope.launch(Dispatchers.IO) {
            when (val result = getNewsUseCase.execute()) {
                is Success ->
                    showNews(result.data)

                is Failure ->
                    TODO("not handled")

            }
        }
    }

    private suspend fun showNews(result: List<News>?) = withContext(Dispatchers.Main) {
        news.value = result
        showNews = true
    }

}
