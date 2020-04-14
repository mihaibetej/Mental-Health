package com.db.mobile.mental_health.domain.usecases

import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.Success
import com.db.mobile.mental_health.data.datasource.NewsDataSource
import com.db.mobile.mental_health.domain.exceptions.NoDataException
import com.db.mobile.mental_health.domain.model.News
import com.db.mobile.mental_health.templates.NoInputUseCase
import javax.inject.Inject

class GetNewsUseCase @Inject constructor(private val newsDataSource: NewsDataSource) :
    NoInputUseCase<OpResult<List<News>, NoDataException>> {

    override suspend fun execute(): OpResult<List<News>, NoDataException> =
        when (val dataResponse = newsDataSource.getNews()) {
            is Success -> Success(
                dataResponse.data.map {
                    News(it.title, it.image, it.body)
                })
            is Failure -> Failure(
                NoDataException()
            )
        }
}
