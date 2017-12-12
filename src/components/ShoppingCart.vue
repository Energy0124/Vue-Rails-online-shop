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

        <v-list-tile v-for="(item, index) in carts">
          <v-btn flat icon color="pink" v-on:click="removeFromCart(index)">
            <v-icon>delete
            </v-icon>
          </v-btn>
          <v-list-tile-title>{{item.name}}</v-list-tile-title>
          <v-list-tile-action>
            <v-text-field class="item-count"
                          type="number"
                          min="1"
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
        <!--<v-btn primary flat @click="menu = false">Checkout</v-btn>-->
        <div id="myContainerElement" @click="clearCart"></div>
      </v-card-actions>
    </v-card>
  </v-menu>
</template>

<script>
  export default {
    components: {},
    localStorage: {
      carts: {
        type: Array,
        default: []
      }
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
        this.updateCart()
      })
      this.carts = this.$localStorage.get('carts')
      this.updateCart()
    },
    updated () {
      let carts = JSON.stringify(this.carts)
      let clearCart = this.clearCart
      if (this.firstRender) {
//        let ajax = this.$http
//        console.log(carts)
        window.paypal.Button.render({

          client: {
            sandbox: 'AbvYt9vTE8tqnzfvFRJRrrUMSGA15Mn8bBfQGGf2H4Eqwz0QlFH4ZmV3HBbKEGe_2gN37QKLlX9rG1yK',
            production: 'AbvYt9vTE8tqnzfvFRJRrrUMSGA15Mn8bBfQGGf2H4Eqwz0QlFH4ZmV3HBbKEGe_2gN37QKLlX9rG1yK'
          },
          // Set up a getter to create a Payment ID using the payments api, on your server side:
          env: 'sandbox', // sandbox | production

          // Show the buyer a 'Pay Now' button in the checkout flow
          commit: true,
//          payment: function (data, actions) {
//            return actions.payment.create({
//              payment: {
//                transactions: [{
//                  amount: {
//                    total: '1.00',
//                    currency: 'USD'
//                  }
//                }]
//              }
//            })
//          },
          payment: function (data, actions) {
            clearCart()
            return actions.request.post(window.apiRoot + 'payments/create', [carts])
              .then(function (res) {
//                console.log(res.id)
                return res.id
              })
          },
//            function () {
//            return new window.paypal.Promise(function (resolve, reject) {
//              // Make an ajax call to get the Payment ID. This should call your back-end,
//              // which should invoke the PayPal Payment Create api to retrieve the Payment ID.
//
//              // When you have a Payment ID, you need to call the `resolve` method, e.g `resolve(data.paymentID)`
//              // Or, if you have an error from your server side, you need to call `reject`, e.g. `reject(err)`
//              ajax.post('payments/create', {})
//                .then((response) => { return response.id }, (response) => { return response })
//            })
//          },

          // Pass a function to be called when the customer approves the payment,
          // then call execute payment on your server:

          onAuthorize: function (data, actions) {
            console.log('The payment was authorized!')
            console.log('Payment ID = ', data.paymentID)
            console.log('PayerID = ', data.payerID)

            // At this point, the payment has been authorized, and you will need to call your back-end to complete the
            // payment. Your back-end should invoke the PayPal Payment Execute api to finalize the transaction.
            return actions.payment.execute().then(function (payment) {
              console.log('Payment completed:', payment)
            })
          },
          // Pass a function to be called when the customer cancels the payment

          onCancel: function (data) {
            console.log('The payment was cancelled!')
            console.log('Payment ID = ', data.paymentID)
          }

        }, '#myContainerElement')
        this.firstRender = false
      }
    },
    methods: {
      updateCart: function () {
        this.total = 0
        for (let k in this.carts) {
          if (this.carts[k].count < 1) {
            this.carts[k].count = 1
          }
          this.total += this.carts[k].price * this.carts[k].count
        }
        this.$localStorage.set('carts', this.carts)
      },
      clearCart: function () {
        this.carts = []
        this.updateCart()
      },
      removeFromCart: function (index) {
        this.carts.splice(index, 1)
        this.updateCart()
      }
    },
    data () {
      return {
        menu: false,
        carts: [],
        total: 0,
        firstRender: true
      }
    }
  }
</script>
