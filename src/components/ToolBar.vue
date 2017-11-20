<template>
  <v-toolbar dark fixed>
    <v-toolbar-side-icon @click.stop="drawer = !drawer" dark></v-toolbar-side-icon>
    <!--     <v-btn
           icon
           light
           @click.stop="miniVariant = !miniVariant"
         >
           <v-icon v-if="miniVariant">chevron_right</v-icon>
           <v-icon v-else>chevron_left</v-icon>

         </v-btn>-->
    <!--      <v-btn
            icon
            light
            @click.stop="clipped = !clipped"
          >
            <v-icon>web</v-icon>
          </v-btn>-->
    <!--      <v-btn
            icon
            light
            @click.stop="fixed = !fixed"
          >
            <v-icon>remove</v-icon>
          </v-btn>-->

    <!--<breadcrumbs></breadcrumbs>-->
    <v-toolbar-title @click="$router.push({path:'/home'})" v-text="title"></v-toolbar-title>
    <v-toolbar-items v-if="user.roles === null">
      <v-btn dark
             to="/login"
      >
        Login
      </v-btn>
    </v-toolbar-items>
    <v-toolbar-items v-if="user.roles !== null">
      <v-btn dark
             @click="logout"
      >
        Logout
      </v-btn>
    </v-toolbar-items>
    <v-toolbar-items v-if="user.roles === 'admin'">
      <v-btn dark
             to="/admin"
      >
        Admin
      </v-btn>
    </v-toolbar-items>
    <v-spacer></v-spacer>

    <v-toolbar-title v-if="user.roles !== null">{{user.email}}</v-toolbar-title>
    <ShoppingCart></ShoppingCart>
    <!--<v-btn
      icon
      light
      @click.stop="rightDrawer = !rightDrawer"
    >
      <v-icon>menu</v-icon>
    </v-btn>-->
  </v-toolbar>
</template>

<script>
  import ShoppingCart from './ShoppingCart.vue'
  import { mapGetters } from 'vuex'
  export default {
    computed: {
      ...mapGetters({
        user: 'user'
      })
    },
    components: {
      ShoppingCart
    },
    data () {
      return {
        drawer: true,
        title: 'IERG4210'
      }
    },
    methods: {
      logout: function () {
        this.$http.delete('users/logout', {
          headers: {
            Authorization: this.user.auth_token
          }
        })
          .then((response) => {
          }, response => {
          })
        this.$store.dispatch('logout')
        this.$router.push({path: '/login'})
      }
    }
  }
</script>

<style scoped>
  .admin-btn {

  }
</style>
