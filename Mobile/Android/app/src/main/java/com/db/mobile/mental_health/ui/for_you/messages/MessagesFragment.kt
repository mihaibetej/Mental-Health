package com.db.mobile.mental_health.ui.for_you.messages

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.RecyclerView
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.application.dagger.getApplicationComponent
import com.db.mobile.mental_health.databinding.FragmentMessagesBinding
import com.db.mobile.mental_health.ui.utils.DividerItemDecoration
import javax.inject.Inject

class MessagesFragment : Fragment() {

    private var messagesFragmentComponent: MessagesFragmentComponent? = null

    @Inject
    lateinit var viewModel: MessagesViewModel

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        messagesFragmentComponent = getApplicationComponent(context)?.messagesFragmentComponent()?.create()
        messagesFragmentComponent?.inject(this)

        val adapter = MessagesAdapter()
        viewModel.messages.observe(viewLifecycleOwner, Observer {
            adapter.items.addAll(it)
            adapter.notifyDataSetChanged()
        })

        val binding: FragmentMessagesBinding =
            DataBindingUtil.inflate(inflater, R.layout.fragment_messages, container, false)
        binding.adapter = adapter
        binding.viewModel = viewModel
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val dividerItemDecoration = DividerItemDecoration(context, R.drawable.list_divider)
        val recyclerView = view.findViewById<RecyclerView>(R.id.messages_recycler_view)
        recyclerView.addItemDecoration(dividerItemDecoration)
    }
}
