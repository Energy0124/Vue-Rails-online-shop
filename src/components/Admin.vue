<template>
  <v-tabs dark fixed centered>
    <v-tabs-bar class="cyan">
      <v-tabs-slider class="yellow"></v-tabs-slider>
      <v-tabs-item
        v-for="i in items"
        :key="i"
        :href="'#tab-' + i"
      >
        {{ i }}
      </v-tabs-item>
    </v-tabs-bar>
    <v-tabs-items>
      <v-tabs-content
        :id="'tab-' + 'Products'"
      >
        <v-card>
          <v-form :v-model="validProduct" ref="productForm">
            <v-text-field
              label="Name"
              v-model="product.name"
              required
            ></v-text-field>
            <v-text-field
              label="Price"
              v-model="product.price"
              required
            ></v-text-field>
            <v-text-field
              label="Description"
              v-model="product.description"
            ></v-text-field>
            <v-text-field
              label="Image Url"
              v-model="product.image_url"
            ></v-text-field>
            <v-text-field
              label="Category"
              v-model="product.category_id"
              required
            ></v-text-field>
            <v-btn
              @click="submitProduct"
              :disabled="!validProduct"
            >
              submit
            </v-btn>
            <v-btn @click="clear">clear</v-btn>
          </v-form>
        </v-card>
        <v-list>
          <v-list-tile avatar v-for="product in products" v-bind:key="product.name" @click="">
            <v-list-tile-avatar>
              <img v-bind:src="product.image_url"/>
            </v-list-tile-avatar>
            <v-list-tile-content>
              <v-list-tile-title v-text="product.name"></v-list-tile-title>
              <v-list-tile-sub-title>{{ product.id }}</v-list-tile-sub-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-btn icon ripple @click="deleteProduct(product.id)">
                <v-icon color="pink">delete</v-icon>
              </v-btn>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
      </v-tabs-content>
      <v-tabs-content
        :id="'tab-' + 'Categories'"
      >
        <v-card>
          <v-form :v-model="validCategory" ref="categoryForm">
            <v-text-field
              label="Name"
              v-model="category.name"
              required
            ></v-text-field>
            <v-btn
              @click="submitCategory"
              :disabled="!validCategory"
            >
              submit
            </v-btn>
            <v-btn @click="clear">clear</v-btn>
          </v-form>
        </v-card>
        <v-list>
          <v-list-tile avatar v-for="category in categories" v-bind:key="category.name" @click="">
            <v-list-tile-content>
              <v-list-tile-title v-text="category.name"></v-list-tile-title>
              <v-list-tile-sub-title>{{ category.id }}</v-list-tile-sub-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-btn icon ripple @click="deleteCategory(category.id)">
                <v-icon color="pink">delete</v-icon>
              </v-btn>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
      </v-tabs-content>
    </v-tabs-items>
  </v-tabs>
</template>

<script>
  import { mapGetters } from 'vuex'
  export default {
    computed: {
      ...mapGetters({
        products: 'allProducts',
        categories: 'allCategories'
      })
    },
    data () {
      return {
        validProduct: true,
        validCategory: true,
        items: ['Products', 'Categories'],
        product: {},
        category: [],
        update: false
      }
    },
    created () {
      this.$store.dispatch('getAllProducts')
      this.$store.dispatch('getAllCategories')
    },
    methods: {
      deleteProduct (id) {
        this.$http.delete('products/' + id)
          .then((response) => {
            console.log(response)
            this.$store.dispatch('getAllProducts')
          })
      },
      deleteCategory (id) {
        this.$http.delete('categories/' + id)
          .then((response) => {
            console.log(response)
            this.$store.dispatch('getAllCategories')
          })
      },
      submitProduct () {
        if (this.$refs.productForm.validate()) {
          // Native form submission is not yet supported
          this.$http.post('products', {
            name: this.product.name,
            price: this.product.price,
            description: this.product.description,
            category_id: this.product.category_id
          }).then((response) => {
            console.log(response)
            this.$store.dispatch('getAllProducts')
          })
        }
      },
      submitCategory () {
        if (this.$refs.categoryForm.validate()) {
          // Native form submission is not yet supported
          this.$http.post('categories', {
            name: this.category.name
          }).then((response) => {
            console.log(response)
            this.$store.dispatch('getAllCategories')
          })
        }
      },
      clear () {
        this.$refs.form.reset()
      }
    }
  }
</script>

