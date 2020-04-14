package com.db.mobile.mental_health.ui.survey

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.databinding.ItemSurveyFooterBinding
import com.db.mobile.mental_health.databinding.ItemSurveyQuestionBinding
import com.db.mobile.mental_health.domain.model.SurveyQuestion

private const val TYPE_HEADER = 0
private const val TYPE_QUESTION = 1
private const val TYPE_FOOTER = 2

class SurveyAdapter(val viewModel: SurveyViewModel) :
    RecyclerView.Adapter<RecyclerView.ViewHolder>() {
    val items = mutableListOf<SurveyQuestion>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return when (viewType) {
            TYPE_HEADER -> HeaderViewHolder(
                LayoutInflater.from(parent.context)
                    .inflate(R.layout.item_survey_header, parent, false)
            )
            TYPE_FOOTER -> {
                val binding = DataBindingUtil.inflate<ItemSurveyFooterBinding>(
                    LayoutInflater.from(parent.context),
                    R.layout.item_survey_footer,
                    parent,
                    false
                )
                FooterHolder(binding)
            }
            else -> {
                val binding = DataBindingUtil.inflate<ItemSurveyQuestionBinding>(
                    LayoutInflater.from(parent.context),
                    R.layout.item_survey_question,
                    parent,
                    false
                )
                QuestionHolder(binding)
            }
        }
    }

    override fun getItemCount(): Int = items.size + 2

    override fun getItemViewType(position: Int): Int = when (position) {
        0 -> TYPE_HEADER
        itemCount - 1 -> TYPE_FOOTER
        else -> TYPE_QUESTION
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) =
        when (getItemViewType(position)) {
            TYPE_HEADER -> {
                val viewHolder = holder as HeaderViewHolder
                viewHolder.title.setText(R.string.survey_description)
            }
            TYPE_FOOTER -> {
                val viewHolder = holder as FooterHolder
                viewHolder.bind(viewModel)
            }
            else -> {
                val viewHolder = holder as QuestionHolder
                viewHolder.bind(items[position - 1], viewModel)
            }
        }

}

class HeaderViewHolder(content: View) : RecyclerView.ViewHolder(content) {
    val title: TextView = itemView.findViewById(R.id.survey_header)
}

class QuestionHolder(var binding: ItemSurveyQuestionBinding) : RecyclerView.ViewHolder(binding.root) {

    fun bind(question: SurveyQuestion, viewModel: SurveyViewModel) {
        binding.item = question
        binding.viewModel = viewModel
    }
}

class FooterHolder(var binding: ItemSurveyFooterBinding) : RecyclerView.ViewHolder(binding.root) {

    fun bind(viewModel: SurveyViewModel) {
        binding.viewModel = viewModel
    }
}
