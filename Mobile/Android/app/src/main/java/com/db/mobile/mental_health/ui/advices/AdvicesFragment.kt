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
import kotlinx.android.synthetic.main.fragment_advices.*

class AdvicesFragment : Fragment() {

    private lateinit var advicesViewModel: AdvicesViewModel

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        advicesViewModel =
                ViewModelProviders.of(this).get(AdvicesViewModel::class.java)
        val root = inflater.inflate(R.layout.fragment_advices, container, false)
//        val textView: TextView = root.findViewById(R.id.text_advices)
        advicesViewModel.text.observe(viewLifecycleOwner, Observer {
            text_advices.text = it
        })
        return root
    }
}
