<template>
  <div class="category">
    <v-breadcrumbs divider="/">
      <v-breadcrumbs-item
        v-for="item in breadcrumbs" :key="item.text"
        :disabled="item.disabled" :to="item.to" :exact=true
      >
        {{ item.text }}
      </v-breadcrumbs-item>
    </v-breadcrumbs>
    <h3>{{ category.name }}</h3>
    <v-container fluid grid-list-md>
      <v-layout row wrap>
        <v-flex v-for="item in products" xs12 sm6 md4>
          <v-card>
            <v-card-media :src="item.image_url" height="300px">
            </v-card-media>

            <v-card-title primary-title>
              <div>
                <router-link tag="h3" class="headline mb-0" :to="'/product/'+item.id">{{item.name}}
                </router-link>
                <h6>${{item.price}}</h6>
              </div>
            </v-card-title>
            <v-card-actions>
              <v-btn flat class="orange--text" :to="'/product/'+item.id">Details</v-btn>
              <v-btn flat class="blue--text" @click="addToCart(item)">Add to cart</v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>

      </v-layout>
    </v-container>
  </div>
</template>

<script>
  /* eslint-disable spaced-comment */

  import { mapGetters } from 'vuex'
  export default {
    name: 'category',
    computed: {
      breadcrumbs: function () {
        return [
          {
            text: 'Home',
            disabled: false,
            to: '/home'
          },
          {
            text: this.categoryName,
            disabled: false,
            to: '/category/' + this.$route.params.categoryId
          }
        ]
      },
      products: function () {
        return this.allProducts.filter(p => p.category_id === parseInt(this.$route.params.categoryId))
      },
      category: function () {
        return this.allCategories.find(p => p.id === parseInt(this.$route.params.categoryId))
      },
      categoryName: function () {
        let cat = this.allCategories.find(p => p.id === parseInt(this.$route.params.categoryId))
        if (typeof cat !== 'undefined') {
          return cat.name
        } else {
          return 'loading'
        }
      },
      ...mapGetters({
        allProducts: 'allProducts',
        allCategories: 'allCategories'
      })
    },
    watch: {
      '$route' (to, from) {
//        this.getProducts()
        /* this.breadcrumbs = [
         {
         text: 'Home',
         disabled: false,
         to: '/home'
         },
         {
         text: 'Category ' + this.$route.params.categoryId,
         disabled: false,
         to: '/category/' + this.$route.params.categoryId
         }
         ]*/
      }
    },
    methods: {
      /*      getProducts: function () {
       if (this.$route.params.categoryId === '2') {
       this.products = [
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
       ]
       } else {
       this.products = [
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
       }
       ]
       }
       },*/
      addToCart: function (item) {
        this.$bus.$emit('add-cart', item)
      }
    },
    beforeMount () {
//      this.getProducts()
    },
    created () {
      this.$store.dispatch('getAllProducts')
      this.$store.dispatch('getAllCategories')
    },
    data () {
      return {
        msg: 'category'/*,
         breadcrumbs: [
         {
         text: 'Home',
         disabled: false,
         to: '/home'
         },
         {
         text: 'Category ' + this.$route.params.categoryId,
         disabled: false,
         to: '/category/' + this.$route.params.categoryId
         }
         ]*//*,
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
