package com.db.mobile.mental_health.ui.advices

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import kotlinx.android.synthetic.main.fragment_advices.*
import javax.inject.Inject

class AdvicesFragment : Fragment() {
    private var advicesComponent: AdvicesComponent? = null

    @Inject
    lateinit var viewModel: AdvicesViewModel

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        advicesComponent = getApplicationComponent(context)?.advicesComponent()?.create()
        advicesComponent?.inject(this)

        val root = inflater.inflate(R.layout.fragment_advices, container, false)
//        val textView: TextView = root.findViewById(R.id.text_advices)
//        advicesViewModel.text.observe(viewLifecycleOwner, Observer {
//            text_advices.text = it
//        })
        return root
    }
}
