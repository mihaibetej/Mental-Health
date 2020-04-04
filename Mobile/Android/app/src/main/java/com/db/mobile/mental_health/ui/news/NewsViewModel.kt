package com.db.mobile.mental_health.ui.news

import android.os.Handler
import androidx.databinding.BaseObservable
import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import com.db.mobile.mental_health.BR
import com.db.mobile.mental_health.domain.model.News
import javax.inject.Inject

class NewsViewModel @Inject constructor() : BaseObservable() {
    val news = MutableLiveData<List<News>>()

    var showNews: Boolean? = false
        @Bindable
        get
        @Bindable
        set(value) {
            if (field != value) {
                field = value
                notifyPropertyChanged(BR.showNews)
            }
        }

    init {
        Handler().postDelayed(
            {
                news.value = listOf(
                    News("Mental health plummets", "https://www.timesnewroman.ro/files/attach/images/127/746107/nea_costel_fabrica.jpg", "Bacon ipsum dolor amet jowl ball tip hamburger burgdoggen. Strip steak tail beef ribs meatloaf meatball brisket pork belly jerky biltong, cow frankfurter shank ham venison. Pork loin salami shank jowl beef ribs. Meatball hamburger kevin turkey pig pork chop, sausage short ribs turducken ribeye beef. Buffalo turducken kevin pastrami capicola tenderloin strip steak pork loin fatback pork chop pancetta meatball shank. Kielbasa tenderloin filet mignon shankle tail ground round pancetta bacon. Bresaola capicola strip steak t-bone turkey cow."),
                    News("Corona fears is irish pubs", "https://www.timesnewroman.ro/files/attach/images/127/746107/nea_costel_fabrica.jpg", "Bacon ipsum dolor amet jowl ball tip hamburger burgdoggen. Strip steak tail beef ribs meatloaf meatball brisket pork belly jerky biltong, cow frankfurter shank ham venison. Pork loin salami shank jowl beef ribs. Meatball hamburger kevin turkey pig pork chop, sausage short ribs turducken ribeye beef. Buffalo turducken kevin pastrami capicola tenderloin strip steak pork loin fatback pork chop pancetta meatball shank. Kielbasa tenderloin filet mignon shankle tail ground round pancetta bacon. Bresaola capicola strip steak t-bone turkey cow."),
                    News("Click here to find out how to make six packs in quarantine", "https://www.timesnewroman.ro/files/attach/images/127/746107/nea_costel_fabrica.jpg", "Bacon ipsum dolor amet jowl ball tip hamburger burgdoggen. Strip steak tail beef ribs meatloaf meatball brisket pork belly jerky biltong, cow frankfurter shank ham venison. Pork loin salami shank jowl beef ribs. Meatball hamburger kevin turkey pig pork chop, sausage short ribs turducken ribeye beef. Buffalo turducken kevin pastrami capicola tenderloin strip steak pork loin fatback pork chop pancetta meatball shank. Kielbasa tenderloin filet mignon shankle tail ground round pancetta bacon. Bresaola capicola strip steak t-bone turkey cow.")
                )
                showNews = true
            }, 800
        )
    }

}
