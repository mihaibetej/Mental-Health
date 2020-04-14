package com.db.mobile.mental_health.domain.dagger

import com.db.mobile.mental_health.data.dagger.DataComponentProvider

object DomainComponentProvider {
    private var component: DomainComponent? = null

    fun get(): DomainComponent {
        if (component == null) {
            component = DaggerDomainComponent
                .builder()
                .dataComponent(DataComponentProvider.get())
                .build()
        }
        return component!!
    }

    fun clear() {
        component = null
    }
}
