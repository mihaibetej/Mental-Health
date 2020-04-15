package com.db.mobile.mental_health.ui.advices

import androidx.databinding.BaseObservable
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.db.mobile.mental_health.domain.usecases.GetAdvicesUseCase
import javax.inject.Inject

class AdvicesViewModel @Inject constructor(private val getAdvicesUseCase: GetAdvicesUseCase) :
    BaseObservable() {

}