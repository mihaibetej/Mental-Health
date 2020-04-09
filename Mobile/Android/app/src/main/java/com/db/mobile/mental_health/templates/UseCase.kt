package com.db.mobile.mental_health.templates

interface UseCase<in I, out O> {
    suspend fun execute(input: I): O
}
