<template>
  <v-toolbar fixed>
    <v-toolbar-side-icon @click.stop="drawer = !drawer" light></v-toolbar-side-icon>
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
    <v-spacer></v-spacer>
    <v-menu
      open-on-hover
      offset-x
      :close-on-content-click="false"
      :nudge-width="200"
      v-model="menu"
    >

      <div class="" slot="activator">
        <v-toolbar-title>Shopping list: ${{total}}</v-toolbar-title>
      </div>
      <v-card>
        <v-list>
          <v-list-tile>
            <v-list-tile-content>
              <v-list-tile-title>Shopping Cart (Total: ${{total}})</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
        <v-divider></v-divider>
        <v-list>

          <v-list-tile v-for="item in carts">
            <v-list-tile-title>{{item.name}}</v-list-tile-title>
            <v-list-tile-action>
              <v-text-field class="item-count"
                            type="number"
                            name="count"
                            v-model="item.count"
                            @input="updateCart"
              ></v-text-field>
            </v-list-tile-action>
            <span>@${{item.price}}</span>
          </v-list-tile>
        </v-list>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn flat @click="menu = false">Cancel</v-btn>
          <v-btn primary flat @click="menu = false">Checkout</v-btn>
        </v-card-actions>
      </v-card>
    </v-menu>
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
  import VBreadcrumbs from 'vuetify/src/components/VBreadcrumbs/VBreadcrumbs'
  import VTextField from 'vuetify/src/components/VTextField/VTextField'
  import VListTileAction from 'vuetify/src/components/VList/VListTileAction'
  export default {
    components: {
      VListTileAction,
      VTextField,
      VBreadcrumbs
    },
    created () {
      this.$bus.$on('add-cart', (item) => {
        if (!item.hasOwnProperty('count')) {
          item.count = 0
        }
        let x = this.carts.find(x => x.id === item.id)
        if (x) {
          x.count += 1
        } else {
          this.carts.push(item)
        }
        this.total = 0
        for (let k in this.carts) {
          this.total += this.carts[k].price * this.carts[k].count
        }
      })
    },
    methods: {
      updateCart: function () {
        this.total = 0
        for (let k in this.carts) {
          this.total += this.carts[k].price * this.carts[k].count
        }
      }
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
        miniVariant: false,
        right: true,
        rightDrawer: false,
        title: 'IERG4210',
        menu: false,
        carts: [],
        total: 0
      }
    }
  }
</script>
