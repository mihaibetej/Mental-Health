package com.db.mobile.mental_health.ui.for_you.advices

import androidx.databinding.BaseObservable
import com.db.mobile.mental_health.domain.usecases.GetAdvicesUseCase
import javax.inject.Inject

class AdvicesViewModel @Inject constructor(private val getAdvicesUseCase: GetAdvicesUseCase) :
    BaseObservable() {

}