<template>
  <div class="product">
    <v-breadcrumbs divider="/">
      <v-breadcrumbs-item
        v-for="item in breadcrumbs" :key="item.text"
        :disabled="item.disabled" :to="item.to" :exact=true
      >
        {{ item.text }}
      </v-breadcrumbs-item>
    </v-breadcrumbs>
 <!--   <h1>{{ msg }}</h1>-->
    <v-flex xs12 sm12 md8>
      <v-card>
        <v-card-media :src="item.image_url" height="500px">
        </v-card-media>
        <router-link tag="v-card-media" to="/home" :src="item.src" height="300px">
        </router-link>
        <v-card-title primary-title>
          <div>
            <h3 class="headline mb-0">{{item.name}}</h3>
            <div>{{item.description}}</div>
            <b>${{item.price}}</b>
          </div>
        </v-card-title>
        <v-card-actions>

          <v-btn flat class="blue--text" @click="addToCart(item)">Add to cart</v-btn>
        </v-card-actions>
      </v-card>
    </v-flex>
  </div>
</template>

<script>
  /* eslint-disable spaced-comment */

  import { mapGetters } from 'vuex'
  export default {
    name: 'product',
    created () {
      this.$store.dispatch('getAllProducts')
    },
    computed: {
      breadcrumbs: function () {
        return [
          {
            text: 'Home',
            disabled: false,
            to: '/home'
          },
          {
            text: 'Category ' + this.item.category_id,
            disabled: false,
            to: '/category/' + this.item.category_id
          },
          {
            text: 'Product ' + this.$route.params.productId,
            disabled: false,
            to: '/product/' + this.$route.params.productId
          }
        ]
      },
      item: function () {
        return this.products.find(p => p.id === (parseInt(this.$route.params.productId, 10)))
      },
      ...mapGetters({
        products: 'allProducts'
      })
    },
    watch: {
      '$route' (to, from) {
//        this.getProduct()
       /* this.breadcrumbs = [
          {
            text: 'Home',
            to: '/home'
          },
          {
            text: 'Category ' + this.$route.params.categoryId,
            to: '/category/' + this.$route.params.categoryId
          },
          {
            text: 'Product ' + this.$route.params.productId,
            to: '/category/' + this.$route.params.categoryId + '/product/' + this.$route.params.productId
          }
        ]*/
      }
    },
    methods: {
      /*      getProduct: function () {
       this.item = this.products[parseInt(this.$route.params.productId, 10) - 1]
       },*/
      addToCart: function (item) {
        this.$bus.$emit('add-cart', item)
      }
    },
    beforeMount () {
//      this.getProduct()
    },
    data () {
      return {
        msg: 'product'/*,
        breadcrumbs: [
          {
            text: 'Home',
            disabled: false,
            to: '/home'
          },
          {
            text: function () {
              return 'Category ' + this.item.category
            },
            disabled: false,
            to: function () {
              return '/category/' + this.item.category
            }
          },
          {
            text: 'Product ' + this.$route.params.productId,
            disabled: false,
            to: '/product/' + this.$route.params.productId
          }
        ]*//*,
         item: {
         id: 1,
         category: 1,
         src: '/static/products/1.jpg',
         name: 'Nanami',
         desc: 'Nanami <3',
         price: 1,
         to: '/category/1/product/1'
         },
         products: [
         {
         id: 1,
         category: 1,
         src: '/static/products/1.jpg',
         name: 'Nanami',
         desc: 'Nanami <3',
         price: 1,
         to: '/category/1/product/1'
         },
         {
         id: 2,
         category: 1,
         src: '/static/products/2.jpg',
         name: 'Touhou',
         desc: 'touhou is great!',
         price: 10,
         to: '/category/1/product/2'
         },
         {
         id: 3,
         category: 1,
         src: '/static/products/3.jpg',
         name: 'Nanami 2',
         desc: 'Nanami in full size',
         price: 100,
         to: '/category/1/product/3'
         },
         {
         id: 4,
         category: 1,
         src: '/static/products/4.jpg',
         name: 'Thinkink',
         desc: 'Nanami thinking',
         price: 1,
         to: '/category/1/product/4'
         },
         {
         id: 5,
         category: 1,
         src: '/static/products/5.jpg',
         name: 'Portal',
         desc: 'Portal  is great!',
         price: 10,
         to: '/category/1/product/5'
         },
         {
         id: 6,
         category: 1,
         src: '/static/products/6.jpg',
         name: 'Nanami 3',
         desc: 'Nanami 3 in full size',
         price: 100,
         to: '/category/1/product/6'
         },
         {
         id: 7,
         category: 2,
         src: '/static/products/7.jpg',
         name: 'Nanami',
         desc: 'Nanami <3',
         price: 1,
         to: '/category/2/product/7'
         },
         {
         id: 8,
         category: 2,
         src: '/static/products/8.jpg',
         name: 'Touhou',
         desc: 'touhou is great!',
         price: 10,
         to: '/category/2/product/8'
         },
         {
         id: 9,
         category: 2,
         src: '/static/products/9.jpg',
         name: 'Nanami 2',
         desc: 'Nanami in full size',
         price: 100,
         to: '/category/2/product/9'
         },
         {
         id: 10,
         category: 2,
         src: '/static/products/10.jpg',
         name: 'Thinkink',
         desc: 'Nanami thinking',
         price: 1,
         to: '/category/2/product/10'
         },
         {
         id: 11,
         category: 2,
         src: '/static/products/11.jpg',
         name: 'Portal',
         desc: 'Portal  is great!',
         price: 10,
         to: '/category/2/product/11'
         },
         {
         id: 12,
         category: 2,
         src: '/static/products/12.jpg',
         name: 'Nanami 3',
         desc: 'Nanami 3 in full size',
         price: 100,
         to: '/category/2/product/12'
         }
         ]*/
      }
    }
  }

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  h1, h2 {
    font-weight: normal;
  }

  ul {
    list-style-type: none;
    padding: 0;
  }

  li {
    display: inline-block;
    margin: 0 10px;
  }

  a {
    color: #42b983;
  }
</style>
