package com.db.mobile.mental_health.data.datasource

import com.db.mobile.mental_health.data.model.News

interface NewsDataSource {
    suspend fun getNews(): List<News>?
}
