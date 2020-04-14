package com.db.mobile.mental_health.application.dagger

import android.content.Context
import dagger.Module
import dagger.Provides

@Module
class ContextModule(val context: Context) {
    @Provides
    fun provideContext() = context
}
