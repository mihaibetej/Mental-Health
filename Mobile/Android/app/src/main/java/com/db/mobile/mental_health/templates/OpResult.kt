package com.db.mobile.mental_health.templates

sealed class OpResult<out D, out E : Throwable>

data class Success<out D>(val data: D) : OpResult<D, Nothing>()

data class Failure<out E : Throwable>(val error: E) : OpResult<Nothing, E>()
