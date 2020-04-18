package com.db.mobile.mental_health.ui.for_you.advices

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.databinding.ItemAdviceBinding
import com.db.mobile.mental_health.domain.model.Advice

class AdvicesAdapter(var viewModel: AdvicesAdapterViewModel = AdvicesAdapterViewModel()) : RecyclerView.Adapter<Holder>() {
    val items = mutableListOf<Advice>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): Holder =
        Holder(
            DataBindingUtil.inflate(
                LayoutInflater.from(parent.context),
                R.layout.item_advice,
                parent,
                false
            )
        )

    override fun getItemCount(): Int = items.size

    override fun onBindViewHolder(holder: Holder, position: Int) {
        holder.bind(items[position], viewModel)
    }
}

class Holder(val binding: ItemAdviceBinding) : RecyclerView.ViewHolder(binding.root) {

    fun bind(advice: Advice, viewModel: AdvicesAdapterViewModel) {
        binding.item = advice
        binding.viewModel = viewModel
    }
}

class AdvicesAdapterViewModel {

    fun showAdviceDetails(view: View, advice: Advice) {

    }
}
