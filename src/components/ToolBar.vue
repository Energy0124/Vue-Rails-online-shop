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
    <v-toolbar-title v-text="title"></v-toolbar-title>
    <v-toolbar-items>
      <v-btn dark
             to="/login"
      >
        Login
      </v-btn>
    </v-toolbar-items>
    <v-toolbar-items>
      <v-btn dark
        to="/admin"
      >
        Admin
      </v-btn>
    </v-toolbar-items>
    <v-spacer></v-spacer>


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
  export default {
    components: {
      ShoppingCart
    },
    data () {
      return {
        drawer: true,
        title: 'IERG4210'
      }
    }
  }
</script>

<style scoped>
  .admin-btn {

  }
</style>
