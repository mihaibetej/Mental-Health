package com.db.mobile.mental_health.domain.usecases

import com.db.mobile.mental_health.data.datasource.MessagesDataSource
import com.db.mobile.mental_health.domain.exceptions.NoDataException
import com.db.mobile.mental_health.domain.model.Message
import com.db.mobile.mental_health.templates.Failure
import com.db.mobile.mental_health.templates.NoInputUseCase
import com.db.mobile.mental_health.templates.OpResult
import com.db.mobile.mental_health.templates.Success
import javax.inject.Inject

class GetMessagesUseCase @Inject constructor(private val messagesDataSource: MessagesDataSource) :
    NoInputUseCase<OpResult<List<Message>, NoDataException>>{

    override suspend fun execute(): OpResult<List<Message>, NoDataException> =
        when (val response = messagesDataSource.getMessages()) {
            is Success -> Success(
                response.data.map {
                    Message(it.body, it.creationDate, it.from)
                }
            )
            is Failure -> Failure(
                NoDataException()
            )
        }
}