package com.db.mobile.mental_health.templates

interface NoInputUseCase<out O> {
    suspend fun execute(): O
}
