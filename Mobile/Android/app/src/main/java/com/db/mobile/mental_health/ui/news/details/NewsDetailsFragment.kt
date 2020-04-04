package com.db.mobile.mental_health.ui.news.details

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.navArgs
import com.bumptech.glide.Glide
import com.db.mobile.mental_health.R

class NewsDetailsFragment : Fragment() {
    private val args: NewsDetailsFragmentArgs by navArgs()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val root = inflater.inflate(R.layout.fragment_news_details, container, false)
        root.findViewById<TextView>(R.id.news_details_body).text = args.news.body
        val imageView: ImageView = root.findViewById(R.id.news_details_image)
        Glide.with(this)
            .load(args.news.img)
            .centerCrop()
            .into(imageView)
        return root
    }

}
