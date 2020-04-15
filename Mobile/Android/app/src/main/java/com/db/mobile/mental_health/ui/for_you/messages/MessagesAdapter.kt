package com.db.mobile.mental_health.ui.for_you.messages

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.databinding.ItemMessageBinding
import com.db.mobile.mental_health.domain.model.Message

class MessagesAdapter(var viewModel: MessagesAdapterViewModel = MessagesAdapterViewModel()) : RecyclerView.Adapter<Holder>() {
    val items = mutableListOf<Message>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): Holder =
        Holder(
            DataBindingUtil.inflate(
                LayoutInflater.from(parent.context),
                R.layout.item_message,
                parent,
                false
            )
        )

    override fun getItemCount(): Int = items.size

    override fun onBindViewHolder(holder: Holder, position: Int) {
        holder.bind(items[position], viewModel)
    }
}

class Holder(val binding: ItemMessageBinding) : RecyclerView.ViewHolder(binding.root) {

    fun bind(message: Message, viewModel: MessagesAdapterViewModel) {
        binding.item = message
        binding.viewModel = viewModel
    }
}

class MessagesAdapterViewModel {

    fun showMessageDetails(view: View, message: Message) {

    }
}
