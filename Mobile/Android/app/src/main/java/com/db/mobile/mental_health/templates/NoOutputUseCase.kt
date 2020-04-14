package com.db.mobile.mental_health.templates

interface NoOutputUseCase<in I> {
    suspend fun execute(input: I)
}
