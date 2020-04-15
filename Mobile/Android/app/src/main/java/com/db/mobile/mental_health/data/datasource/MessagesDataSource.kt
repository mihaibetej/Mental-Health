package com.db.mobile.mental_health.data.datasource

import com.db.mobile.mental_health.data.model.Message
import com.db.mobile.mental_health.templates.OpResult

interface MessagesDataSource {
    suspend fun getMessages(): OpResult<List<Message>, NoMessagesException>
}

class NoMessagesException : Throwable()