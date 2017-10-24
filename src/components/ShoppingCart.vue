<template>
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
</template>

<script>
  export default {
    components: {
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
          item.count = 1
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
        menu: false,
        carts: [],
        total: 0
      }
    }
  }
</script>
