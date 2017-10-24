<template>
  <v-app light>
    <!--    <v-navigation-drawer
          persistent
          :clipped=true
          v-model="drawer"
          enable-resize-watcher
        >
          <v-list>
            <v-list-tile
              value="true"
              v-for="(item, i) in items"
              :key="i"
              :to="item.href"
            >
              <v-list-tile-action>
                <v-icon light>{{item.icon}}</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title v-text="item.title"></v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list>
        </v-navigation-drawer>-->
    <SideBar></SideBar>
    <ToolBar></ToolBar>
    <main>
      <router-view></router-view>
    </main>
    <!--<v-navigation-drawer
      temporary
      :right="right"
      v-model="rightDrawer"
    >
      <v-list>
        <v-list-tile @click="right = !right">
          <v-list-tile-action>
            <v-icon light>compare_arrows</v-icon>
          </v-list-tile-action>
          <v-list-tile-title>Switch drawer (click me)</v-list-tile-title>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>-->
    <v-footer :fixed="fixed">
      <span>&copy; 2017</span>
    </v-footer>
  </v-app>
</template>

<script>
  import SideBar from './components/SideBar'
  import ToolBar from './components/ToolBar'

  export default {
    components: {
      SideBar,
      ToolBar
    }
  }
</script>

<style scoped>

</style>
