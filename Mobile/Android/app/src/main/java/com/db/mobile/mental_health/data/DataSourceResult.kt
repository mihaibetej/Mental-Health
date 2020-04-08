package com.db.mobile.mental_health.data

sealed class DataSourceResult<out D, out E : Throwable>

data class Success<out D>(val data: D) : DataSourceResult<D, Nothing>()

data class Failure<out E : Throwable>(val error: E) : DataSourceResult<Nothing, E>()
