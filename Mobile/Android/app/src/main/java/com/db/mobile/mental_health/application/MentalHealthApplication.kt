package com.db.mobile.mental_health.application

import android.app.Application
import com.db.mobile.mental_health.application.dagger.ApplicationComponent
import com.db.mobile.mental_health.application.dagger.ApplicationModule
import com.db.mobile.mental_health.application.dagger.DaggerApplicationComponent
import com.db.mobile.mental_health.domain.dagger.DomainComponentProvider

class MentalHealthApplication : Application() {
    lateinit var applicationComponent: ApplicationComponent

    override fun onCreate() {
        super.onCreate()

        applicationComponent = DaggerApplicationComponent
            .builder()
            .domainComponent(DomainComponentProvider.get())
            .applicationModule(
                ApplicationModule(this)
            ).build()
    }
}
