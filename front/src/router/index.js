import Vue from 'vue'
import Router from 'vue-router'


/* Layout */
import Layout from '../views/layout/AppLayout'

import index from '../views/Index'
import profile from '../views/Profile'
import shares from '../views/Shares'
import archive from '../views/Archive'
import postDetail from '../views/PostDetail'
import tagContent from '../views/TagContent'

Vue.use(Router)


export const constantRouterMap=[
  // { path: '/login', component: () => import('@/views/login/index'), hidden: true },
  // { path: '/404', component: () => import('@/views/404'), hidden: true },
    {
      path: '/',
      component: Layout,
      redirect: '/index',
      children: [
        {
        path: 'index',
        name: 'index',
        component: index
        },
        {
          path: '/index/:topage',
          name: 'pageRouter',
          component: index,
          props: true
        },
        {
          path: '/postDetail/:url',
          name: 'postDetail',
          component: postDetail,
          props: false
        },
        {
          path: '/archive',
          name: 'archive',
          component: archive
        },
        {
          path: '/shares',
          name: 'shares',
          component: shares
        },
        {
          path: '/tag/:tag/:topage?',
          name: 'tagContent',
          component: tagContent,
          props: true
        },
        {
          path: '/profile',
          name: 'profile',
          component: profile
        },
      ]
    }
]



export default new Router({
  mode: 'history', //后端支持可开
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRouterMap
})
