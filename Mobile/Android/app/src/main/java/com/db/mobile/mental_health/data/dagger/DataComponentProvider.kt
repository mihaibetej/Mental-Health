package com.db.mobile.mental_health.data.dagger

object DataComponentProvider {
    private var component: DataComponent? = null

    fun get(): DataComponent {
        if (component == null) {
            component = DaggerDataComponent.create()
        }
        return component!!
    }

    fun clear() {
        component = null
    }

}
