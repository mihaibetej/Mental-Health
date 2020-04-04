package com.db.mobile.mental_health.ui.news

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.databinding.ItemNewsBinding
import com.db.mobile.mental_health.domain.model.News

class NewsAdapter(var viewModel: NewsViewModel) : RecyclerView.Adapter<Holder>() {
    val items = mutableListOf<News>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): Holder =
        Holder(
            DataBindingUtil.inflate(
                LayoutInflater.from(parent.context),
                R.layout.item_news,
                parent,
                false
            )
        )

    override fun getItemCount(): Int = items.size

    override fun onBindViewHolder(holder: Holder, position: Int) {
        holder.binding.item = items[position]
        holder.binding.viewModel = viewModel
    }
}

class Holder(val binding: ItemNewsBinding) : RecyclerView.ViewHolder(binding.root) {

}
