import { createRouter, createWebHistory } from 'vue-router'
import MainView from '../views/MainView.vue'

const routes = [
    // --------------------------------------------------------------------------
    // HOME
    // --------------------------------------------------------------------------
        {
        path: '/',
        name: 'home',
        component: MainView
        },

    // --------------------------------------------------------------------------
    // TRANSFER
    // --------------------------------------------------------------------------
        {
        path: '/transfer',
        name: 'transfer',
        component: () => import('../views/TransferView.vue')
        },
    ]
    

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
    })

export default router
