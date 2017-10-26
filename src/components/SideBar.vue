<template>
  <v-navigation-drawer
    persistent
    :clipped=true
    v-model="drawer"
    enable-resize-watcher
  >
    <v-list>
      <v-list-tile
        value="true"
        v-for="(item, i) in categories"
        :key="i"
        :to="'/category/'+item.id"
      >
        <v-list-tile-action>
          <v-icon light>{{item.icon}}</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title v-text="item.name"></v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
  import {mapGetters} from 'vuex'
  export default {
    computed: mapGetters({
      categories: 'allCategories'
    }),
    components: {
    },
    methods: {
    },
    created () {
      this.$store.dispatch('getAllCategories')
    },
    data () {
      return {
        clipped: true,
        drawer: true,
        fixed: false,
        items: [
          {icon: 'bubble_chart', title: 'Category1', href: '/category/1'},
          {icon: 'bubble_chart', title: 'Category2', href: '/category/2'},
          {icon: 'bubble_chart', title: 'Category3', href: '/category/3'},
          {icon: 'bubble_chart', title: 'Category4', href: '/category/4'}
        ],
        miniVariant: false
      }
    }
  }
</script>
