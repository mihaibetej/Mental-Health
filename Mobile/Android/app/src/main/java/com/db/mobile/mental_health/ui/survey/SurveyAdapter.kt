package com.db.mobile.mental_health.ui.survey

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.SeekBar
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.db.mobile.mental_health.R
import com.db.mobile.mental_health.ui.survey.model.SurveyQuestion

private const val TYPE_HEADER = 0
private const val TYPE_QUESTION = 1
private const val TYPE_FOOTER = 2

class SurveyAdapter : RecyclerView.Adapter<RecyclerView.ViewHolder>() {
    val items = mutableListOf<SurveyQuestion>()
    var surveyAnswerChanged: ((SurveyQuestion, Int) -> Unit)? = null
    var submitSurvey: (() -> Unit)? = null

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return when (viewType) {
            TYPE_HEADER -> HeaderViewHolder(
                LayoutInflater.from(parent.context)
                    .inflate(R.layout.item_survey_header, parent, false)
            )
            TYPE_FOOTER -> FooterHolder(
                LayoutInflater.from(parent.context)
                    .inflate(R.layout.item_survey_footer, parent, false)
            )
            else -> QuestionHolder(
                LayoutInflater.from(parent.context)
                    .inflate(R.layout.item_survey_question, parent, false)
            )
        }
    }

    override fun getItemCount(): Int = items.size + 2

    override fun getItemViewType(position: Int): Int = when (position) {
        0 -> TYPE_HEADER
        itemCount - 1 -> TYPE_FOOTER
        else -> TYPE_QUESTION
    }


    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) =
        when (position) {
            0 -> {
                val viewHolder = holder as HeaderViewHolder
                viewHolder.title.setText(R.string.survey_description)
            }
            itemCount - 1 -> {
                val viewHolder = holder as FooterHolder
                viewHolder.bind(submitSurvey)
            }
            else -> {
                val viewHolder = holder as QuestionHolder
                viewHolder.bind(items[position - 1], surveyAnswerChanged)
            }
        }

}

class HeaderViewHolder(content: View) : RecyclerView.ViewHolder(content) {
    val title: TextView = itemView.findViewById(R.id.survey_header)
}

class QuestionHolder(content: View) : RecyclerView.ViewHolder(content) {
    private val title: TextView = itemView.findViewById(R.id.survey_question)
    private val answer: SeekBar = itemView.findViewById(R.id.survey_answer_scale)

    fun bind(question: SurveyQuestion, surveyAnswerChanged: ((SurveyQuestion, Int) -> Unit)?) {
        title.text = question.question
        answer.progress = question.answer
        answer.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(
                seekBar: SeekBar?,
                progress: Int,
                fromUser: Boolean
            ) {
                question.answer = progress
                surveyAnswerChanged?.invoke(question, progress)
            }

            override fun onStartTrackingTouch(seekBar: SeekBar?) {
            }

            override fun onStopTrackingTouch(seekBar: SeekBar?) {
            }
        })
    }

}

class FooterHolder(content: View) : RecyclerView.ViewHolder(content) {
    private val submit: TextView = itemView.findViewById(R.id.survey_submit)

    fun bind(submitSurvey: (() -> Unit)?) = submit.setOnClickListener {
        submitSurvey?.invoke()
    }
}
