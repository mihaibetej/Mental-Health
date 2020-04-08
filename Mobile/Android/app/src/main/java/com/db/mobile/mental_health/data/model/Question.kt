package com.db.mobile.mental_health.data.model

data class Question(val body: String, val answers: List<Answer>)

data class Answer(val title: String, val value: Int)
