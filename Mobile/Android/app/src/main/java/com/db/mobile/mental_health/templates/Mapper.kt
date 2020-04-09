package com.db.mobile.mental_health.templates

interface Mapper<in I, out O> {
    fun map(input: I): O
}
