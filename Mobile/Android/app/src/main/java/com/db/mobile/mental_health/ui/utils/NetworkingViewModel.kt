package com.db.mobile.mental_health.ui.utils

import android.view.View
import androidx.databinding.BaseObservable
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.db.mobile.mental_health.R

abstract class NetworkingViewModel : BaseObservable() {
    val loadingStatus = MutableLiveData<LoadingOverlayView.State>()

    abstract fun doRetry()
}

fun View.prepareNetworkingView(lifecycleOwner: LifecycleOwner, networkingViewModel: NetworkingViewModel) {
    val loadingOverlay = findViewById<LoadingOverlayView>(R.id.loadingOverlay)
    loadingOverlay.prepareNetworkingView(lifecycleOwner, networkingViewModel)
}

fun LoadingOverlayView.prepareNetworkingView(lifecycleOwner: LifecycleOwner, networkingViewModel: NetworkingViewModel) {
    retryListener = {
        networkingViewModel.doRetry()
    }
    networkingViewModel.loadingStatus.observe(lifecycleOwner, Observer {
        setState(it)
    })
}
