package com.db.mobile.mental_health.data.datasource

import com.db.mobile.mental_health.data.model.DailyAdvice
import com.db.mobile.mental_health.templates.OpResult

interface DailyAdvicesDataSource {
    suspend fun getAdvices(): OpResult<List<DailyAdvice>, NoAdvicesException>
}

class NoAdvicesException : Throwable()