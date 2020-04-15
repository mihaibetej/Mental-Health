package com.db.mobile.mental_health.domain.usecases

import com.db.mobile.mental_health.data.datasource.DailyAdvicesDataSource
import com.db.mobile.mental_health.domain.exceptions.NoDataException
import com.db.mobile.mental_health.domain.model.Advice
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.NoInputUseCase
import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.templates.Success
import javax.inject.Inject

class GetAdvicesUseCase @Inject constructor(private val dailyAdvicesDataSource: DailyAdvicesDataSource) :
    NoInputUseCase<OpResult<List<Advice>, NoDataException>>{

    override suspend fun execute(): OpResult<List<Advice>, NoDataException> =
        when (val response = dailyAdvicesDataSource.getAdvices()) {
            is Success -> Success(
                response.data.map {
                    Advice(it.body, it.creationDate, it.publishDate)
                }
            )
            is Failure -> Failure(
                NoDataException()
            )
        }
}