package com.db.mobile.mental_health.ui.news

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import androidx.databinding.DataBindingUtil
import androidx.navigation.findNavController
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.databinding.ItemNewsBinding
import com.db.mobile.mental_health.domain.model.News

class NewsAdapter(var viewModel: NewAdapterViewModel = NewAdapterViewModel()) :
    RecyclerView.Adapter<Holder>() {
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
        holder.bind(items[position], viewModel)
    }
}

class Holder(val binding: ItemNewsBinding) : RecyclerView.ViewHolder(binding.root) {
    private val image: ImageView = itemView.findViewById(R.id.news_item_image)

    fun bind(news: News, viewModel: NewAdapterViewModel) {
        binding.item = news
        binding.viewModel = viewModel
        Glide.with(itemView)
            .load(news.img)
            .centerCrop()
            .into(image)
    }

}

class NewAdapterViewModel {

    fun showNewsDetails(view: View, news: News) {
        val action =
            NewsFragmentDirections.actionNavigationNewsToNewsDetailsFragment(news, news.title ?: "")
        view.findNavController().navigate(action)
    }
}
