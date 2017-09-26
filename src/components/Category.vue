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
    <h1>{{ msg }}</h1>
    <v-container fluid grid-list-md>
      <v-layout row wrap>
        <v-flex v-for="item in products" xs12 sm6 md4>
          <v-card>
            <v-card-media :src="item.src" height="300px">
            </v-card-media>
            <router-link tag="img" to="/home" :src="item.src" height="300px">
            </router-link>
            <v-card-title primary-title>
              <div>
                <h3 class="headline mb-0">{{item.name}}</h3>
                <b>${{item.price}}</b>
              </div>
            </v-card-title>
            <v-card-actions>
              <v-btn flat class="orange--text" :to="item.to">Details</v-btn>
              <v-btn flat class="blue--text">Add to cart</v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>
        <v-flex xs12 sm6 md4>
          <v-card>
            <v-card-media src="/static/products/2.jpg" height="300px">
            </v-card-media>
            <v-card-title primary-title>
              <div>
                <h3 class="headline mb-0">Kangaroo Valley Safari</h3>
                <div>Located two hours south of Sydney in thejjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjSouthern Highlands of New South Wales, ...</div>
              </div>
            </v-card-title>
            <v-card-actions>
              <v-btn flat class="orange--text">Share</v-btn>
              <v-btn flat class="orange--text">Explore</v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>
        <v-flex xs12 sm6 md4>
          <v-card>
            <v-card-media src="/static/products/3.jpg" height="300px">
            </v-card-media>
            <v-card-title primary-title>
              <div>
                <h3 class="headline mb-0">Kangaroo Valley Safari</h3>
                <div>Located two hours south of Sydney in the <br>Southern Highlands of New South Wales, ...</div>
              </div>
            </v-card-title>
            <v-card-actions>
              <v-btn flat class="orange--text">Share</v-btn>
              <v-btn flat class="orange--text">Explore</v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>
        <v-flex xs12 sm6 md4>
          <v-card>
            <v-card-media src="/static/products/4.jpg" height="300px">
            </v-card-media>
            <v-card-title primary-title>
              <div>
                <h3 class="headline mb-0">Kangaroo Valley Safari</h3>
                <div>Located two hours south of Sydney in the <br>Southern Highlands of New South Wales, ...</div>
              </div>
            </v-card-title>
            <v-card-actions>
              <v-btn flat class="orange--text">Share</v-btn>
              <v-btn flat class="orange--text">Explore</v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>
        <v-flex xs12 sm6 md4>
          <v-card>
            <v-card-media src="/static/products/5.jpg" height="300px">
            </v-card-media>
            <v-card-title primary-title>
              <div>
                <h3 class="headline mb-0">Kangaroo Valley Safari</h3>
                <div>Located two hours south of Sydney in the <br>Southern Highlands of New South Wales, ...</div>
              </div>
            </v-card-title>
            <v-card-actions>
              <v-btn flat class="orange--text">Share</v-btn>
              <v-btn flat class="orange--text">Explore</v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>
        <v-flex xs12 sm6 md4>
          <v-card>
            <v-card-media src="/static/products/6.jpg" height="300px">
            </v-card-media>
            <v-card-title primary-title>
              <div>
                <h3 class="headline mb-0">Kangaroo Valley Safari</h3>
                <div>Located two hours south of Sydney in the <br>Southern Highlands of New South Wales, ...</div>
              </div>
            </v-card-title>
            <v-card-actions>
              <v-btn flat class="orange--text">Share</v-btn>
              <v-btn flat class="orange--text">Explore</v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
  export default {
    name: 'category',
    watch: {
      '$route' (to, from) {
        this.breadcrumbs = [
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
        ]
      }
    },
    data () {
      return {
        msg: 'category',
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
        ],
        products: [
          {
            id: 1,
            category: 1,
            src: '/static/products/1.jpg',
            name: 'p1',
            desc: 'test',
            price: 10,
            to: '/category/1/product/1'
          },
          {},
          {}
        ]
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
