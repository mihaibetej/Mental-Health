package com.db.mobile.mental_health.ui.advices

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class AdvicesViewModel : ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = "This is advices Fragment"
    }
    val text: LiveData<String> = _text
}