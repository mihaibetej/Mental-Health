package com.db.mobile.mental_health.templates

interface BidirectionalMapper<I, O> {
    fun map(input: I): O
    fun revert(input: O): I
}
