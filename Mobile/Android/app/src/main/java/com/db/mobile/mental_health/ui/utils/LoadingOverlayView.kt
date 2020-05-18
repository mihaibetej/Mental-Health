package com.db.mobile.mental_health.ui.utils

import android.content.Context
import android.util.AttributeSet
import android.view.View
import androidx.constraintlayout.widget.ConstraintLayout
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.ui.utils.LoadingOverlayView.State.*
import kotlinx.android.synthetic.main.loading_overlay.view.*

class LoadingOverlayView : ConstraintLayout {
    var retryListener: (() -> Unit)? = null

    constructor(context: Context) : this(context, null)
    constructor(context: Context, attrs: AttributeSet?) : this(context, attrs, 0)
    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int)
            : super(context, attrs, defStyleAttr) {
        inflate(context, R.layout.loading_overlay, this)
        retryButton.setOnClickListener {
            retryListener?.invoke()
        }
    }

    fun setState(state: State) {
        when (state) {
            DISMISS -> changeState(View.GONE, View.GONE, View.GONE)
            LOADING -> changeState(View.VISIBLE, View.VISIBLE, View.GONE)
            RETRY -> changeState(View.VISIBLE, View.GONE, View.VISIBLE)
        }
    }

    private fun changeState(selfVisibility: Int, loadingVisibility: Int, retryVisibility: Int) {
        visibility = selfVisibility
        loadingProgressBar.visibility = loadingVisibility
        retryButton.visibility = retryVisibility
    }

    enum class State {
        DISMISS, LOADING, RETRY
    }

}
