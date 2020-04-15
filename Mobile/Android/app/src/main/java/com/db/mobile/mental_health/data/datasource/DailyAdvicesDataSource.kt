package com.db.mobile.mental_health.data.datasource

import com.db.mobile.mental_health.data.model.DailyAdvices
import com.db.mobile.mental_health.templates.OpResult

interface DailyAdvicesDataSource {
    suspend fun getAdvices(): OpResult<List<DailyAdvices>, NoAdvicesException>
}

class NoAdvicesException : Throwable()