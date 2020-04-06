package com.db.mobile.mental_health.ui.news

import androidx.databinding.BaseObservable
import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import com.db.mobile.mental_health.BR
import com.db.mobile.mental_health.data.datasource.NewsDataSource
import com.db.mobile.mental_health.domain.model.News
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import javax.inject.Inject

class NewsViewModel @Inject constructor(private val newsDataSource: NewsDataSource) : BaseObservable() {
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
            val result = newsDataSource.getNews()
            showNews(result?.map {
                News(it.title, it.image, it.body)
            })
        }
    }

    private suspend fun showNews(result: List<News>?) = withContext(Dispatchers.Main) {
        news.value = result
        showNews = true
    }

}
