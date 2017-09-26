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
    <h1>{{ msg }}</h1>
    <v-card>
      <v-card-media :src="item.src" height="550px">
      </v-card-media>
      <router-link tag="v-card-media" to="/home" :src="item.src" height="300px">
      </router-link>
      <v-card-title primary-title>
        <div>
          <h3 class="headline mb-0">{{item.name}}</h3>
          <div>{{item.desc}}</div>
          <b>${{item.price}}</b>
        </div>
      </v-card-title>
      <v-card-actions>

        <v-btn flat class="blue--text">Add to cart</v-btn>
      </v-card-actions>
    </v-card>
  </div>
</template>

<script>
export default {
  name: 'product',
  watch: {
    '$route' (to, from) {
      this.breadcrumbs = [
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
      ]
    }
  },
  data () {
    return {
      msg: 'product',
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
        },
        {
          text: 'Product ' + this.$route.params.productId,
          disabled: false,
          to: '/category/' + this.$route.params.categoryId + '/product/' + this.$route.params.productId
        }
      ],
      item: {
        id: 1,
        category: 1,
        src: '/static/products/1.jpg',
        name: 'p1',
        desc: 'test',
        price: 10,
        to: '/category/1/product/1'
      },
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
