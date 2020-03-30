package com.db.mobile.mental_health.application.dagger

import android.content.Context
import dagger.Module
import dagger.Provides

@Module
class ApplicationModule (private val context: Context) {

    @Provides
    fun provideContext(): Context {
        return context
    }
}