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
    
    // --------------------------------------------------------------------------
    // BUSINESS REGISTRY
    // --------------------------------------------------------------------------
        {
        path: '/business-registry',
        name: 'business-registry',
        component: () => import('../views/BusinessRegistryView.vue')
        },

    // --------------------------------------------------------------------------
    // CONNECT WALLET
    // --------------------------------------------------------------------------
        {
        path: '/connect-wallet',
        name: 'connect-wallet',
        component: () => import('../views/ConnectWalletView.vue')
        },
    ]
    

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
    })

export default router
