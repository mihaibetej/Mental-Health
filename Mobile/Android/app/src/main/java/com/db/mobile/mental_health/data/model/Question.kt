package com.db.mobile.mental_health.data.model

data class Question(var id: String? = "", val body: String? = "", val answers: List<Answer>? = null)

data class Answer(val title: String? = "", val value: Int? = 0)
