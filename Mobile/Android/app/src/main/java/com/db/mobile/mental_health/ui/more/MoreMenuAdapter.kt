package com.db.mobile.mental_health.ui.more

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.RecyclerView

class MoreMenuAdapter : RecyclerView.Adapter<ViewHolder>() {
    val items = mutableListOf<String>()
    val callback: ((Int) -> Unit)? = null

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder =
        ViewHolder(
            LayoutInflater.from(parent.context)
                .inflate(android.R.layout.simple_list_item_1, parent, false)
        )

    override fun getItemCount(): Int = items.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.text.text = items[position]

        holder.text.setTextColor(
            ContextCompat.getColor(
                holder.text.context,
                android.R.color.tab_indicator_text
            )
        )
        holder.text.textSize = 16F
        holder.itemView.setOnClickListener {
            callback?.invoke(position)
        }
    }
}

class ViewHolder(content: View) : RecyclerView.ViewHolder(content) {
    val text = content as TextView
}
